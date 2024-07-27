# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#######################
# BINARY INTEGRATIONS #
#######################

# Oh My Zsh
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git vi-mode virtualenv)
zstyle ':omz:update' mode auto

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[ ! -f "${HOME}}/.p10k.zsh" ] && source "${HOME}/.p10k.zsh" || p10k configure
source "$HOME/.oh-my-zsh/oh-my-zsh.sh"

# zsh syntax highlighting
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# enable terminal linewrap
setterm -linewrap on 2> /dev/null

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
export GPG_HRRYSLW="B3207D975183E180A43D8726284D5CD4CBC3D5E4" # hrryslw@pm.me
export GPG_H10LAW="F80B0DE79DC5204F561A0DE35A64130002E4B553"  # h10law@pm.me
export GPG_HARRY="C95A052EB250F3AD8624E9916231F9B2A450EA3A"   # harry@h5law.com
export GPG_DEV="5E13EF45407F11ED9D86A79F51F7D17EC2E1BBE3"     # dev@h5law.com
export GPG_E2E="A840602393055DD3B52B91B2330B8F4221F57F6B"     # e2e@encro.chat
export GPG_SWOLE="1D5A10AE11756A935EEA0278DF3FFDF4F6DCB06C"

# enable GPG signing
export GPG_TTY=$TTY

# bat
export BAT_PAGER="less -RF"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# Modular
export MODULAR_HOME="/Users/harry/.modular"

# brew
export HOMEBREW_NO_ENV_HINTS=1

# ollama
export OPENAI_API_KEY="ollama"

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

function clearsign() {
    if [[ $# -ne 2 ]]; then
        echo "Usage: clearsign <input_file> <SIGNING KEY_ID>"
        return 1
    fi

    local filename="$1"

    gpg --clearsign -o "${filename}.clearsign.asc" -u "$2" "$filename"
}

function sign() {
    if [[ $# -ne 2 ]]; then
        echo "Usage: sign <input_file> <SIGNING KEY_ID>"
        return 1
    fi

    local filename="$1"
    local filename_without_extension="${filename%.*}"

    gpg -ao "${filename_without_extension}.sig" -u "$2" -s "$filename"
}

function bsd3() {
    echo -e "\033[1mCopying BSD-3 Clause License File\033[0m: ${dir}"
    cp "${HOME}/.bsd3" ./LICENSE
}

function mkcd() {
    if [[ $# -lt 1 ]]; then
        echo "Usage: mkcd <directory>"
        return 1
    fi

    local dir="$*"

    echo -e "\033[1mCreating & moving to directory\033[0m: ${dir}"
    /bin/mkdir -p "${dir}" && cd "${dir}"
}

function copy() {
    if [[ $# -lt 1 ]]; then
        echo "Usage: copy <file>"
        return 1
    fi

    local file="$*"

    echo -e "\033[1mCopying file\033[0m: ${file}"
    cat "${file}" | pbcopy
}

function gch() {
    git checkout $1
    git branch --set-upstream-to=origin
}

function gcb() {
    git checkout -b $1
    git branch --set-upstream-to=origin
}

function venv() {
    python3 -m venv ./venv/
    source ./venv/bin/activate
}

function backup() {
    declare -a files=(
        "${HOME}/.zshrc"
        "${HOME}/.zshenv"
        "${HOME}/.config/nvim"
    )
    eval "${HOME}/.local/bin/backup.sh" "${files[@]}" "${HOME}/personal/dotfiles"
}

###########
# ALIASES #
###########

# applications
alias sp="spotify_player"
alias tree="tree -ACFQahv --dirsfirst -I '.git,node_modules'"
alias fd="fd -c always -H --ignore --ignore-vcs --exclude node_modules --exclude Library --exclude .bun --exclude .cargo --exclude go/ --exclude .pkgx/ --exclude .rustup/"
alias bfs="bfs -color -hidden"
alias cat="bat -pp"
alias gt="gpg-tui"

# fzf aliases
alias sd="cd \$(fd -c never -t d | fzf --preview 'tree -C {} | head -200')"
alias preview="fd -c never -t d | fzf --preview 'tree -C {} | head -200'"
alias find="fd -c never | fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'"
alias fim="nvim \$(fd -c never | fzf --preview 'bat --style=numbers --color=always --line-range :500 {}')"

# desired flag aliases (verbosity)
alias cp="cp -v"
alias mkdir="mkdir -pv"
alias rm="rm -v"
alias mv="mv -v"
alias wipe="rm -vfrd"

# spelling aliases
alias vim="nvim"
alias mvim="nvim"
alias vnim="nvim"
alias nim="nvim"
alias ncim="nvim"
alias nvmi="nvim"
alias got="git"
alias exir="exit"
alias d="cd"

# command aliases
alias g="git"
alias n="nvim"
alias m="nvim"
alias git_aliases="git config --get-regexp alias"

# automation scripts
alias backup="./Users/harry/.local/bin/backup.sh"
alias update="~/.local/bin/updator.sh"

# Rust docs
alias rustdoc="RUSTDOCFLAGS='--html-in-header ./header-file.html' cargo watch -s 'cargo doc --no-deps --color always && browser-sync start -w --ss target/doc -s target/doc --directory --no-open'"
alias cwctr="cargo watch -x check -x test -x run"
alias tarp="cargo tarpaulin --ignore-tests"

#####################################
# AUTO COMPLETIONS AND INTEGRATIONS #
#####################################

# Enable iterm2 shell integration
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# Auto completions and integrations
[ -s "${HOME}/.fzf-integration.zsh" ] && source "${HOME}/.fzf-integration.zsh"
[ -s "${HOME}/.atuin-init.zsh" ] && source "${HOME}/.atuin-init.zsh"
[ -s "${HOME}/.atuin-completions.zsh" ] && source "${HOME}/.atuin-completions.zsh"
[ -s "${HOME}/.hugo-completions.zsh" ] && source "${HOME}/.hugo-completions.zsh"
[ -s "${HOME}/.kubectl.zsh" ] && source "${HOME}/.kubectl.zsh"
[ -s "${HOME}/.dlv-completions.zsh" ] && source "${HOME}/.dlv-completions.zsh"
[ -s "${HOME}/.colima-completion.zsh" ] && source "${HOME}/.colima-completion.zsh"
[ -s "${HOME}/.gh_completions.zsh" ] && source "${HOME}/.gh_completions.zsh"
[ -s "${HOME}/.spotify-player-comp.zsh" ] && source "${HOME}/.spotify-player-comp.zsh"
[ -s "${HOME}/.bun/_bun" ] && source "${HOME}/.bun/_bun"

# zoxide integration
eval "$(zoxide init --cmd "cd" zsh)"

# asdf
source /opt/homebrew/opt/asdf/libexec/asdf.sh

# pkgx shellcode
source <(pkgx --shellcode)  #docs.pkgx.sh/shellcode
