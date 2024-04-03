# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Source cargo
source "$HOME/.cargo/env"

# Oh My Zsh
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git vi-mode)
zstyle ':omz:update' mode auto
source "$HOME/.oh-my-zsh/oh-my-zsh.sh"

# enable terminal linewrap
setterm -linewrap on 2> /dev/null

# Enable iterm2 shell integration
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

###########
# EXPORTS #
###########

# Set locale
export LANG=en_GB.UTF-8

# Configure less colors
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

# enable color support of ls and also add handy aliases
if [[ -x /usr/bin/dircolors ]]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
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

# Export GPG_KEYs
export GPG_HRRYSLW="B3207D975183E180A43D8726284D5CD4CBC3D5E4"
export GPG_H10LAW="F80B0DE79DC5204F561A0DE35A64130002E4B553"
export GPG_DEV="5E13EF45407F11ED9D86A79F51F7D17EC2E1BBE3"
export GPG_SWOLE="1D5A10AE11756A935EEA0278DF3FFDF4F6DCB06C"

# enable GPG signing
export GPG_TTY=$TTY

# bat
export BAT_PAGER="less -RF"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

#############
# FUNCTIONS #
#############
function encrypt() {
    if [[ $# -lt 2 ]]; then
        echo "Usage: encrypt <input_file> <USING KEY_ID> [RECIPIENT KEY_ID]"
        return 1
    fi

    local filename="$1"
    local sender="$2"

    if [[ $# -gt 3 ]]; then
        echo "Usage: encrypt <input_file> <USING KEY_ID> [RECIPIENT KEY_ID]"
        return 1
    fi

    local recipient
    if [[ $# -eq 3 ]]; then
        recipient="$3"
    fi

    local filename_without_extension="${filename%.*}"

    # Call gpg with appropriate options based on the presence of the recipient
    if [[ -n $recipient ]]; then
        gpg -ao "${filename_without_extension}.asc" -u "$sender" -r "$sender" -r "$recipient" -se "$filename"
    else
        gpg -ao "${filename_without_extension}.asc" -u "$sender" -r "$sender" -se "$filename"
    fi
}


function gch {
    git checkout $1
    git branch --set-upstream-to=origin
}

function gcb {
    git checkout -b $1
    git branch --set-upstream-to=origin
}

###########
# ALIASES #
###########

# ls 
alias tree="tree -ACFQahv --dirsfirst -i='.git,node_modules'"

# desired flag aliases
alias cp="cp -v"
alias mkdir="mkdir -pv"
alias rm="rm -v"
alias mv="mv -v"

# custom aliases
alias mkcd="mkdir ${1} && cd ${1}"
alias g="git"

# spelling aliases
alias vim="nvim"
alias mvim="nvim"
alias vnim="nvim"
alias nim="nvim"
alias ncim="nvim"
alias nvmi="nvim"
alias got="git"

# fzf aliases
alias fim="nvim \$(fzf)"
alias sd="cd \$(find * -type d | fzf)"

# command aliases
alias git_aliases="git config --get-regexp alias"
alias cat="bat -pp"

####################
# AUTO COMPLETIONS #
####################

# Auto completions
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -s "/Users/harry/.bun/_bun" ] && source "/Users/harry/.bun/_bun"

# Syntax highlighting
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
