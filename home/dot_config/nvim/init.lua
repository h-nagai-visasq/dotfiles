-- init.lua

-- Enable Lua module loader for Neovim 0.9+
if vim.loader then vim.loader.enable() end

-- skipped builtins
vim.g.loaded_gzip = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_fzf = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_logiPat = 1
vim.g.loaded_rrhelper = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1
vim.g.loaded_netrwFileHandlers = 1
vim.g.loaded_remote_plugins = 1

vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

-- python path. requierd pyenv global python version.
-- Mason required < 3.14. 3.13.9 used.
vim.g.python3_host_prog = vim.env.HOME .. '/shims/python'

-- Load general settings
require("config.settings")

-- Load the lazy.nvim plugin manager
require("config.lazy")

-- Load user commands
-- require("config.commands")
