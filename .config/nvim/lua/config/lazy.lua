-- .config/nvim/lua/config/lazy.lua
-- Configure lazy.nvim plugin manager

-- Install lazy.nvim if not already installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Configure lazy.nvim
require("lazy").setup({
    spec = {
        -- appiarance
        { import = "plugins.colorscheme" },
        { import = "plugins.appearance" },

        -- functionality
        { import = "plugins.treesitter" },
        { import = "plugins.lsp" },
        { import = "plugins.diagnostic" },
        { import = "plugins.completion" },
        { import = "plugins.git" },

        -- fuzzy finder
        { import = "plugins.telescope" },
        -- filetree
        { import = "plugins.filetree" },

        -- editing
        { import = "plugins.obsidian" },
    },
})
