#!/bin/sh

GUM_SPIN_SHOW_OUTPUT=true # buggy for some reason

tools="brew cargo gh go rustup pkgx"
choices=""

# check which tools are installed
for tool in $tools; do
    if command -v $tool &> /dev/null; then
        choices="$choices $tool"
    fi
done

# add --all option
if [ "$1" != "--all" ]; then
    echo "Choose what packages you want to update: "
    choices=$(gum choose $choices --no-limit)
fi

for choice in $choices; do
    if [ "$choice" = "rustup" ]; then
        echo "Updating Rust toolchain..."
        cmd="rustup update"
        gum spin -s minidot --title "Running '$cmd'" -- $cmd
    elif [ "$choice" = "cargo" ]; then
        echo "Updating Rust binaries..."
        cmd="cargo install-update -a"
        gum spin -s minidot --title "Running '$cmd'" -- $cmd
    elif [ "$choice" = "go" ]; then
        if ! command -v go-global-update &> /dev/null; then
            cmd="go install github.com/gelio/go-global-update@latest"
            gum spin -s minidot --title "Installing go-global-update..." -- $cmd
        fi
        echo "Updating Go binaries..."
        cmd="go-global-update"
        gum spin -s minidot --title "Running '$cmd'" -- $cmd
    elif [ "$choice" = "brew" ]; then
        echo "Updating brew..."
        brew update
        brew upgrade
        brew upgrade `brew list --cask`
        brew cleanup
        brew autoremove 
        brew doctor
    elif [ "$choice" = "gh" ]; then
        echo "Updating gh extensions..."
        cmd="gh extension upgrade --all"
        gum spin -s minidot --title "Running '$cmd'" -- $cmd
    elif [ "$choice" = "pkgx" ]; then
        echo "Updating pkgx..."
        pkgx --sync --verbose
        pkgx --update --verbose
    fi
done
echo "Done!"