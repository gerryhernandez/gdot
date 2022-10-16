# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
source ~/.config/powerlevel10k/powerlevel10k.zsh-theme
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

alias vi=nvim
alias vim=nvim
export EDITOR=nvim
export NEOVIDE_FRAMELESS=true

# Enable vi mode
bindkey -v
export VISUAL=vim
autoload edit-command-line; zle -N edit-command-line
bindkey -M vicmd v edit-command-line

# Colorize the ls output ##
alias ls='ls --color=auto'
# Use a long listing format ##
alias ll='ls -la'
# Show hidden files ##
alias l.='ls -d .* --color=auto'
# colorful grep
alias grep='grep --color'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f $HOME/p10k.zsh ]] || source $HOME/.p10k.zsh

export PATH="$HOME/.dotfiles/bin/all:$PATH"
export GPG_TTY=$(tty)

alias gtmux='tmux new-session -A -s'
alias gdot='git --git-dir=$HOME/.gdot/ --work-tree=$HOME'

export ZSH_THEME_TERM_TITLE_IDLE="%~"
export ZSH_THEME_TERM_TAB_TITLE_IDLE="%~"

# Colorful `man`-style commands
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

export PATH=$HOME/.local/bin:$PATH
#
# Keep OS-Specific config SECOND TO LAST so it can override generics:
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  # linux-specific stuff
elif [[ "$OSTYPE" == "darwin"* ]]; then
  source $HOME/.zshrc_macos
fi

# Keep machine-specific config ABSOLUTELYE LAST to override everything:
if [ -f "$HOME/.zshrc_local" ]; then
  source $HOME/.zshrc_local
fi

