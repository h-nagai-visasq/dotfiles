-- lsp.lua
-- Specify your LSP plugin here

return {
    {
        -- neo-tree.nvim plugin
        -- A file explorer tree for Neovim
        "https://github.com/nvim-neo-tree/neo-tree.nvim",
        dependencies = {
            "https://github.com/nvim-lua/plenary.nvim",
            "https://github.com/MunifTanjim/nui.nvim",
            "https://github.com/nvim-tree/nvim-web-devicons", -- optional, but recommended
        },
        lazy = false, -- neo-tree will lazily load itself
        keys = {
            { "<leader>ee", "<cmd>Neotree source=filesystem reveal=true position=left<CR>", desc = "File Tree" },
            { "<leader>ef", "<cmd>Neotree float<CR>", desc = "Float File Tree" },
            { "<leader>eq", "<cmd>Neotree close<CR>", desc = "Close File Tree" },
            { "<leader>eb", "<cmd>Neotree buffer<CR>", desc = "Buffer Tree" },
        },
        opts = {
            open_files_using_relative_paths = true,
            close_if_last_window = true,
            filesystem = {
                filtered_items = {
                    visible = true, -- This will show hidden files
                    hide_dotfiles = false,
                    hide_gitignored = false,
                },
                follow_current_file = {
                    enabled = true,
                    leave_dirs_open = false,
                },
            },
        },
    },
}
