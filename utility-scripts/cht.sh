#!/usr/bin/env bash

# This script is heavily borrowed from https://github.com/ThePrimeagen/.dotfiles/blob/master/bin/.local/bin/tmux-cht.sh. Special thanks to him.
# This script curls from cht.sh and provides cheatsheet for required language and / or tool

languages=`cat ~/utility-scripts/.cht-sh/languages`
core_utils=`cat ~/utility-scripts/.cht-sh/core_utils`

if command -v fzf &> /dev/null; then
	selected=`echo -e "$languages\n$core_utils" | fzf`
else
	echo -e "You haven't installed FZF. Install it for better experience\n"
	echo -e "$languages\n$core_utils\n"
	read -p "Select one of above: " selected
fi

read -p "Enter query: " query
query=`echo $query | tr ' ' '+'`

# q option is must
