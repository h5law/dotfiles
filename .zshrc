export ZSH="$HOME/.oh-my-zsh"

# Set locale
export LANG=en_GB.UTF-8

# Compilation flags
export ARCHFLAGS="-arch x86_64"

plugins=(zsh-syntax-highlighting)

# Setup powerline
ZSH_THEME="powerlevel9k/powerlevel9k"
POWERLEVEL9K_SHORTEN_DIR_LENGTH=2

# zstyle ':omz:update' mode disabled  # disable automatic updates
zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

source $ZSH/oh-my-zsh.sh

# enable terminal linewrap
setterm -linewrap on 2> /dev/null

# Configure less colors
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'
export LESSHISTFILE=-

# enable color support of ls and also add handy aliases
if [[ -x /usr/bin/dircolors ]]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Export GPG_KEY
export GPGKEY="7237373D83B47ACEEF420880330669D11815893C"
# enable GPG signing
export GPG_TTY=$TTY

# Pocket endpoints
export PNI_POCKET_ENDPOINT=https://pnfchains:FJaH6b4Modr8QDvQSgkh@pokt-dispatchers.us-east4-1.poktnodes.network:8443
export POCKET_ENDPOINT=https://mainnet.gateway.pokt.network/v1/lb/5cefc586e2340a26d983f63f
export LOCAL_POCKET_ENDPOINT=http://localhost:50832

# custom aliases
alias updates="sudo dnf --refresh update && sudo dnf upgrade -y && sudo dnf autoremove && sudo dnf clean all  && flatpak update -y && flatpak uninstall --unused"
alias tree="tree -ACFQahv --dirsfirst"
alias cp="cp -v"
alias mkdir="mkdir -pv"
alias rm="rm -v"
alias mv="mv -v"
alias vim="nvim"

# Source cargo
source "$HOME/.cargo/env"

# PATH
export PATH="$PATH:$HOME/.local/bin"
fpath+=${ZDOTDIR:-~}/.zsh_functions

# GOPATH
export GOPATH="$( go env GOPATH )"
path+=($( go env GOPATH ))
path+=("$( go env GOPATH )/bin")

# Foundry
export PATH="$PATH:/home/harry/.foundry/bin"
