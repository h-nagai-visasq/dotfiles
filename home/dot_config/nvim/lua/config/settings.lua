-- General Neovim settings

local opt = vim.opt    -- to set options

opt.encoding = "utf-8" -- Set default encoding to UTF-8

opt.foldenable = true
opt.foldmethod = "manual"
opt.incsearch = true -- Shows the match while typing

-- Enable auto read and write
opt.autoread = true
opt.autowriteall = true

-- Disable backup and swap files
opt.backup = false
opt.swapfile = false

-- opt.autochdir=true

opt.number = true -- Show line numbers
opt.signcolumn = "yes"

opt.wrap = false

opt.cursorline = true
-- opt.cursorcolumn = true

-- Make backspace behave in a more intuitive way
opt.backspace = { "indent", "eol", "start" }

-- default tab size and indent size
opt.autoindent = true
opt.smartindent = true
opt.expandtab = true
opt.shiftwidth = 4
opt.softtabstop = 4
opt.tabstop = 4

opt.title = true -- Allows neovom to send the Terminal details of the current window, instead of just getting 'v'

-- setup leader key
vim.g.mapleader = ","

-- Enable mouse support in all modes
opt.mouse = "a"

require("config.clipboard").setup()
require("config.selection").setup()
require("config.util").setup()

require("config.gui").setup()


-- require("config.language_support").setup()  -- LSP settings
