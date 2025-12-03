return {
    {
        "https://github.com/obsidian-nvim/obsidian.nvim",
        version = "*", -- recommended, use latest release instead of latest commit
        cmd = { "Obsidian" },
        keys = {
            { "<leader>ot", "<cmd>Obsidian today<CR>", desc = "Open todays daily-note" },
            { "<leader>on", "<cmd>Obsidian new<CR>", desc = "Create a new note" },
            { "<leader>ob", "<cmd>Obsidian backlinks<CR>", desc = "Show backlinks" },
        },
        event = {
            "BufReadPre " .. vim.fn.expand "~" .. "/Documents/default/*.md",
            "BufNewFile "  .. vim.fn.expand "~" .. "/Documents/default/*.md",
        },
        ---@module 'obsidian'
        opts = {
            workspaces = {
                {
                    name = "default",
                    path = "~/Documents/default",
                },
            },
            legacy_commands = false,
        },
        config = function(_, opts)
            vim.opt.conceallevel = 1 -- for markdown view
            require("obsidian").setup(opts)
        end,
    }
}
