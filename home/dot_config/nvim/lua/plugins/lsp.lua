-- lsp.lua
-- Specify your LSP plugin here

return {
    {
        -- mason.nvim plugin
        -- Manage external LSP servers, DAP servers, linters, and formatters
        "https://github.com/mason-org/mason.nvim",
        build = ":MasonUpdate",
        cmd = { "Mason", "MasonUpdate", "MasonLog", "MasonInstall", "MasonUninstall", "MasonUninstallAll" },
        config = true,
    },
    {
        -- mason-lspconfig.nvim plugin
        -- Bridge between mason.nvim and nvim-lspconfig
        "https://github.com/mason-org/mason-lspconfig.nvim",
        dependencies = {
            { "mason-org/mason.nvim", },
            { "neovim/nvim-lspconfig", },
        },
        event = { "BufReadPre", "BufNewFile" },
        keys = {
            { "<C-space>", "<cmd>lua vim.lsp.completion.get()  <CR>", mode = "i" },
            { "gh",        "<cmd>lua vim.lsp.buf.hover()       <CR>" },
            { "gd",        "<cmd>lua vim.lsp.buf.definition()  <CR>" },
            { "gD",        "<cmd>lua vim.lsp.buf.declaration() <CR>" },
        },
        config = true,
    },
    {
        -- nvim-lsp-notify plugin
        -- Notify LSP progress and messages in Neovim
        "https://github.com/mrded/nvim-lsp-notify",
        event = { "BufReadPre", "BufNewFile" },
        opt = {},
    },
    {
        -- glance.nvim plugin
        -- A code peek and definition viewer for Neovim
        "https://github.com/dnlhc/glance.nvim",
        cmd = 'Glance',
        keys = {
            { "<leader>wd", "<cmd>Glance definitions<CR>",      desc = "Glance Definitions" },
            { "<leader>wr", "<cmd>Glance references<CR>",       desc = "Glance References" },
            { "<leader>wt", "<cmd>Glance type_definitions<CR>", desc = "Glance Type Definitions" },
            { "<leader>wi", "<cmd>Glance implementations<CR>",  desc = "Glance Implementations" },
        },
        opts = {
            border = {
                enable = true, -- Show window borders. Only horizontal borders allowed
            },
        },
    },
    {
        -- aerial.nvim plugin
        -- A code outline window for Neovim
        "https://github.com/stevearc/aerial.nvim",
        event = { "BufReadPost", "BufWritePost", "BufNewFile" },
        keys = {
            { "<leader>wa", "<cmd>AerialOpen<cr>", desc = "toggle Aerial" },
            { "<leader>wf", "<cmd>AerialFocus<cr>",  desc = "focus Aerial" },
            -- etc.
        },
        opts = {
            -- your options... For example:
            attach_mode = "global",
            backends = { "treesitter", "lsp", "markdown", "asciidoc", "man" },
            show_guides = true,
        },
        config = function(_, opts)
            require("aerial").setup(opts)
            require("telescope").load_extension("aerial")
        end,
    },
}
