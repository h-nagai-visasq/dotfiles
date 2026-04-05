# zsh 設定整理・最適化 作業指示書

## 目的

zsh の設定を以下の観点で整理する。

- `.zshenv` を最小化（高速化・責務分離）
- 環境変数と対話設定の分離
- XDG ベースディレクトリへの統一
- OS 非依存性の向上（Mac / Linux / WSL2）
- 可読性・保守性の向上

---

## 現状の問題点

### 1. `.zshenv` に責務過多
- tool-specific 環境変数が多数含まれている
- `.zshenv` は全 zsh 起動で読み込まれるため過剰

### 2. `.zshrc` に環境変数・PATH が混在
- PATH 操作が `.zprofile` と分散
- pyenv の設定が分裂

### 3. compinit の多重実行
- Docker Desktop による追記で複数回実行されている

### 4. Docker Desktop の絶対パス混入
- `/Users/...` 固定パスが dotfiles に含まれている
- 移植性を損なう

### 5. history の配置が不適切
- `XDG_CONFIG_HOME` に配置されている
- 本来は `XDG_STATE_HOME`

---

## 変更方針

### ファイル責務

| ファイル | 役割 |
|--------|------|
| `.zshenv` | 最小環境変数のみ |
| `.zprofile` | login 時の環境構築 |
| `.zshrc` | 対話シェル設定 |
| `.zshalias` | alias |
| `.zinit` | plugin |

---

## 変更内容

---

### 1. home/dot_zshenv

#### 残すもの
- LANG / LC_CTYPE
- XDG 系
- ZDOTDIR
- PAGER / LESS
- LESSHISTFILE
- CLICOLOR
- EDITOR / VISUAL

#### 削除するもの
- npm_config_*
- NVM_DIR
- CARGO_HOME
- RUSTUP_HOME
- GRADLE_USER_HOME
- BUNDLE_*
- GEM_*
- VAGRANT_*
- PASSWORD_STORE_DIR
- RIPGREP_CONFIG_PATH
- その他 tool-specific env

#### 完成形

```zsh
# minimal settings

export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8

: "${XDG_CONFIG_HOME:=$HOME/.config}"
: "${XDG_CACHE_HOME:=$HOME/.cache}"
: "${XDG_DATA_HOME:=$HOME/.local/share}"
: "${XDG_STATE_HOME:=$HOME/.local/state}"
: "${XDG_DATA_DIRS:=/usr/local/share:/usr/share}"
: "${XDG_CONFIG_DIRS:=/etc/xdg}"

export XDG_CONFIG_HOME XDG_CACHE_HOME XDG_DATA_HOME XDG_STATE_HOME
export XDG_DATA_DIRS XDG_CONFIG_DIRS

export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

export PAGER=less
export LESS='-F -g -i -M -R -S -w -X -z-4 -j4'
export LESSHISTFILE="$XDG_STATE_HOME/less/history"

export CLICOLOR=1

export EDITOR='nvim'
export VISUAL='nvim'
```

---

### 2. home/dot_config/zsh/dot_zprofile

#### 役割

- PATH

- Homebrew

- tool-specific env

- pyenv root


#### 追加内容

- tool-specific env をここに移動

- PATH 構築を統一


---

### 3. home/dot_config/zsh/dot_zshrc

#### 修正内容

##### 削除

- PATH 操作

- brew --prefix

- pyenv root

- Docker Desktop 追加ブロック


##### 修正

- compinit を1回のみにする

- HISTFILE を XDG_STATE_HOME に変更


##### 追加

```zsh
if command -v pyenv >/dev/null 2>&1; then
  eval "$(pyenv init - zsh)"
fi
```

---

### 4. Docker Desktop の削除

以下を削除

```zsh
fpath=(/Users/.../.docker/completions ...)
autoload -Uz compinit
compinit
```

代替:

```zsh
if [[ -d "$HOME/.docker/completions" ]]; then
  fpath=("$HOME/.docker/completions" $fpath)
fi
```

---

### 5. history 修正

```zsh
HISTFILE="$XDG_STATE_HOME/zsh/history"
```

---

### 6. alias 改善

```zsh
exa → eza
```

---

### 7. zinit の XDG 化

#### 変更

```zsh
$HOME/.zinit
↓
$XDG_DATA_HOME/zinit
```

---

## 動作確認項目

-  新規 shell 起動がエラーなく動く

-  PATH が正しく通っている

-  pyenv が動く

-  npm global bin が使える

-  starship が表示される

-  history が保存される

-  Docker completion が動く

-  Mac / Linux 両方で動作確認


---

## 注意事項

- `.zshenv` は絶対に重くしない

- `.zshrc` に環境変数を書かない

- OS 固有パスを直書きしない