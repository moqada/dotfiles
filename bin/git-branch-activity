#!/bin/bash

USAGE="\
usage: git branch-activity [-r | -a] [-R] [--no-color]

    -r, --remotes  List remote-tracking branches
    -a, --all      List both remote-tracking and local branches
    -R, --reverse  Reverse list order
    --no-color     Don't use colored output"

GIT_BRANCH_OPT=

print_branches() {
    git branch $GIT_BRANCH_OPT | perl -lne 'print $1 if /^[ *] ?(\S+)/'
}

decorate_branches() {
    local use_color=$1
    local format

    if [[ -n "$use_color" ]]; then
        format="format:\e[34m[%ai]\e[m \e[33m%h\e[m" # blue, yellow
    else
        format="format:[%ai] %h"
    fi

    local current_branch=$(git symbolic-ref -q --short HEAD)

    while read -r br; do
        printf "$(git log --date=iso8601 -n 1 --pretty="$format" "$br") "
        if [[ -n "$use_color" ]]; then
            print_colored_branch "$br" "$current_branch"
        else
            echo "$br"
        fi
    done
}

print_colored_branch() {
    local branch=$1
    local current=$2

    local red="\e[31m%s\e[m"
    local green="\e[32m%s\e[m"
    local format="%s"

    case "$GIT_BRANCH_OPT" in
        -a)
            if [[ "$branch" = remotes/* ]]; then
                format=$red
            elif [[ "$branch" = "$current" ]]; then
                format=$green
            fi
            ;;
        -r)
            format=$red
            ;;
        *)
            if [[ "$branch" = "$current" ]]; then
                format=$green
            fi
            ;;
    esac

    printf "$format\n" "$branch"
}

main() {
    local sort_opt=-r
    local use_color

    if [[ -t 1 ]]; then
        use_color=1
    fi

    while [[ $# > 0 ]]; do
        case "$1" in
            -a|--all    ) GIT_BRANCH_OPT=-a ;;
            -r|--remotes) GIT_BRANCH_OPT=-r ;;
            -R|--reverse) sort_opt=         ;;
            --no-color  ) use_color=        ;;
            -h          )
                echo "$USAGE"
                exit
        esac
        shift
    done

   print_branches \
       | decorate_branches "$use_color" \
       | sort $sort_opt
}

main "$@"
