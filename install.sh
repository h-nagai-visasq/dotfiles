#!/usr/bin/env bash

set -euo pipefail

log() {
  printf '[install] %s\n' "$*"
}

die() {
  printf '[install] %s\n' "$*" >&2
  exit 1
}

detect_os() {
  case "$(uname -s)" in
    Darwin) printf 'darwin' ;;
    Linux) printf 'linux' ;;
    *) die "未対応のOSです: $(uname -s)" ;;
  esac
}

brew_candidates() {
  case "$(detect_os)" in
    darwin)
      printf '%s\n' \
        /opt/homebrew/bin/brew \
        /usr/local/bin/brew
      ;;
    linux)
      printf '%s\n' /home/linuxbrew/.linuxbrew/bin/brew
      ;;
  esac
}

find_brew() {
  if command -v brew >/dev/null 2>&1; then
    command -v brew
    return 0
  fi

  local candidate
  for candidate in $(brew_candidates); do
    if [ -x "$candidate" ]; then
      printf '%s\n' "$candidate"
      return 0
    fi
  done

  return 1
}

install_homebrew() {
  local os
  os="$(detect_os)"

  log "Homebrew をインストールします (${os})"
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

ensure_brew() {
  local brew_bin

  if brew_bin="$(find_brew)"; then
    eval "$("$brew_bin" shellenv)"
    return 0
  fi

  install_homebrew

  brew_bin="$(find_brew)" || die "Homebrew のインストール後に brew が見つかりません"
  eval "$("$brew_bin" shellenv)"
}

main() {
  ensure_brew

  local brew_prefix
  brew_prefix="$(brew --prefix)"

  if ! command -v chezmoi >/dev/null 2>&1; then
    log "chezmoi を brew でインストールします"
    brew install chezmoi
  fi

  log "chezmoi init --apply hidetoshing (${brew_prefix}/bin/chezmoi) を実行します"
  "${brew_prefix}/bin/chezmoi" init --apply hidetoshing
}

main "$@"
