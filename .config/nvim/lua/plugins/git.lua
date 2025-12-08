-- lsp.lua
-- Specify your LSP plugin here

return {
    {
        -- gitsigns.nvim plugin
        -- Git integration for buffers in Neovim
        "https://github.com/lewis6991/gitsigns.nvim",
        event = { "BufReadPre", "BufNewFile" },
        opts = {},
    },
    {
        -- gitlinker.nvim plugin
        -- Generate shareable Git repository links for code
        "https://github.com/linrongbin16/gitlinker.nvim",
        cmd = "GitLink",
        keys = {
            { "<leader>Gy", "<cmd>GitLink<CR>", mode = { "n", "v" }, desc = "Yank git link" },
            { "<leader>Gx", "<cmd>GitLink!<CR>", mode = { "n", "v" }, desc = "Open git link" },
        },
        opts = {},
    },
    {
        "https://github.com/kdheepak/lazygit.nvim",
        cmd = {
            "LazyGit",
            "LazyGitConfig",
            "LazyGitCurrentFile",
            "LazyGitFilter",
            "LazyGitFilterCurrentFile",
        },
        -- optional for floating window border decoration
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        -- setting the keybinding for LazyGit with 'keys' is recommended in
        -- order to load the plugin when the command is run for the first time
        keys = {
            { "<leader>Gl", "<cmd>LazyGit<cr>", desc = "LazyGit" }
        }
    },
}
