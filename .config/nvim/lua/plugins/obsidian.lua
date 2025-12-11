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
        dependencies = {
            "nvim-lua/plenary.nvim",
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
            daily_notes = {
                folder = "daily-notes",
                date_format = "%Y-%m-%d",
                template = "_templates/daily-notes.md",
            },
            note_id_func = function(title)
                if title ~= nil then
                    return title:gsub('[\\/:%*%?"<>|]', "")
                else
                    return tostring(os.time())
                end
            end,
            note_path_func = function(spec)
                local current_dir = vim.fn.expand("%:p:h")
                return require("plenary.path"):new(current_dir) / (spec.id .. ".md")
            end,
        },
        config = function(_, opts)
            vim.opt.conceallevel = 1 -- for markdown view
            require("obsidian").setup(opts)
        end,
    }
}
