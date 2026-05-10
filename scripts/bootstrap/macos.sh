#!/usr/bin/env bash

macos_brew_shellenv() {
    if [ -x /opt/homebrew/bin/brew ]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    elif [ -x /usr/local/bin/brew ]; then
        eval "$(/usr/local/bin/brew shellenv)"
    fi
}

macos_install_homebrew() {
    if command_exists brew; then
        info "Homebrew is already installed."
        return
    fi

    if confirm "Homebrew is missing. Install it with the official installer?" n 1; then
        run_shell "Installing Homebrew" '/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"'
        macos_brew_shellenv
    else
        die "Homebrew is required for macOS package installation. Install it manually or rerun bootstrap."
    fi
}

macos_ensure_xcode_clt() {
    if xcode-select -p >/dev/null 2>&1; then
        info "Xcode Command Line Tools are installed."
        return
    fi

    if confirm "Xcode Command Line Tools are missing. Start the installer?" n 1; then
        run xcode-select --install
        die "Finish the Xcode Command Line Tools installer, then rerun ./bootstrap.sh."
    else
        die "Xcode Command Line Tools are required for macOS bootstrap."
    fi
}

macos_install_packages() {
    packages=(
        git
        chezmoi
        fish
        tmux
        neovim
        bat
        git-delta
        lazygit
        jq
        zoxide
        atuin
        pyenv
        fzf
        yt-dlp
    )

    missing=()
    for package in "${packages[@]}"; do
        if brew list --formula "$package" >/dev/null 2>&1; then
            info "$package is already installed."
        else
            missing+=("$package")
        fi
    done

    if [ "${#missing[@]}" -eq 0 ]; then
        info "All Homebrew packages are installed."
        return
    fi

    if confirm "Install missing Homebrew packages: ${missing[*]}?" n 1; then
        run brew install "${missing[@]}"
    else
        die "Missing required packages: ${missing[*]}"
    fi
}

bootstrap_macos() {
    if [ "$SKIP_PACKAGES" -eq 1 ]; then
        info "Skipping macOS package installation."
        return
    fi

    macos_ensure_xcode_clt
    macos_brew_shellenv
    macos_install_homebrew
    macos_install_packages
}
