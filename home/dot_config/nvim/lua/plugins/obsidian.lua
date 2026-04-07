return {
    {
        "https://github.com/hidetoshing/obsidianus.nvim",
        cmd = { "Obsidian" },
        keys = {
            { "<leader>oo", "<cmd>Obsidian<CR>", desc = "Open Obsidian vauld" },
            { "<leader>ot", "<cmd>Obsidian daily<CR>", desc = "Open todays daily-note" },
            { "<leader>on", "<cmd>Obsidian new<CR>", desc = "Create a new note" },
            { "<leader>of", "<cmd>Obsidian find<CR>", desc = "find notes" },
        },
        dependencies = {
            "nvim-telescope/telescope.nvim",
        },
        opts = {
            default_vault = "~/Documents/default",
            templates_dir = "templates",
            picker = "telescope",
            notes_subdir = "notes",
        },
    },
}
