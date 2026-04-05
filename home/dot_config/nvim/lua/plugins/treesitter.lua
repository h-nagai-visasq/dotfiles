-- treesitter.lua
-- Specify your treesitter plugin here

return {
    {
        -- nvim-treesitter plugin
        -- Provides better syntax highlighting and code understanding
        'https://github.com/nvim-treesitter/nvim-treesitter',
        branch = 'main',
        event = "VeryLazy",
        build = ':TSUpdate', -- command to run after installation
        config = function()
            vim.api.nvim_create_autocmd("FileType", {
                group = vim.api.nvim_create_augroup("vim-treesitter-start", {}),
                callback = function(ctx)
                    if vim.bo[ctx.buf].buftype ~= "" or vim.bo[ctx.buf].filetype == "" then
                        return
                    end

                    pcall(vim.treesitter.start, ctx.buf)
                end,
            })

            for _, buf in ipairs(vim.api.nvim_list_bufs()) do
                if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buftype == "" and vim.bo[buf].filetype ~= "" then
                    pcall(vim.treesitter.start, buf)
                end
            end
        end,
    },
    {
        -- treesitter-context plugin
        -- Shows code context at the top of the window
        'https://github.com/nvim-treesitter/nvim-treesitter-context',
        event = "VeryLazy",
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
