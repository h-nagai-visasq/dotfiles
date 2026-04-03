-- colorscheme.lua
-- Configure color scheme and appearance-related plugins

return {
    {
        -- tokyonight.nvim plugin
        -- A stylish and modern color scheme for Neovim
        "https://github.com/folke/tokyonight.nvim",
        config = function(_, opts)
            vim.opt.termguicolors = true
            vim.cmd.colorscheme("tokyonight-night")
        end,
    },
}