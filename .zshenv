typeset -U path PATH

# Set common paths
path=(
  /usr/local/bin
  /usr/bin
  /bin
  /usr/sbin
  /sbin
  $path
)

# Add Homebrew paths (if Homebrew is installed)
if [[ -d /opt/homebrew ]]; then
  path=(
    /opt/homebrew/bin
    /opt/homebrew/sbin
    $path
  )
fi

# Add custom paths for development tools
path=(
  $HOME/.cargo/bin  # Rust
  $HOME/go/bin      # Go
  $HOME/.bun/bin    # Bun
  $HOME/.cargo/env  # Cargo
  $HOME/.config/.foundry/bin # Foundry
  $path
)

# Local paths
path=(
  $HOME/bin
  $HOME/.local/bin
  $path
)

# C/C++ Development Paths
export SDKROOT=$(xcrun --show-sdk-path)
export CPLUS_INCLUDE_PATH="${SDKROOT}/usr/include:/usr/local/include:$CPLUS_INCLUDE_PATH"
export C_INCLUDE_PATH="${SDKROOT}/usr/include:/usr/local/include:$C_INCLUDE_PATH"
export LIBRARY_PATH="${SDKROOT}/usr/lib:/usr/local/lib:$LIBRARY_PATH"

# LLVM/Clang specific paths (adjust version as needed)
export LLVM_PATH="/opt/homebrew/opt/llvm"
path=(
  $LLVM_PATH/bin
  $path
)

# Compiler specific paths
export LDFLAGS="-L$LLVM_PATH/lib"
export CPPFLAGS="-I$LLVM_PATH/include"

# Homebrew functions
export FPATH="/opt/homebrew/share/zsh/site-functions:${FPATH}"

# Export the updated PATH
export PATH

# Additional environment variables for C/C++ development
export CC="clang"
export CXX="clang++"

export COLIMA_HOME="$HOME/.colima"
export DOCKER_HOST="unix://${COLIMA_HOME}/default/docker.sock"
