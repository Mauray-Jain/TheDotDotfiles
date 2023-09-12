# Auto updater
if [ "$(last --since -7days | wc -l)" -le 4 ]; then
	/home/mauray/utility-scripts/auto-update-sys.sh
fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export EDITOR='nvim'
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# Basic settings
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000
setopt autocd extendedglob menucomplete
bindkey -v # Vi mode

# Tab - Completion Config
zstyle :compinstall filename '/home/mauray/.zshrc'
autoload -Uz compinit
zstyle ':completion:*' menu select
compinit
_comp_options+=(globdots) # To include hidden files as well
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
[[ -n "${key[Up]}" ]] && bindkey -- "${key[Up]}" up-line-or-beginning-search
[[ -n "${key[Down]}" ]] && bindkey -- "${key[Down]}" down-line-or-beginning-search

# Aliases
alias zshrc="nvim ~/.zshrc"
alias nvim-conf="cd ~/.config/nvim && nvim"
alias config="/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME"
alias l='eza -al --icons --group-directories-first'

# ZSH Syntax Highlighting (installed via pacman)
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# ZSH Auto Suggestions (installed via pacman)
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# FZF auto-completion and keybindings
if command -v fzf &> /dev/null; then
	source /usr/share/fzf/key-bindings.zsh
	source /usr/share/fzf/completion.zsh
	alias inspkg="pacman -Slq | fzf --multi --preview 'pacman -Si {1}' | xargs -ro sudo pacman -S"
	alias insaur="yay -Slq | fzf --multi --preview 'yay -Si {1}' | xargs -ro yay -S"
	alias rmpkg="pacman -Qq | fzf --multi --preview 'pacman -Qi {1}' | xargs -ro sudo pacman -Rns"
	alias rmaur="yay -Qq | fzf --multi --preview 'yay -Qi {1}' | xargs -ro yay -Rns"
fi

source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
