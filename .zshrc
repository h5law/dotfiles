# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# PATH
FPATH="/opt/homebrew/share/zsh/site-functions:${FPATH}"

# PATH
export PATH="/bin:/usr/bin:/usr/local/bin:/sbin:$HOME/.local/bin:${PATH}"

# Source cargo
source "$HOME/.cargo/env"

# GOPATH in ~/.zshenv
#export GOPATH="/Users/harry/go"
#export PATH="$PATH:$GOPATH:$GOPATH/bin"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# asdf
source /opt/homebrew/opt/asdf/libexec/asdf.sh

# Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"

# Set locale
export LANG=en_GB.UTF-8

plugins=(git zsh-syntax-highlighting vi-mode)

# Setup powerline
ZSH_THEME="powerlevel10k/powerlevel10k"

zstyle ':omz:update' mode auto

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
export OTHERKEY="1D5A10AE11756A935EEA0278DF3FFDF4F6DCB06C"

# enable GPG signing
export GPG_TTY=$TTY

# ls 
alias tree="tree -ACFQahv --dirsfirst"

# desired flag aliases
alias cp="cp -v"
alias mkdir="mkdir -pv"
alias rm="rm -v"
alias mv="mv -v"

# nvim aliases
alias vim="nvim"

# fzf aliases
alias fim="nvim \$(fzf)"
alias sd="cd \$(find * -type d | fzf)"

# git aliases
alias gst="git status"
alias glg="git log --decorate --graph --oneline"
alias gcm="git add . && git commit -m $1"
alias gcl="git checkout -"

# Auto completions
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/.pocket.zsh ] && source ~/.pocket.zsh
[ -s "/Users/harry/.bun/_bun" ] && source "/Users/harry/.bun/_bun"

# Enable iterm2 shell integration
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

