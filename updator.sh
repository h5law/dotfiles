#!/bin/sh

export GUM_SPIN_SHOW_OUTPUT=true # buggy for some reason

tools="brew cargo gh go rustup foundryup pkgx pip3 modular"
choices=""

# check which tools are installed
for tool in $tools; do
    if command -v "${tool}" &> /dev/null; then
        choices="$choices $tool"
    fi
done

# add --all option
if [ "$1" != "--all" ]; then
    echo "Choose what packages you want to update: "
    choices=$(gum choose ${choices} --no-limit)
fi

for choice in ${choices}; do
    if [ "${choice}" = "rustup" ]; then
        echo "Updating Rust toolchain..."
        cmd="rustup update"
        gum spin -s minidot --title "Running '${cmd}'" -- "${cmd}"
    elif [ "${choice}" = "cargo" ]; then
        echo "Updating Rust binaries..."
        cmd="cargo install-update -a"
        gum spin -s minidot --title "Running '${cmd}'" -- "${cmd}"
    elif [ "${choice}" = "foundryup" ]; then
        echo "Updating Foundry toolchain..."
        cmd="foundryup --arch arm64 --platform darwin"
        gum spin -s minidot --title "Running '${cmd}'" -- "${cmd}"
    elif [ "${choice}" = "go" ]; then
        if ! command -v go-global-update &> /dev/null; then
            cmd="go install github.com/gelio/go-global-update@latest"
            gum spin -s minidot --title "Installing go-global-update..." -- "${cmd}"
        fi
        echo "Updating Go binaries..."
        cmd="go-global-update"
        gum spin -s minidot --title "Running '$cmd'" -- $cmd
    elif [ "${choice}" = "brew" ]; then
        echo "Updating brew..."
        brew update
        brew upgrade
        brew upgrade $(brew list --cask)
        brew cleanup
        brew autoremove 
        brew doctor
    elif [ "${choice}" = "gh" ]; then
        echo "Updating gh extensions..."
        cmd="gh extension upgrade --all"
        gum spin -s minidot --title "Running '${cmd}'" -- "${cmd}"
    elif [ "${choice}" = "pkgx" ]; then
        echo "Updating pkgx..."
        cmd="pkgx --sync && pkgx --update"
        gum spin -s minidot --title "Running '${cmd}'" -- "${cmd}"
    elif [ "${choice}" = "pip3" ]; then
        echo "Updating pip3..."
        cmd="pip3 --disable-pip-version-check list --outdated --format=json | python3 -c \"import json, sys; print('\n'.join([x['name'] for x in json.load(sys.stdin)]))\" | xargs -n1 pipx install"
        gum spin -s minidot --title "Running pip3 updator" -- "${cmd}"
    elif [ "${choice}" = "modular" ]; then
        echo "Updating Modular Packages..."
        modular list-packages | awk '{print $1}' | xargs -I {} modular update {}
    fi
done
echo "Done!"
