# Git worktree add helper — see `gwta --help` for usage
#
# Setup:
#   If .worktree-setup exists in the main repo root, it is executed after
#   worktree creation with cwd set to the new worktree.
#   Arguments passed: $1 = main repo path, $2 = worktree path
#
#   Example .worktree-setup:
#     #!/bin/bash
#     main_repo="$1"
#     ln -sf "$main_repo/.envrc" .envrc
#     yarn install

function gwta() {
    local worktree_name=""
    local branch_name=""
    local base_branch=""
    local skip_setup=false
    local auto_confirm=false
    local checkout_mode=false
    local pr_number=""
    local pr_interactive=false
    local -a post_command=()

    while [[ $# -gt 0 ]]; do
        case "$1" in
            -b|--branch)
                if [[ $# -lt 2 ]]; then
                    echo "Error: $1 requires a value"
                    return 1
                fi
                branch_name="$2"; shift 2 ;;
            --base)
                if [[ $# -lt 2 ]]; then
                    echo "Error: $1 requires a value"
                    return 1
                fi
                base_branch="$2"; shift 2 ;;
            -c|--checkout) checkout_mode=true; shift ;;
            --pr)
                # Accept optional PR number or URL; otherwise enter interactive mode
                if [[ $# -ge 2 && "$2" =~ ^([0-9]+|https?://) ]]; then
                    pr_number="$2"; shift 2
                else
                    pr_interactive=true; shift
                fi ;;
            -y|--yes) auto_confirm=true; shift ;;
            --no-setup) skip_setup=true; shift ;;
            -h|--help) _gwta_usage; return 0 ;;
            --) shift; post_command=("$@"); break ;;
            -*) echo "Unknown option: $1"; _gwta_usage; return 1 ;;
            *) worktree_name="$1"; shift ;;
        esac
    done

    if [[ "$checkout_mode" == true && -n "$branch_name" ]]; then
        echo "Error: --checkout and --branch cannot be used together"
        return 1
    fi

    if [[ -n "$pr_number" || "$pr_interactive" == true ]]; then
        if [[ -n "$branch_name" ]]; then
            echo "Error: --pr cannot be used with --branch"
            return 1
        fi
        if [[ -n "$base_branch" ]]; then
            echo "Error: --pr cannot be used with --base"
            return 1
        fi
    fi

    # Resolve main repo (works from main repo or any worktree)
    local git_common_dir
    git_common_dir=$(git rev-parse --git-common-dir 2>/dev/null)
    if [[ -z "$git_common_dir" ]]; then
        echo "Error: Not in a git repository"
        return 1
    fi

    # :A resolves symlinks like realpath(3)
    local main_repo="${git_common_dir:A}"
    main_repo="${main_repo%/.git}"

    local ghq_root
    ghq_root=$(ghq root 2>/dev/null)
    if [[ -z "$ghq_root" || "$main_repo" != "$ghq_root"/* ]]; then
        echo "Error: Not in a ghq-managed repository"
        return 1
    fi

    local rel_path="${main_repo#$ghq_root/}"

    # --- PR resolution (sets base_branch + enables checkout mode) ---
    local pr_auto_name=""
    if [[ -n "$pr_number" || "$pr_interactive" == true ]]; then
        if ! command -v gh >/dev/null 2>&1; then
            echo "Error: gh command not found"
            return 1
        fi

        if [[ "$pr_interactive" == true ]]; then
            local selected
            selected=$( \
                gh pr list --limit 50 --json number,headRefName,title,author \
                    --jq '.[] | "#\(.number)\t[\(.headRefName)]\t@\(.author.login)\t\(.title)"' \
                | peco --prompt "Pull Request>" \
            )
            if [[ -z "$selected" ]]; then
                echo "Error: PR selection cancelled"
                return 1
            fi
            pr_number="${selected%%$'\t'*}"
            pr_number="${pr_number#\#}"
        fi

        local pr_info pr_actual_number pr_branch is_cross_repo
        if ! pr_info=$(gh pr view "$pr_number" \
            --json number,headRefName,isCrossRepository \
            --jq '"\(.number)\t\(.headRefName)\t\(.isCrossRepository)"' 2>&1); then
            echo "Error: Failed to fetch PR information"
            echo "$pr_info"
            return 1
        fi
        IFS=$'\t' read -r pr_actual_number pr_branch is_cross_repo <<< "$pr_info"
        pr_number="$pr_actual_number"

        if [[ "$is_cross_repo" == "true" ]]; then
            echo "Error: PR #$pr_number is from a fork. Cross-repository PRs are not supported."
            return 1
        fi

        # Fetch the PR head so origin/<branch> is available locally
        git fetch origin "$pr_branch" 2>/dev/null

        checkout_mode=true
        base_branch="origin/$pr_branch"

        if [[ -z "$worktree_name" ]]; then
            local sanitized="${pr_branch//\//-}"
            pr_auto_name="pr-${pr_number}-${sanitized}"
            worktree_name="$pr_auto_name"
        fi
    fi

    # --- Branch selection ---
    if [[ -z "$base_branch" ]]; then
        git fetch --prune origin 2>/dev/null

        local default_branch
        default_branch=$(git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null)
        default_branch="${default_branch#refs/remotes/origin/}"
        if [[ -z "$default_branch" ]]; then
            for candidate in main master develop; do
                if git show-ref --verify --quiet "refs/remotes/origin/$candidate" 2>/dev/null; then
                    default_branch="$candidate"
                    break
                fi
            done
        fi

        local peco_prompt
        if [[ "$checkout_mode" == true ]]; then
            peco_prompt="Checkout branch>"
        else
            peco_prompt="Base branch>"
        fi

        base_branch=$( \
            { \
              [[ -n "$default_branch" ]] && echo "origin/$default_branch"; \
              git branch -r --sort=-committerdate \
                | sed 's/^ *//' \
                | grep -v 'HEAD' \
                | grep -v "^origin/${default_branch}$"; \
              git branch --sort=-committerdate \
                | sed 's/^ *//' \
                | sed -E 's/^[*+] //'; \
            } | awk '!seen[$0]++' \
              | peco --prompt "$peco_prompt" \
        )

        if [[ -z "$base_branch" ]]; then
            echo "Error: Branch selection cancelled"
            return 1
        fi
    fi

    # --- Worktree name ---
    if [[ -z "$worktree_name" ]]; then
        if [[ "$checkout_mode" == true ]]; then
            # Derive worktree name from branch: origin/feature/foo → feature-foo
            local derived_name="$base_branch"
            derived_name="${derived_name#origin/}"
            derived_name="${derived_name//\//-}"
            worktree_name="$derived_name"
        elif [[ "$auto_confirm" == true ]]; then
            echo "Error: Worktree name is required"
            return 1
        else
            local date_prefix
            date_prefix=$(date +%Y%m%d)
            echo -n "Worktree name (auto-prefix: ${date_prefix}-): "
            read -r worktree_name
            if [[ -z "$worktree_name" ]]; then
                echo "Error: Worktree name is required"
                return 1
            fi
        fi
    fi

    local branch_base="$worktree_name"
    if [[ -n "$pr_auto_name" ]]; then
        : # PR-derived names keep the pr-<num>-<branch> form without a date prefix
    elif [[ "$worktree_name" =~ ^[0-9]{8}- ]]; then
        branch_base="${worktree_name#[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]-}"
    else
        worktree_name="$(date +%Y%m%d)-${worktree_name}"
    fi

    if [[ "$checkout_mode" != true && -z "$branch_name" ]]; then
        branch_name="feature/${branch_base}"
    fi

    local worktree_path="$HOME/worktrees/${rel_path}/${worktree_name}"

    # --- Post-setup command (prompt interactively unless given via `--` or -y) ---
    if [[ "$auto_confirm" != true && ${#post_command[@]} -eq 0 ]]; then
        echo -n "Run after setup (blank=skip, ':e'=edit in \$EDITOR): "
        local post_command_input
        read -r post_command_input
        if [[ "$post_command_input" == ":e" ]]; then
            local tmpfile
            tmpfile=$(mktemp "${TMPDIR:-/tmp}/gwta-cmd.XXXXXX") || return 1
            "${EDITOR:-vi}" "$tmpfile"
            post_command_input=$(<"$tmpfile")
            rm -f "$tmpfile"
        fi
        if [[ -n "$post_command_input" ]]; then
            # (z) = shell-style word split, (Q) = strip one level of quoting
            post_command=( ${(Q)${(z)post_command_input}} )
        fi
    fi

    echo ""
    if [[ -n "$pr_number" ]]; then
        echo "  PR:       #$pr_number"
    fi
    echo "  Worktree: $worktree_path"
    if [[ "$checkout_mode" == true ]]; then
        echo "  Branch:   $base_branch (checkout)"
    else
        echo "  Branch:   $branch_name"
        echo "  Base:     $base_branch"
    fi
    if (( ${#post_command[@]} > 0 )); then
        echo "  Command:  ${post_command[*]}"
    fi
    echo ""
    if [[ "$auto_confirm" != true ]]; then
        echo -n "Proceed? [Y/n] "
        read -r confirm
        if [[ "$confirm" =~ ^[Nn] ]]; then
            echo "Cancelled"
            return 0
        fi
    fi

    local -a worktree_args=()
    if [[ "$checkout_mode" == true ]]; then
        if [[ "$base_branch" == origin/* ]]; then
            # `git worktree add <path> origin/<branch>` checks out a detached HEAD.
            # Create (or reuse) a local branch so the worktree is on a real branch
            # tracking the remote — required for `gh pr` and pushing to work.
            local local_branch="${base_branch#origin/}"
            if git show-ref --verify --quiet "refs/heads/$local_branch"; then
                worktree_args+=("$worktree_path" "$local_branch")
            else
                worktree_args+=(--track -b "$local_branch" "$worktree_path" "$base_branch")
            fi
        else
            worktree_args+=("$worktree_path" "$base_branch")
        fi
    else
        worktree_args+=(-b "$branch_name")
        # Prevent auto-tracking remote branch to avoid accidental push to e.g. master
        if [[ "$base_branch" == origin/* ]]; then
            worktree_args+=(--no-track)
        fi
        worktree_args+=("$worktree_path" "$base_branch")
    fi
    if ! git worktree add "${worktree_args[@]}"; then
        echo "Error: Failed to create worktree"
        return 1
    fi

    echo ""
    echo "Worktree created successfully."

    if [[ "$skip_setup" != true ]]; then
        _gwta_setup "$main_repo" "$worktree_path"
    fi

    cd "$worktree_path" || return 1
    echo ""
    echo "Ready: $worktree_path"

    if (( ${#post_command[@]} > 0 )); then
        echo ""
        echo "Running: ${post_command[*]}"
        "${post_command[@]}"
    fi
}

function _gwta_usage() {
    cat <<'USAGE'
Usage: gwta [options] [worktree-name] [-- command [args...]]

Create a git worktree under ~/worktrees/<repo>/<date>-<name>.
After creation, cd into the new worktree. A post-setup command can be given
after `--`, or entered at the interactive prompt (type `:e` at the prompt
to open $EDITOR for multi-line input); it runs from inside the worktree
once setup has completed.

Options:
  -b, --branch NAME    Branch name (default: feature/<worktree-name>)
  --base BRANCH        Base branch (default: interactive selection via peco)
  -c, --checkout       Checkout existing branch (no new branch created)
  --pr [NUMBER|URL]    Checkout a Pull Request's head branch into a worktree
                       (omit to pick interactively via `gh pr list`)
  -y, --yes            Skip confirmation prompt
  --no-setup           Skip post-creation setup
  -h, --help           Show this help message

Examples:
  gwta release-drafter                       # interactive
  gwta 20260324-custom-name                  # date prefix preserved
  gwta -b fix/urgent-bug hotfix              # custom branch name
  gwta --base origin/develop new-feature     # remote base
  gwta --base feature/wip new-feature        # local base
  gwta -y --base origin/main my-task         # non-interactive

  # PR review (checkout existing branch):
  gwta -c                                    # interactive branch selection
  gwta -c --base origin/feature/foo          # specify branch directly
  gwta -c --base origin/feature/foo my-name  # custom worktree name

  # PR review by PR number (uses gh; same-repo PRs only):
  gwta --pr 123                              # worktree name: pr-123-<branch>
  gwta --pr                                  # interactive PR selection
  gwta --pr 123 my-name                      # custom worktree name
  gwta --pr 123 -- claude                    # checkout PR + launch claude

  # Run a command after setup (everything after `--` is the command):
  gwta my-task -- claude "foo bar prompt"    # start a Claude Code session
  gwta -c -- claude                          # checkout + launch claude
USAGE
}

function gwtr() {
    local auto_confirm=false
    local force=false
    local delete_branch=false

    while [[ $# -gt 0 ]]; do
        case "$1" in
            -y|--yes) auto_confirm=true; shift ;;
            -f|--force) force=true; shift ;;
            -b|--delete-branch) delete_branch=true; shift ;;
            -h|--help) _gwtr_usage; return 0 ;;
            -*) echo "Unknown option: $1"; _gwtr_usage; return 1 ;;
            *) echo "Unexpected argument: $1"; _gwtr_usage; return 1 ;;
        esac
    done

    # :A resolves symlinks like realpath(3)
    local git_common_dir
    if ! git_common_dir=$(git rev-parse --git-common-dir 2>/dev/null); then
        echo "Error: Not in a git repository"
        return 1
    fi
    # :A resolves symlinks, :h strips the trailing /.git → main repo path
    local main_repo="${git_common_dir:A:h}"
    local current_wt="${$(git rev-parse --show-toplevel 2>/dev/null):A}"

    # Build candidates from `git worktree list --porcelain`, one "<path>\t[<branch>]"
    # per worktree, excluding the main worktree and the one we're currently inside
    # (git refuses to remove either). Each porcelain record ends with a blank line;
    # process substitution (`< <(...)`) is used over `$(...)` so the final record's
    # terminating blank line survives and flushes the last worktree.
    local -a candidates=()
    local wt_path="" wt_branch="" line
    while IFS= read -r line; do
        case "$line" in
            "worktree "*) wt_path="${line#worktree }"; wt_branch="" ;;
            "branch "*)   wt_branch="${line#branch refs/heads/}" ;;
            detached)     wt_branch="(detached)" ;;
            "")
                local resolved="${wt_path:A}"
                if [[ -n "$wt_path" && "$resolved" != "$main_repo" && "$resolved" != "$current_wt" ]]; then
                    candidates+=("$wt_path"$'\t'"[${wt_branch:-?}]")
                fi
                wt_path="" wt_branch="" ;;
        esac
    done < <(git worktree list --porcelain)

    if (( ${#candidates[@]} == 0 )); then
        echo "No removable worktrees found."
        return 0
    fi

    # peco multi-select (Ctrl+Space) returns one path per line
    local selected
    selected=$(printf '%s\n' "${candidates[@]}" | peco --prompt "Remove worktree>")
    if [[ -z "$selected" ]]; then
        echo "Error: Worktree selection cancelled"
        return 1
    fi

    local -a to_remove=("${(@f)selected}")

    echo ""
    echo "Worktrees to remove:"
    local entry
    for entry in "${to_remove[@]}"; do
        echo "  ${entry//$'\t'/  }"
    done
    echo ""
    if [[ "$auto_confirm" != true ]]; then
        echo -n "Proceed? [y/N] "
        local confirm
        read -r confirm
        if [[ ! "$confirm" =~ ^[Yy] ]]; then
            echo "Cancelled"
            return 0
        fi
    fi

    local -a remove_args=()
    [[ "$force" == true ]] && remove_args+=(--force)

    # NOTE: do not name a local `path` here — in zsh it's tied to $PATH, so
    # assigning it would wipe the command search path and break `git`.
    for entry in "${to_remove[@]}"; do
        local target="${entry%%$'\t'*}"
        local branch="${entry#*$'\t'}"
        branch="${branch#\[}"
        branch="${branch%\]}"

        local removed=false
        if git worktree remove "${remove_args[@]}" "$target" 2>/dev/null; then
            removed=true
            echo "Removed: $target"
        else
            # `git worktree remove` refuses outright on worktrees containing
            # submodules (even with --force), and on dirty/untracked trees
            # without --force. Fall back to a manual `rm -rf` + `git worktree
            # prune`, but never silently discard uncommitted work.
            local dirty
            dirty=$(git -C "$target" status --porcelain 2>/dev/null)
            if [[ -n "$dirty" && "$force" != true ]]; then
                echo "Error: failed to remove: $target"
                echo "  (uncommitted changes present — re-run with -f/--force to discard)"
            elif rm -rf "$target" && git worktree prune; then
                removed=true
                echo "Removed (rm -rf + prune): $target"
            else
                echo "Error: failed to remove: $target"
            fi
        fi

        if [[ "$removed" == true && "$delete_branch" == true \
              && "$branch" != "(detached)" && "$branch" != "?" ]]; then
            if git branch -D "$branch" 2>/dev/null; then
                echo "Deleted branch: $branch"
            else
                echo "Warning: failed to delete branch: $branch"
            fi
        fi
    done
}

function _gwtr_usage() {
    cat <<'USAGE'
Usage: gwtr [options]

Remove git worktree(s) selected interactively via peco. The main worktree and
the worktree you're currently inside are excluded from the candidates (git
refuses to remove either). Use Ctrl+Space in peco to select multiple.

If `git worktree remove` fails (e.g. the worktree contains submodules, which
git refuses to remove), it falls back to `rm -rf` + `git worktree prune`.
Uncommitted changes are preserved unless -f/--force is given.

Options:
  -f, --force          Remove even with uncommitted changes (git worktree remove --force)
  -b, --delete-branch  Also delete the local branch backing each worktree
  -y, --yes            Skip confirmation prompt
  -h, --help           Show this help message

Examples:
  gwtr                 # pick a worktree to remove
  gwtr -b              # remove worktree(s) and their local branches
  gwtr -f -y           # force-remove without confirmation
USAGE
}

function _gwta_setup() {
    local main_repo="$1"
    local wt_path="$2"
    local setup_script="$main_repo/.worktree-setup"

    if [[ ! -f "$setup_script" ]]; then
        echo "No .worktree-setup found. Skipping setup."
        return 0
    fi

    echo ""
    echo "Running .worktree-setup..."
    (cd "$wt_path" && bash "$setup_script" "$main_repo" "$wt_path")
    local exit_code=$?
    if [[ $exit_code -ne 0 ]]; then
        echo "Warning: .worktree-setup exited with code $exit_code"
    fi
}
