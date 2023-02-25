# Source environment variables
if [ -f ~/.profile ]; then
	source ~/.profile
fi

if [ -f ~/.zsh_aliases ]; then
	source ~/.zsh_aliases
fi


# Set name of the theme to load 
ZSH_THEME="norm"

# Enable command auto-correction.
ENABLE_CORRECTION="true"

# Display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="mm/dd/yyyy"

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
)

export ZSH=$HOME/.oh-my-zsh

source $ZSH/oh-my-zsh.sh

# Set ZSH options
unsetopt correct_all

export EDITOR=nvim
export GIT_EDITOR=nvim

set -o vi

# Allow for backwards search with hotkey in vi bindings
bindkey -v
bindkey '^R' history-incremental-search-backward

eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(zoxide init zsh)"
#any-nix-shell zsh --info-right | source /dev/stdin
#eval "$(direnv hook zsh)"

#source /usr/local/bin/z.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
