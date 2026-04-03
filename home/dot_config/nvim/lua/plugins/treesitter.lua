-- treesitter.lua
-- Specify your treesitter plugin here

return {
    {
        -- nvim-treesitter plugin
        -- Provides better syntax highlighting and code understanding
        'https://github.com/nvim-treesitter/nvim-treesitter',
        branch = 'main',
        build = ':TSUpdate', -- command to run after installation
        config = function()
            vim.api.nvim_create_autocmd("FileType", {
                group = vim.api.nvim_create_augroup("vim-treesitter-start", {}),
                callback = function(ctx)
                    -- 必要に応じて`ctx.match`に入っているファイルタイプの値に応じて挙動を制御
                    pcall(vim.treesitter.start)
                end,
            })
        end,
    },
    {
        -- treesitter-context plugin
        -- Shows code context at the top of the window
        'https://github.com/nvim-treesitter/nvim-treesitter-context',
        opts = {},
    },
    {
        "https://github.com/kylechui/nvim-surround",
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end,
    },
}
