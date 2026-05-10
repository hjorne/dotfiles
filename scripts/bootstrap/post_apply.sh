#!/usr/bin/env bash

install_fisher_plugins() {
    if [ "$SKIP_PLUGINS" -eq 1 ]; then
        info "Skipping Fish plugin installation."
        return
    fi

    if ! command_exists fish && [ "$DRY_RUN" -eq 1 ]; then
        info "[dry-run] fish is not currently installed; package steps would install it before Fisher plugins."
    elif ! command_exists fish; then
        warn "fish is not installed; skipping Fisher plugins."
        return
    fi

    plugin_file="$HOME/.config/fish/fish_plugins"
    if [ ! -f "$plugin_file" ]; then
        plugin_file="$REPO_ROOT/dot_config/fish/fish_plugins"
    fi

    if [ ! -f "$plugin_file" ]; then
        warn "No fish_plugins file found; skipping Fisher plugins."
        return
    fi

    if confirm "Install/update Fisher plugins from $plugin_file?" y 1; then
        run env FISH_PLUGIN_FILE="$plugin_file" fish -c 'if not functions -q fisher; curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source; end; fisher install (cat $FISH_PLUGIN_FILE)'
    else
        warn "Skipped Fisher plugins."
    fi
}

install_tmux_plugin_manager() {
    if [ "$SKIP_PLUGINS" -eq 1 ]; then
        info "Skipping tmux plugin manager installation."
        return
    fi

    if ! command_exists git && [ "$DRY_RUN" -eq 1 ]; then
        info "[dry-run] git is not currently installed; package steps would install it before TPM."
    elif ! command_exists git; then
        warn "git is not installed; skipping TPM."
        return
    fi

    tpm_dir="$HOME/.tmux/plugins/tpm"
    if [ -d "$tpm_dir" ]; then
        info "TPM is already installed at $tpm_dir."
        return
    fi

    if confirm "Install tmux plugin manager to $tpm_dir?" y 1; then
        run mkdir -p "$HOME/.tmux/plugins"
        run git clone https://github.com/tmux-plugins/tpm "$tpm_dir"
        warn "Open tmux and press Ctrl-a then Shift-i to install tmux plugins."
    else
        warn "Skipped TPM installation."
    fi
}

bootstrap_neovim_plugins() {
    if [ "$SKIP_PLUGINS" -eq 1 ]; then
        info "Skipping Neovim plugin bootstrap."
        return
    fi

    if ! command_exists nvim && [ "$DRY_RUN" -eq 1 ]; then
        info "[dry-run] nvim is not currently installed; package steps would install it before plugin sync."
    elif ! command_exists nvim; then
        warn "nvim is not installed; skipping Neovim plugin bootstrap."
        return
    fi

    if [ ! -f "$HOME/.config/nvim/init.lua" ] && [ "$DRY_RUN" -eq 1 ]; then
        info "[dry-run] Neovim config is not currently applied; chezmoi apply would create it before plugin bootstrap."
    elif [ ! -f "$HOME/.config/nvim/init.lua" ]; then
        warn "Neovim config is not applied yet; skipping plugin bootstrap. Run 'chezmoi apply' first, then rerun './bootstrap.sh --skip-packages --skip-chezmoi-apply'."
        return
    fi

    if confirm "Bootstrap Neovim plugins headlessly?" y 1; then
        run nvim --headless '+Lazy! sync' +qa
    else
        warn "Skipped Neovim plugin bootstrap."
    fi
}

configure_fish_login_shell() {
    if [ "$SKIP_CHSH" -eq 1 ]; then
        info "Skipping Fish login shell change."
        return
    fi

    if ! command_exists fish && [ "$DRY_RUN" -eq 1 ]; then
        info "[dry-run] fish is not currently installed; package steps would install it before shell setup."
    elif ! command_exists fish; then
        warn "fish is not installed; skipping login shell change."
        return
    fi

    fish_path=$(command -v fish 2>/dev/null || true)
    if [ -z "$fish_path" ]; then
        if [ "$BOOTSTRAP_OS" = "macos" ]; then
            if [ "$(uname -m)" = "arm64" ]; then
                fish_path=/opt/homebrew/bin/fish
            else
                fish_path=/usr/local/bin/fish
            fi
        else
            fish_path=/usr/bin/fish
        fi
    fi
    bootstrap_user=${USER:-$(id -un)}
    if command_exists getent; then
        current_shell=$(getent passwd "$bootstrap_user" 2>/dev/null | awk -F: '{print $7}')
    elif command_exists dscl; then
        current_shell=$(dscl . -read "/Users/$bootstrap_user" UserShell 2>/dev/null | awk '{print $2}')
    else
        current_shell=${SHELL:-}
    fi

    if [ "$current_shell" = "$fish_path" ]; then
        info "Fish is already the login shell."
        return
    fi

    if confirm "Change login shell from '${current_shell:-unknown}' to '$fish_path'?" n 0; then
        sudo_append_line_if_missing /etc/shells "$fish_path"
        run chsh -s "$fish_path"
    else
        warn "Skipped login shell change."
    fi
}

bootstrap_post_apply() {
    install_fisher_plugins
    install_tmux_plugin_manager
    bootstrap_neovim_plugins
    configure_fish_login_shell
}
