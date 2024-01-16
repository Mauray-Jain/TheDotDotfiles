#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Auto updater
if [ "$(last --since -7days | wc -l)" -le 4 ]; then
	/home/mauray/utility-scripts/auto-update-sys.sh
fi

alias zshrc="nvim ~/.zshrc"
alias nvim-conf="cd ~/.config/nvim && nvim"
alias config="/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME"
alias l='eza -al --group-directories-first'
PS1='[\u@\h \W]\$ '

# FZF auto-completion and keybindings
if command -v fzf &> /dev/null; then
	source /usr/share/fzf/key-bindings.bash
	source /usr/share/fzf/completion.bash
	alias inspkg="pacman -Slq | fzf --multi --preview 'pacman -Si {1}' | xargs -ro sudo pacman -S"
	alias insaur="yay -Slq | fzf --multi --preview 'yay -Si {1}' | xargs -ro yay -S"
	alias rmpkg="pacman -Qq | fzf --multi --preview 'pacman -Qi {1}' | xargs -ro sudo pacman -Rns"
	alias rmaur="yay -Qq | fzf --multi --preview 'yay -Qi {1}' | xargs -ro yay -Rns"
fi
. "$HOME/.cargo/env"
