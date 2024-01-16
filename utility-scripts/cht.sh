#!/usr/bin/env bash

# This script is heavily borrowed from https://github.com/ThePrimeagen/.dotfiles/blob/master/bin/.local/bin/tmux-cht.sh
# This script curls from cht.sh and provides cheatsheet for required language and / or tool

selected=`cat ~/utility-scripts/.cht-sh/languages ~/utility-scripts/.cht-sh/core_utils | fzf`

read -p "Enter query: " query
query=`echo $query | tr ' ' '~'`

if [[ -z $selected ]]; then
	tmux neww bash -c "curl -s https://cht.sh/~$query | bat -"
elif grep -qs "$selected" ~/utility-scripts/.cht-sh/languages; then
	query=`echo $query | tr '~' '+'`
	tmux neww bash -c "curl -s https://cht.sh/$selected/$query | bat -"
else
	tmux neww bash -c "curl -s https://cht.sh/$selected~$query | bat -"
fi
