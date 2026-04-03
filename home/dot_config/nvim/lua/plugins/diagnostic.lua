-- lsp.lua
-- Specify your LSP plugin here

return {
    {
        -- tiny-inline-diagnostic.nvim plugin
        -- A minimal inline diagnostic plugin for Neovim
        "https://github.com/rachartier/tiny-inline-diagnostic.nvim",
        opts = {
            options = {
                show_source = {
                    enabled = true,
                },
            },
        },
        config = function(_, opts)
            vim.diagnostic.config({ virtual_text = false }) -- Disable Neovim's default virtual text diagnostics
            require("tiny-inline-diagnostic").setup(opts)
        end,
    },
    {
        -- hlchunk.nvim plugin
        -- Highlight code chunks based on indentation
        "https://github.com/shellRaining/hlchunk.nvim",
        event = { "BufReadPre", "BufNewFile" },
        opts = {
            chunk = {
                enable = true,
                use_treesitter = true,
                notify = false,
                style = { { fg = "#444488" }, { fg = "#c21f30" } },
            },

        },
    },
}
