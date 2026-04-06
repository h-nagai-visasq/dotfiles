# dotfiles

## クイックスタート

すべてのセットアップは `install.sh` 1 本で完了します。Homebrew が無い環境でも自動導入され、その後 chezmoi を経由して dotfiles 全体を適用します。

```bash
curl -fsSL https://raw.githubusercontent.com/hidetoshing/dotfiles/master/install.sh | bash
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

| ディレクトリ              | 役割                                                                              |
| ------------------------- | --------------------------------------------------------------------------------- |
| `Brewfile`                | macOS / Linux 共通の CLI ツール (gh, ripgrep, mise など)                          |
| `Brewfile.darwin`         | macOS 専用の cask / GUI (wezterm 等)                                              |
| `mise.toml`               | `node = "lts"`, `python = "3.11"` などランタイム定義                              |
| `.chezmoiroot`            | `home/` を source ルートとして扱わせ、初回 `chezmoi apply` から全 dotfiles を適用 |
| `home/.chezmoi.toml.tmpl` | OS 判定フラグ (`.data.is_darwin` など) を提供し、テンプレート側の条件分岐に活用   |
| `home/`                   | 実際の dotfiles (`home/dot_config/...`) と run_once/run_onchange スクリプト       |

## OS ごとの挙動

- **共通**: `install.sh` で Homebrew → chezmoi → `Brewfile` → `mise` を順番に適用
- **macOS だけ**: `Brewfile.darwin` を追加で `brew bundle` し、GUI アプリや cask (wezterm など) を導入
- **Linux だけ**: Homebrew は `/home/linuxbrew/.linuxbrew` に展開され、cask 部分はスキップ

## mise ランタイム管理

- `mise.toml` に `node = "lts"`, `python = "latest"` を定義
- chezmoi の run_onchange スクリプトが `mise install` を実行（`CHEZMOI_SKIP_MISE_INSTALL=1` で一時スキップ可能）
- ランタイムのバージョン固定や追加は `mise.toml` を編集し `chezmoi apply` を再実行するだけ
- `~/.config/mise/config.toml` で既存 `.venv` を自動有効化し、`pyenv` の init には依存しない運用に統一
- `pyenv` 依存プロジェクト向けに `source ~/.config/shell/pyenv.sh` を用意し、必要なセッションだけ `pyenv` / `pyenv-virtualenv` を有効化できる

## 各種設定 (home/dot_config/)

- **zsh**: XDG ベースの `~/.config/zsh` に `.zshrc/.zprofile/.zshalias/.zinit` を展開。zinit は `$XDG_DATA_HOME/zinit` 配下へ run_once スクリプトで自動クローンされる。
- **tmux**: `~/.config/tmux/tmux.conf` を展開し、TPM を run_once で自動クローン。leader は `<C-t>`。
- **git**: `~/.config/git/config` と `ignore` を適用。エイリアスや `ghq.root` などを統合管理。
- **starship**: `~/.config/starship.toml` を展開し、左側がリポジトリ、右側がランタイム／所要時間を表示。
- **neovim**: `lazy.nvim` ベースの Lua 構成。`run_once_install-lazy-nvim.sh.tmpl` が lazy.nvim を所定のパスに展開し、`home/dot_config/nvim/**` を適用。
  `mason-lspconfig.nvim` で `python / lua / shell(zsh, bash) / html / JavaScript / React / Vue / Docker / Go / Rust / Markdown / Makefile / GitHub Copilot` 向けの代表的な LSP を初回起動時から自動導入します。
  `conform.nvim` と `nvim-lint` で上記言語向けの Formatter / Linter も連携し、CLI ツールは Mason から自動導入します。
  保存時の自動フォーマットは既定で無効化しており、必要な場合は `:FormatEnable` / `:FormatDisable` (`!` 付きでバッファローカル) と `:Format` で手動制御できます。
- **fzf**: `run_onchange_install-fzf.sh.tmpl` が `$(brew --prefix)/opt/fzf/install` を叩き、zsh/tmux 用キーバインドと補完をセットアップ。
