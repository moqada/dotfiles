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
            -y|--yes) auto_confirm=true; shift ;;
            --no-setup) skip_setup=true; shift ;;
            -h|--help) _gwta_usage; return 0 ;;
            -*) echo "Unknown option: $1"; _gwta_usage; return 1 ;;
            *) worktree_name="$1"; shift ;;
        esac
    done

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

    if [[ -z "$worktree_name" ]]; then
        if [[ "$auto_confirm" == true ]]; then
            echo "Error: Worktree name is required"
            return 1
        fi
        local date_prefix
        date_prefix=$(date +%Y%m%d)
        echo -n "Worktree name (auto-prefix: ${date_prefix}-): "
        read -r worktree_name
        if [[ -z "$worktree_name" ]]; then
            echo "Error: Worktree name is required"
            return 1
        fi
    fi

    local branch_base="$worktree_name"
    if [[ "$worktree_name" =~ ^[0-9]{8}- ]]; then
        branch_base="${worktree_name#[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]-}"
    else
        worktree_name="$(date +%Y%m%d)-${worktree_name}"
    fi

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

        base_branch=$( \
            { \
              [[ -n "$default_branch" ]] && echo "origin/$default_branch"; \
              git branch -r --sort=-committerdate \
                | sed 's/^ *//' \
                | grep -v 'HEAD' \
                | grep -v "^origin/${default_branch}$"; \
              git branch --sort=-committerdate \
                | sed 's/^ *//' \
                | sed 's/^\* //'; \
            } | awk '!seen[$0]++' \
              | peco --prompt "Base branch>" \
        )

        if [[ -z "$base_branch" ]]; then
            echo "Error: Base branch selection cancelled"
            return 1
        fi
    fi

    if [[ -z "$branch_name" ]]; then
        branch_name="feature/${branch_base}"
    fi

    local worktree_path="$HOME/worktrees/${rel_path}/${worktree_name}"

    echo ""
    echo "  Worktree: $worktree_path"
    echo "  Branch:   $branch_name"
    echo "  Base:     $base_branch"
    echo ""
    if [[ "$auto_confirm" != true ]]; then
        echo -n "Proceed? [Y/n] "
        read -r confirm
        if [[ "$confirm" =~ ^[Nn] ]]; then
            echo "Cancelled"
            return 0
        fi
    fi

    local -a worktree_args=(-b "$branch_name")
    # Prevent auto-tracking remote branch to avoid accidental push to e.g. master
    if [[ "$base_branch" == origin/* ]]; then
        worktree_args+=(--no-track)
    fi
    if ! git worktree add "${worktree_args[@]}" "$worktree_path" "$base_branch"; then
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
}

function _gwta_usage() {
    cat <<'USAGE'
Usage: gwta [options] <worktree-name>

Create a git worktree under ~/worktrees/<repo>/<date>-<name>.
After creation, cd into the new worktree.

Options:
  -b, --branch NAME    Branch name (default: feature/<worktree-name>)
  --base BRANCH        Base branch (default: interactive selection via peco)
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
