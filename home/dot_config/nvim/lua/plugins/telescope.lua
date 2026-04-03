-- telescope.lua
-- Specify your telescope plugin here

-- keys telescope setting
    -- f for files / find
    -- G for git / github
    -- b for buffers
    -- r for ripgrep
    -- q for quickfix
    -- j for jump (lsp/tree-sitter)
    -- t for treesitter

return {
    {
        -- telescope.nvim plugin
        -- Fuzzy finder and more
        "https://github.com/nvim-telescope/telescope.nvim",
        keys = {
            { "<leader>:", "<cmd>Telescope commands<CR>", desc = "find Commands" },
            { "<leader>?", "<cmd>Telescope keymaps<CR>", desc = "find Keymaps" },

            { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "find Files" },
            { "<leader>fh", "<cmd>Telescope help_tags<CR>", desc = "find Help Tags" },
            { "<leader>fr", "<cmd>Telescope oldfiles<CR>", desc = "find Recently Files" },

            { "<leader>bb", "<cmd>Telescope buffers<CR>", desc = "find Buffers" },

            { "<leader>rg", "<cmd>Telescope live_grep<CR>", desc = "Live Grep" },

            { "<leader>Q", "<cmd>Telescope quickfix<CR>", desc = "list Quickfix" },

            { "<leader>Gc", "<cmd>Telescope git_commits<CR>", desc = "list Git Commits" },
            { "<leader>Gs", "<cmd>Telescope git_status<CR>", desc = "list Git Status" },
            { "<leader>Gb", "<cmd>Telescope git_branches<CR>", desc = "list Git Branches" },

            { "<leader>gr", "<cmd>Telescope lsp_references<CR>", desc = "goto LSP References" },
            { "<leader>gd", "<cmd>Telescope lsp_definitions<CR>", desc = "goto LSP Definitions" },
            { "<leader>gi", "<cmd>Telescope lsp_implementations<CR>", desc = "goto LSP Implementations" },
            { "<leader>gs", "<cmd>Telescope lsp_document_symbols<CR>", desc = "goto LSP Document symbols" },
            { "<leader>gt", "<cmd>Telescope lsp_type_definitions<CR>", desc = "goto LSP Type Definitions" },
            { "<leader>ga", "<cmd>Telescope aerial<CR>", desc = "goto Aerial symbols" },

            { "<leader>dd", "<cmd>Telescope diagnostics<CR>", desc = "jump diagnostics" },

            { "<leader>ts", "<cmd>Telescope treesitter<CR>", desc = "jump Treesitter Symbols" },

            -- resume last telescope
            { "<leader>.", "<cmd>Telescope resume<CR>", desc = "Resume Telescope" },
        },
        cmd = { "Telescope" },
        opts = {
            extensions = {
                file_browser = {
                    hidden = { file_browser = true, folder_browser = true },
                },
            },
        },
        config = true,
    },
    {
        -- plenary.nvim plugin
        -- Utility functions for Neovim plugins
        "https://github.com/nvim-lua/plenary.nvim",
        lazy = true,
    },
    {
        -- telescope-file-browser.nvim plugin
        -- File browser extension for telescope.nvim
        "https://github.com/nvim-telescope/telescope-file-browser.nvim",
        dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
        keys = {
            { "<leader>fe", "<cmd>Telescope file_browser path=%:p:h select_buffer=true<CR>", desc = "File Browser" },
        },
        config = function(_, opts)
            require("telescope").load_extension("file_browser")
        end,
    },
    {
        -- telescope-ghq.nvim plugin
        -- Ghq extension for telescope.nvim
        "https://github.com/nvim-telescope/telescope-ghq.nvim",
        dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
        keys = {
            { "<leader>Gh", "<cmd>Telescope ghq list<CR>", desc = "List local repositories" },
        },
        config = function(_, opts)
            require("telescope").load_extension("ghq")
        end,
    },
}
