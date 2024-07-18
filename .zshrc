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
export GPG_POLYMER="9C90BCC808A7068F37C0BCED468E8D612754F96D" # harry@polymerlabs.org
export GPG_SWOLE="1D5A10AE11756A935EEA0278DF3FFDF4F6DCB06C"

# enable GPG signing
export GPG_TTY=$TTY

# bat
export BAT_PAGER="less -RF"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# llvm
export LDFLAGS="-L/opt/homebrew/opt/llvm/lib"
export CPPFLAGS="-I/opt/homebrew/opt/llvm/include"

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
    eval ${HOME}/.local/bin/backup.sh ${files[@]} ${HOME}/personal/dotfiles
}

###########
# ALIASES #
###########

# ls 
alias tree="tree -ACFQahv --dirsfirst -I '.git,node_modules'"
alias fd="fd -c always -H --ignore --ignore-vcs --exclude node_modules --exclude Library --exclude .bun --exclude .cargo --exclude go/ --exclude .pkgx/ --exclude .rustup/"
alias bfs="bfs -color -hidden"

# desired flag aliases
alias cp="cp -v"
alias mkdir="mkdir -pv"
alias rm="rm -v"
alias mv="mv -v"

# spelling aliases
alias vim="nvim"
alias mvim="nvim"
alias vnim="nvim"
alias nim="nvim"
alias ncim="nvim"
alias nvmi="nvim"
alias got="git"
alias exir="exit"

# fzf aliases
alias sd="cd \$(fd -c never -t d | fzf --preview 'tree -C {} | head -200')"
alias files="fd -c never | fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'"
alias preview="/opt/homebrew/bin/fd -H -I -c never | fzf --preview '
if [ -d {} ]; then
    tree -C {} | head -n 500
else
    bat --style=numbers --color=always --line-range :500 {}
fi'"
alias fim="nvim \$(fd -c never | fzf --preview 'bat --style=numbers --color=always --line-range :500 {}')"

# command aliases
alias g="git"
alias n="nvim"
alias m="nvim"
alias git_aliases="git config --get-regexp alias"
alias mactop="sudo mactop"
alias cat="bat -pp"
alias gt="gpg-tui"
alias update="~/.local/bin/updator.sh"
alias cwctr="cargo watch -x check -x test -x run"
alias rustdoc="RUSTDOCFLAGS='--html-in-header ./header-file.html' cargo watch -s 'cargo doc --no-deps --color always && browser-sync start -w --ss target/doc -s target/doc --directory --no-open'"
alias tarp="cargo tarpaulin --ignore-tests"
alias wipe="rm -rfd ${@}"
alias tgo="tinygo"
alias oweb="docker run -d -p 4000:8080 --add-host=host.docker.internal:host-gateway -v open-webui:/app/backend/data --name open-webui --restart always ghcr.io/open-webui/open-webui:main"
alias backup="./Users/harry/.local/bin/backup.sh"
alias tdtu="tilt down && tilt up"

#####################################
# AUTO COMPLETIONS AND INTEGRATIONS #
#####################################

# Enable iterm2 shell integration
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# Auto completions and integrations
[ -f ~/.fzf-integration.zsh ] && source ~/.fzf-integration.zsh
[ -f ~/.atuin-init.zsh ] && source ~/.atuin-init.zsh
[ -f ~/.atuin-completions.zsh ] && source ~/.atuin-completions.zsh
[ -f ~/.hugo-completions.zsh ] && source ~/.hugo-completions.zsh
[ -f ~/.kubectl.zsh ] && source ~/.kubectl.zsh
[ -f ~/.dlv-completions.zsh ] && source ~/.dlv-completions.zsh
[ -f ~/.colima-completion.zsh ] && source ~/.colima-completion.zsh

# zoxide integration
eval "$(zoxide init --cmd "cd" zsh)"

# asdf
source /opt/homebrew/opt/asdf/libexec/asdf.sh

# pkgx shellcode
source <(pkgx --shellcode)  #docs.pkgx.sh/shellcode

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# bun completions
[ -s "/Users/harry/.bun/_bun" ] && source "/Users/harry/.bun/_bun"
