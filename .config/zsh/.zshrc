# homebrew setting (Normally this command is executed by .zprofile)
eval "$(/opt/homebrew/bin/brew shellenv)"

autoload -Uz zmv
alias zmv='noglob zmv -W'

# pyenv
export PYENV_ROOT=$(pyenv root)

# additional path
path=(
    $PYENV_ROOT/bin(N-/)
    $HOME/.nodebrew/current/bin(N-/)
    $HOME/bin(N-/)
    $(brew --prefix)/opt/mysql-client/bin(N-/)
    $(brew --prefix coreutils)/libexec/gnubin(N-/)
    /usr/local/bin(N-/)
    $path
)

manpath=(
    $(brew --prefix coreutils)/libexec/gnuman(N-/)
    $manpath
)

# starship setting
eval "$(starship init zsh)"

# load compinit
autoload -U compinit && compinit

### historical backward/forward search with linehead string binded to ^P/^N
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

bindkey "^p" history-beginning-search-backward-end
bindkey "^n" history-beginning-search-forward-end
bindkey "\\ep" history-beginning-search-backward-end
bindkey "\\en" history-beginning-search-forward-end

# Command history configuration
setopt hist_ignore_dups     # ignore duplication command history list
setopt HIST_IGNORE_SPACE
setopt share_history        # share command history data
setopt inc_append_history

HISTFILE=$XDG_CONFIG_HOME/zsh/history
HISTSIZE=100000
SAVEHIST=$HISTSIZE


# load aliases
source $XDG_CONFIG_HOME/zsh/.zshalias

if [[ -f $HOME/.zshalias ]]; then
    source $HOME/.zshalias
fi

# load local .zshrc if exists
if [[ -f $HOME/.zshrc ]]; then
    source $HOME/.zshrc
fi

if [[ -d $XDG_CONFIG_HOME/zsh/plugins ]]; then
    source $XDG_CONFIG_HOME/zsh/plugins/*.zsh
fi


# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/hidetoshi.nagai/.docker/completions $fpath)
autoload -Uz compinit
compinit
# End of Docker CLI completions

source $XDG_CONFIG_HOME/zsh/.zinit
