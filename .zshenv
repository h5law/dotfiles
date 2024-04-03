# basic 
export PATH=/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin
# local path
export PATH="/bin:/sbin:$HOME/.local/bin:${PATH}"
# homebrew
export PATH="$PATH:/opt/homebrew/bin"
# codeium
export PATH="$PATH:/Users/harry/.codeium/bin"
# go
export GOPATH="/Users/harry/go"
export GOBIN="$GOPATH/bin"
export PATH="$PATH:$GOPATH:$GOPATH/bin"
# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
# Homebrew functions
export FPATH="/opt/homebrew/share/zsh/site-functions:${FPATH}"
. "$HOME/.cargo/env"
