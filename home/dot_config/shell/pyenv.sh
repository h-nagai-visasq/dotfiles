# Enable pyenv on demand for projects that still depend on pyenv/.python-version.
: "${XDG_DATA_HOME:=$HOME/.local/share}"
export PYENV_ROOT="${PYENV_ROOT:-$XDG_DATA_HOME/pyenv}"

if [ -x "$PYENV_ROOT/bin/pyenv" ]; then
  case ":$PATH:" in
    *":$PYENV_ROOT/bin:"*) ;;
    *) PATH="$PYENV_ROOT/bin:$PATH" ;;
  esac
  export PATH
fi

if ! command -v pyenv >/dev/null 2>&1; then
  return 0 2>/dev/null || exit 0
fi

if [ -n "${ZSH_VERSION:-}" ]; then
  _pyenv_shell="zsh"
elif [ -n "${BASH_VERSION:-}" ]; then
  _pyenv_shell="bash"
else
  _pyenv_shell="sh"
fi

eval "$(pyenv init - "$_pyenv_shell")"

if pyenv commands 2>/dev/null | grep -qx 'virtualenv-init'; then
  eval "$(pyenv virtualenv-init -)"
fi

unset _pyenv_shell
