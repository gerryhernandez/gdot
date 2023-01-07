# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
source ~/.config/powerlevel10k/powerlevel10k.zsh-theme
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export EDITOR=nvim
export NEOVIDE_FRAMELESS=true
export TERMINAL=alacritty

###########################
# START aliases and funcs #
###########################

alias vi=nvim
alias vim=nvim

# Colorize the ls output ##
alias ls='ls --color=auto'
# Use a long listing format ##
alias ll='ls -la'
# Show hidden files ##
alias l.='ls -d .* --color=auto'
# colorful grep
alias grep='grep --color'

# pushd via fzf of telescope-project.nvm
# "Pushd Project"
function pp() {
  DIR=$(cat ~/.local/share/nvim/telescope-projects.txt \
    | awk -F"=" '{print $1 " " $2}' \
    | fzf -n 1 --with-nth 1 -q "$1" -1 \
    | awk '{print $2}')
  pushd "$DIR"
}

alias gdot='git --git-dir=$HOME/.gdot/ --work-tree=$HOME'

function colors256() {
  for i in {0..255}; do
    printf "\x1b[38;5;${i}mcolour${i}\x1b[0m\n"
  done
}

###########################
#  END  aliases and funcs #
###########################

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f $HOME/p10k.zsh ]] || source $HOME/.p10k.zsh

export PATH="$HOME/.dotfiles/bin/all:$PATH"
export PATH="$HOME/go/bin:$PATH"
export GPG_TTY=$(tty)

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

# Tab Autocompletion Settings
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' menu select
# Shift-Tab to navigate backwards
bindkey '^[[Z' reverse-menu-complete
autoload -Uz compinit
compinit

# ctrl-a for line-home, ctrl-e for line-end
bindkey -e

# ctrl-v to edit command line in vim
autoload -z edit-command-line
zle -N edit-command-line
bindkey "^v" edit-command-line

# Tell Qt apps to use the qt5ct them for DaRk MoDe!!111one
export QT_QPA_PLATFORMTHEME=qt5ct

# dem binz
export PATH=$HOME/.local/bin:$PATH

# Keep OS-Specific config SECOND TO LAST so it can override generics:
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  # linux-specific stuff
  source /usr/share/nvm/init-nvm.sh
elif [[ "$OSTYPE" == "darwin"* ]]; then
  source $HOME/.zshrc_macos
fi

# Keep machine-specific config ABSOLUTELYE LAST to override everything:
if [ -f "$HOME/.zshrc_local" ]; then
  source $HOME/.zshrc_local
fi

