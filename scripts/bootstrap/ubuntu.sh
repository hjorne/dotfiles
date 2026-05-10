#!/usr/bin/env bash

ubuntu_assert_supported() {
    if [ ! -r /etc/os-release ]; then
        die "Cannot read /etc/os-release. This bootstrap supports Ubuntu Linux only."
    fi

    # shellcheck disable=SC1091
    . /etc/os-release

    if [ "${ID:-}" != "ubuntu" ]; then
        die "Unsupported Linux distribution: ${PRETTY_NAME:-unknown}. This bootstrap supports Ubuntu only."
    fi

    info "Detected ${PRETTY_NAME:-Ubuntu}."
}

ubuntu_install_packages() {
    packages=(
        git
        curl
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
        if dpkg-query -W -f='${Status}' "$package" 2>/dev/null | grep -q 'install ok installed'; then
            info "$package is already installed."
        else
            missing+=("$package")
        fi
    done

    if [ "${#missing[@]}" -eq 0 ]; then
        info "All apt packages are installed."
        return
    fi

    if confirm "Install missing apt packages: ${missing[*]}?" n 1; then
        sudo_run apt-get update
        sudo_run env DEBIAN_FRONTEND=noninteractive apt-get install -y "${missing[@]}"
    else
        die "Missing required apt packages: ${missing[*]}"
    fi
}

ubuntu_install_chezmoi() {
    ensure_local_bin_on_path

    if command_exists chezmoi; then
        info "chezmoi is already installed."
        return
    fi

    if ! command_exists curl && [ "$DRY_RUN" -eq 1 ]; then
        info "[dry-run] curl is not currently installed; apt package steps would install it before chezmoi."
    elif ! command_exists curl; then
        die "curl is required to install chezmoi. Re-run without --skip-packages."
    fi

    if confirm "chezmoi is missing. Install it to ~/.local/bin with the official installer?" n 1; then
        run mkdir -p "$HOME/.local/bin"
        run_shell "Installing chezmoi" "sh -c \"\$(curl -fsLS get.chezmoi.io)\" -- -b \"$HOME/.local/bin\""
        ensure_local_bin_on_path
    else
        die "chezmoi is required to apply these dotfiles."
    fi
}

bootstrap_ubuntu() {
    ubuntu_assert_supported

    if [ "$SKIP_PACKAGES" -eq 1 ]; then
        info "Skipping Ubuntu package installation and chezmoi install."
        return
    fi

    ubuntu_install_packages
    ubuntu_install_chezmoi
}
