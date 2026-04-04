# Language
export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# XDG
if [[ -z "$XDG_CONFIG_HOME" ]]; then
    #export XDG_CONFIG_HOME="$HOME"/Library/Preferences
    export XDG_CONFIG_HOME="$HOME"/.config
fi

if [[ -z "$XDG_CACHE_HOME" ]]; then
    #export XDG_CACHE_HOME="$HOME"/Library/Caches
    export XDG_CACHE_HOME="$HOME"/.cache
fi

if [[ -z "$XDG_DATA_HOME" ]]; then
    #export XDG_DATA_HOME="$HOME"/Library/Application\ Support
    export XDG_DATA_HOME="$HOME"/.local/share
fi

if [[ -z "$XDG_STATE_HOME" ]]; then
    #export XDG_STATE_HOME="$HOME"/Library/Application\ Support
    export XDG_STATE_HOME="$HOME"/.local/state
fi

if [[ -z "$XDG_DATA_DIRS" ]]; then
    export XDG_DATA_DIRS=/usr/local/share:/usr/share
fi

if [[ -z "$XDG_CONFIG_DIRS" ]]; then
    #export XDG_CONFIG_DIRS=/Library/Preferences
    export XDG_CONFIG_DIRS=/etc/xdg
else
    export XDG_CONFIG_DIRS=/Library/Preferences:"$XDG_CONFIG_DIRS"
fi

# Zsh
export ZDOTDIR="$XDG_CONFIG_HOME"/zsh

# PAGER
export PAGER=less
export LESS='-F -g -i -M -R -S -w -X -z-4 -j4'
export LESSHISTFILE="$XDG_CACHE_HOME"/less/history

# LS
export CLICOLOR=1
# export LSCOLORS=Hxfxcxdxbxhgahhbhehchd
# export LSCOLORS=GxhxdhDhDxehEhhdHdAgag
# export LS_COLORS='di=1;34:ln=32:so=33:pi=33:ex=31:bd=37;46:cd=30;47:su=37;41:sg=37;44:tw=37;42:ow=37;43'
# export LS_COLORS='di=1;36:ln=37:so=33;47:pi=1;33;47:ex=1;33:bd=34;47:cd=1;34;47:su=37;43:sg=1;37;43:tw=1;30;46:ow=30;46'

# Default Editor
# export EDITOR='nvim'
# export VISUAL='nvim'

# Manually moving some to XDG
export TERMINFO="$XDG_DATA_HOME"/terminfo
export TERMINFO_DIRS="$XDG_DATA_HOME"/terminfo:/usr/share/terminfo
export RIPGREP_CONFIG_PATH="$XDG_CONFIG_HOME"/rg/config
export npm_config_userconfig="$XDG_CONFIG_HOME"/npm/config
export npm_config_cache="$XDG_CACHE_HOME"/npm
export npm_config_prefix="$XDG_DATA_HOME"/npm
export npm_config_init_module="$XDG_DATA_HOME"/npm/config/npm-init.js
export NO_UPDATE_NOTIFIER=1
export NVM_DIR="$XDG_DATA_HOME"/nvm
export NODE_REPL_HISTORY="$XDG_DATA_HOME"/node/repl_history
export BUNDLE_USER_CONFIG="$XDG_CONFIG_HOME"/bundle
export BUNDLE_USER_CACHE="$XDG_CACHE_HOME"/bundle
export BUNDLE_USER_PLUGIN="$XDG_DATA_HOME"/bundle
export PUB_CACHE="$XDG_CACHE_HOME"/pub-cache
export GEM_HOME="$XDG_DATA_HOME"/gem
export GEM_SPEC_CACHE="$XDG_CACHE_HOME"/gem/specs
export CP_HOME_DIR="$XDG_CACHE_HOME"/cocoapods
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup
export GRADLE_USER_HOME="$XDG_CACHE_HOME"/gradle
export PSQL_HISTORY="$XDG_DATA_HOME"/psql/history
export MYSQL_HISTFILE="$XDG_DATA_HOME"/mysql/history
export MBOX="$XDG_DATA_HOME"/mail/mbox
export PASSWORD_STORE_DIR="$XDG_DATA_HOME"/pass
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export VAGRANT_HOME="$XDG_DATA_HOME"/vagrant
export VAGRANT_ALIAS_FILE="$XDG_DATA_HOME"/vagrant/aliases
# . "/Users/hidetoshi.nagai/.local/share/cargo/env"
