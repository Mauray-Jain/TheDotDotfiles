#!/usr/bin/env bash

# This script checks logins from a time of one week and updates system and nvim plugins
# TODO:
# Add news from arch website on updating the packages
# Include other softwares with plugins that may need updating
# Maybe add git integration and sync repos
# Maybe make it GUI

update_sys() {
	echo Updating system...
	sleep 1
	yay
}
update_nvim() {
	echo Updating nvim...
	sleep 1
	nvim -e +':PackerSync' +':visual'
}
updater() {
	read -p "Choice: " choice
	case $choice in
		a ) update_sys && sleep 2 && update_nvim;;
		n ) update_nvim;;
		p ) update_sys;;
		q ) echo "Quitted";;
		* ) echo "Invalid Option" && updater
	esac
}

lines=$(last --since -7days | wc -l)

if [ "$lines" -le 4 ]; then
	echo "You have come after a loong time
Tell me what all should be updated
	a = everything (system packages and nvim plugins)
	n = nvim plugins
	p = system packages
	q = quit script"
	updater
fi
