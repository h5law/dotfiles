# basic 
export PATH="/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin"
# homebrew
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"
# local
export PATH="$PATH:$HOME/bin:$HOME/.local/bin"
# llvm
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
# Homebrew functions
export FPATH="/opt/homebrew/share/zsh/site-functions:${FPATH}"
# go
export GOPATH="/Users/harry/go"
export GOBIN="$GOPATH/bin"
export PATH="$PATH:$GOPATH:$GOPATH/bin"
# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$PATH:$BUN_INSTALL/bin"
[ -s "/Users/harry/.bun/_bun" ] && source "/Users/harry/.bun/_bun"
# Source cargo
source "$HOME/.cargo/env"
# Foundry
export PATH="$PATH:/Users/harry/.config/.foundry/bin"
