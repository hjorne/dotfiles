if test -x /opt/homebrew/bin/brew
    eval "$(/opt/homebrew/bin/brew shellenv)"
end

fish_add_path --global $HOME/.local/bin $HOME/.cargo/bin
if test -d /opt/homebrew/sbin
    fish_add_path --global /opt/homebrew/sbin /opt/homebrew/bin
end

if status is-interactive
    # Commands to run in interactive sessions can go here
    if type -q zoxide
        zoxide init fish | source
    end

    if type -q atuin
        atuin init fish | source
    end

    if type -q pyenv
        pyenv init - | source
    end

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
    set -x EDITOR nvim
end


# The next line updates PATH for the Google Cloud SDK.
# if test -f "$HOME/Documents/google-cloud-sdk/path.fish.inc"; source "$HOME/Documents/google-cloud-sdk/path.fish.inc"; end

if test -x /usr/libexec/java_home
    set -l java_home (/usr/libexec/java_home -v 21 2>/dev/null)
    if test $status -eq 0; and test -n "$java_home"
        set -gx JAVA_HOME $java_home
    end
end
