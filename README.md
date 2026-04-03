# dotfiles

## クイックスタート

すべてのセットアップは `install.sh` 1 本で完了します。Homebrew が無い環境でも自動導入され、その後 chezmoi を経由して dotfiles 全体を適用します。

```bash
curl -fsSL https://raw.githubusercontent.com/hidetoshing/dotfiles/master/install.sh | sh
```

### このコマンドが行うこと

1. **Homebrew の導入**
   - macOS: `/opt/homebrew` 優先
   - Linux: `/home/linuxbrew/.linuxbrew`
2. **chezmoi の導入** (`brew install chezmoi`)
3. **chezmoi init/apply** (`chezmoi init --apply hidetoshing`) で `home/` 以下のテンプレートを展開
4. **run_once / run_onchange スクリプト**
   - zinit / TPM / lazy.nvim を自動クローン
   - `brew bundle` ＋ `brew bundle --file=Brewfile.darwin` (macOS 時)
   - `mise install` で runtimes を管理
   - fzf のキーバインド／補完を `brew --prefix` 配下から再構成

## レポジトリアーキテクチャ

| ディレクトリ | 役割 |
| --- | --- |
| `Brewfile` | macOS / Linux 共通の CLI ツール (gh, ripgrep, mise など) |
| `Brewfile.darwin` | macOS 専用の cask / GUI (wezterm 等) |
| `mise.toml` | `node = "lts"`, `python = "3.11"` などランタイム定義 |
| `.chezmoi.toml.tmpl` | chezmoi の sourceDir を `home/` 配下に固定し、OS 判定フラグを提供 |
| `home/` | 実際の dotfiles (`home/dot_config/...`) と run\_once/run\_onchange スクリプト |

## OS ごとの挙動

- **共通**: `install.sh` で Homebrew → chezmoi → `Brewfile` → `mise` を順番に適用
- **macOS だけ**: `Brewfile.darwin` を追加で `brew bundle` し、GUI アプリや cask (wezterm など) を導入
- **Linux だけ**: Homebrew は `/home/linuxbrew/.linuxbrew` に展開され、cask 部分はスキップ

## mise ランタイム管理

- `mise.toml` に `node = "lts"`, `python = "3.11"` を定義
- chezmoi の run\_onchange スクリプトが `mise install` を実行（`CHEZMOI_SKIP_MISE_INSTALL=1` で一時スキップ可能）
- ランタイムのバージョン固定や追加は `mise.toml` を編集し `chezmoi apply` を再実行するだけ

## 各種設定 (home/dot_config/)

- **zsh**: XDG ベースの `~/.config/zsh` に `.zshrc/.zprofile/.zshalias/.zinit` を展開。zinit による plugin 管理を run\_once スクリプトで自動化。
- **tmux**: `~/.config/tmux/tmux.conf` を展開し、TPM を run\_once で自動クローン。leader は `<C-t>`。
- **git**: `~/.config/git/config` と `ignore` を適用。エイリアスや `ghq.root` などを統合管理。
- **starship**: `~/.config/starship.toml` を展開し、左側がリポジトリ、右側がランタイム／所要時間を表示。
- **neovim**: `lazy.nvim` ベースの Lua 構成。`run_once_install-lazy-nvim.sh.tmpl` が lazy.nvim を所定のパスに展開し、`home/dot_config/nvim/**` を適用。
- **fzf**: `run_onchange_install-fzf.sh.tmpl` が `$(brew --prefix)/opt/fzf/install` を叩き、zsh/tmux 用キーバインドと補完をセットアップ。
