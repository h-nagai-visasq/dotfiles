eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(pyenv init -)"

# additional path
path=(
    $PYENV_ROOT/bin(N-/)
    $HOME/.nodebrew/current/bin(N-/)
    $HOME/bin(N-/)
    $HOME/.local/bin(N-/)
    $(brew --prefix)/opt/mysql-client/bin(N-/)
    $(brew --prefix coreutils)/libexec/gnubin(N-/)
    /usr/local/bin(N-/)
    $path
)
