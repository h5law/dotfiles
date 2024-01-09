# basic 
export PATH=/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin
# local path
export PATH="/bin:/usr/bin:/usr/local/bin:/sbin:$HOME/.local/bin:${PATH}"
# homebrew
export PATH="$PATH:/opt/homebrew/bin"
# codeium
export PATH="$PATH:/Users/harry/.codeium/bin"
# go
export GOPATH="/Users/harry/go"
export GOBIN="$GOPATH/bin"
export PATH="$PATH:$GOPATH:$GOPATH/bin"
# solana
export PATH="$PATH:/Users/harry/.local/share/solana/install/active_release/bin"
# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
# noir
export NARGO_HOME="/Users/harry/.nargo"
export PATH="$PATH:$NARGO_HOME/bin"
# foundry
export PATH="$PATH:/Users/harry/.config/.foundry/bin"
# Homebrew functions
export FPATH="/opt/homebrew/share/zsh/site-functions:${FPATH}"
