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
plugins=(git zsh-syntax-highlighting vi-mode)
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
export GPG_H10LAW="F80B0DE79DC5204F561A0DE35A64130002E4B553"
export GPG_HRRYSLW="B3207D975183E180A43D8726284D5CD4CBC3D5E4"
export GPG_H5LTD="1A98952E1E6857DB08E6182D63D8D652AF94E8AB"
export GPG_DEV="5E13EF45407F11ED9D86A79F51F7D17EC2E1BBE3"
export GPG_SWOLE="1D5A10AE11756A935EEA0278DF3FFDF4F6DCB06C"

# enable GPG signing
export GPG_TTY=$TTY

#############
# FUNCTIONS #
#############
function encrypt() {
    if [[ $# -lt 2 ]]; then
        echo "Usage: encrypt <USING KEY_ID> [<recipient1> ...] <input_file>"
        return 1
    fi

    local filename="$1"
    local recipient1=""
    shift  # Remove the first argument (filename) from the list of arguments
    local recipients=()

    # Iterate through the remaining arguments
    while [[ $# -gt 0 ]]; do
        case "$1" in
            *)
                # If recipient1 is empty, assign the current argument to it
                if [[ -z "$recipient1" ]]; then
                    recipient1="$1"
                fi
                # Add the current argument to the list of recipients
                recipients+=("$1")
                ;;
        esac
        shift  # Move to the next argument
    done

    # Remove the extension from the filename
    local filename_without_extension="${file%.*}"

    # Call the encrypt function with the filename, recipient1 as -u, and other recipients
    encrypt -ao "${filename_without_extension}.asc" -u "$recipient1" "${recipients[@]}" -se "$filename" 
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

####################
# AUTO COMPLETIONS #
####################

# Auto completions
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -s "/Users/harry/.bun/_bun" ] && source "/Users/harry/.bun/_bun"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
