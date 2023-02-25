if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Set vi mode
fish_vi_key_bindings

# Allow forward completion in vi-mode
function fish_user_key_bindings
    for mode in insert default visual
        bind -M $mode \cf forward-char
    end
end

# Clear fish greeting
set fish_greeting

# Set up path
set -gx PATH $HOME/.local/bin "$HOME/.cargo/bin" /opt/homebrew/sbin /opt/homebrew/bin $PATH

set -x PAGER bat

# Added by ghcup
#set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin /Users/joe/.ghcup/bin $PATH # ghcup-env

# Init zoxide
zoxide init fish | source

fzf_configure_bindings --directory=\ch
fish_add_path /Users/joe/.spicetify

set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin /Users/joe/.ghcup/bin $PATH # ghcup-env