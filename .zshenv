# basic 
export PATH="/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin"
# local path
export PATH="${HOME}/.local/bin:${PATH}"
# homebrew
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:${PATH}"
# llvm
export PATH="$PATH:/opt/homebrew/opt/llvm/bin"
# sqlite
export LDFLAGS="-L/opt/homebrew/opt/sqlite/lib"
export CPPFLAGS="-I/opt/homebrew/opt/sqlite/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/sqlite/lib/pkgconfig"
# Homebrew functions
export FPATH="/opt/homebrew/share/zsh/site-functions:${FPATH}"
# go
export GOPATH="/Users/harry/go"
export GOBIN="$GOPATH/bin"
export PATH="$PATH:$GOPATH:$GOPATH/bin"
# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
[ -s "/Users/harry/.bun/_bun" ] && source "/Users/harry/.bun/_bun"
# mojo
export PATH="$PATH:/Users/harry/.modular/pkg/packages.modular.com_mojo/bin"
# Source cargo
source "$HOME/.cargo/env"
# Foundry
export PATH="$PATH:/Users/harry/.config/.foundry/bin"
# codeium
export PATH="$PATH:/Users/harry/.codeium/bin"
