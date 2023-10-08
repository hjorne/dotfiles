eval "$(/opt/homebrew/bin/brew shellenv)"

set -gx PATH $HOME/.local/bin "$HOME/.cargo/bin" /opt/homebrew/sbin /opt/homebrew/bin $PATH

if status is-interactive
    # Commands to run in interactive sessions can go here
    zoxide init fish | source

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

    set -x PAGER bat
end


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/joe/Documents/google-cloud-sdk/path.fish.inc' ]; . '/Users/joe/Documents/google-cloud-sdk/path.fish.inc'; end
