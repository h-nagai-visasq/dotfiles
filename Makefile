
XDG_CONFIG_HOME ?= ${HOME}/.config
XDG_DATA_HOME ?= ${HOME}/.local/share
USER_HOME ?= ${HOME}

# symlink rule
$(USER_HOME)/%: ${CURDIR}/%
	mkdir -p $(@D)
	ln -fs $^ $@

# config rule
.PRECIOUS ${CURDIR}/%:
	touch $@

.PHONY: help
help: ## make taskの説明を表示する
	@grep --no-filename -E '^[0-9a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

# cean
clean: ## - cleanup config w/o bashrc
	rm -fr $(XDG_CONFIG_HOME)/git
	rm -fr $(XDG_CONFIG_HOME)/nvim
	rm -fr $(XDG_DATA_HOME)/nvim
	rm -fr $(XDG_CONFIG_HOME)/tmux
	rm -fr $(XDG_CONFIG_HOME)/zsh
	rm -fr $(XDG_CONFIG_HOME)/wezterm
	rm $(USER_HOME)/.screenrc
	rm $(USER_HOME)/.zshenv
	rm $(USER_HOME)/.screen

# - config all
configure: zsh git wezterm vim tmux screen ## configure all
	@echo "configured"


# install from homebrew
brew-install:
	if ! command -v gh &> /dev/null; then brew install gh; fi
	if ! command -v rg &> /dev/null; then brew install ripgrep; fi
	if ! command -v fd &> /dev/null; then brew install fd; fi
	if ! command -v fzf &> /dev/null; then brew install fzf; fi
	if ! command -v gls &> /dev/null; then brew install coreutils; fi
	if ! command -v tmux &> /dev/null; then brew install tmux; fi
	if ! command -v npm &> /dev/null; then brew install npm; fi
	if ! command -v tree-sitter &> /dev/null; then brew install tree-sitter-cli tree-sitter; fi
	if ! command -v luajit &> /dev/null; then brew install luajit luarocks lua-language-server; fi
	if ! command -v nvim &> /dev/null; then brew install --HEAD neovim; fi

# install wezterm from homebrew
brew-install-weaterm: ## install wezterm from homebrew
	brew install --cask wezterm

# zsh
zsh: $(XDG_CONFIG_HOME)/zsh/.zshrc $(XDG_CONFIG_HOME)/zsh/.zshalias $(XDG_CONFIG_HOME)/zsh/.zprofile $(XDG_CONFIG_HOME)/zsh/.zinit $(USER_HOME)/.zshenv ## zsh config
	@echo "zsh completed"

wezterm: $(XDG_CONFIG_HOME)/wezterm/wezterm.lua ## wezterm config
	@echo "zsh completed"

# bash not install by configure
bash: $(USER_HOME)/.bashrc ## bash config
	@echo "bash completed"

# git
git: $(XDG_CONFIG_HOME)/git/config $(XDG_CONFIG_HOME)/git/ignore  ## git config
	@echo "git completed"

# vim
vim: $(XDG_CONFIG_HOME)/nvim/init.lua ## nvim config
	ln -fs ${CURDIR}/.config/nvim/lua $(XDG_CONFIG_HOME)/nvim/lua
	ln -fs ${CURDIR}/.config/nvim/after $(XDG_CONFIG_HOME)/nvim/after
	ln -fs ${CURDIR}/.config/nvim/lsp $(XDG_CONFIG_HOME)/nvim/lsp
	@echo "neovim completed"

# tmux
tmux: $(XDG_CONFIG_HOME)/tmux/tmux.conf ## tmux config
	git clone https://github.com/tmux-plugins/tpm $(XDG_CONFIG_HOME)/tmux/plugins/tpm
	@echo "tmux completed"

# optional
screen: $(USER_HOME)/.screenrc ## screen config
	@echo "screen completed"

