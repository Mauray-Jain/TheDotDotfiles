#!/usr/bin/env bash

# OPro = Open Project

if [[ $# -eq 1 ]]; then
	repo=$1
else
	repo=$(find ~/repo -maxdepth 1 -mindepth 1 -type d | fzf)
fi

if [[ -z $repo ]]; then
	exit 0
fi

session_name=$(basename "$repo" | tr '.' '_')
# is_tmux_running=$(pgrep tmux)

# if [[ -z $TMUX ]] && [[ -z $is_tmux_running ]]; then
# 	tmux new-session -s $session_name -c $repo
# 	exit 0
# fi

# if ! tmux has-session -t=$session_name 2> /dev/null; then
# 	tmux new-session -ds $session_name -c $repo
# else
# 	tmux new
# fi


if [[ -n $TMUX ]]; then
	tmux new-session -Ads $session_name -c $repo
	tmux switch-client -t $session_name
else
	tmux new-session -As $session_name -c $repo
fi
