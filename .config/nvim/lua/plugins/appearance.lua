-- Appearance plugins configuration
-- .config/nvim/lua/plugins/appiarance.lua

return {
    {
        -- nvim-notify plugin
        -- A fancy notification manager for Neovim
        "https://github.com/rcarriga/nvim-notify",
        config = function(_, opts)
            local notify = require("notify")
            notify.setup(opts)
            vim.notify = notify
        end,
    },
    {
        -- noice.nvim plugin
        -- A fancy UI for messages, cmdline and the popupmenu
        "https://github.com/folke/noice.nvim",
        event = "VeryLazy",
        opts = {
            -- add any options here
        },
        dependencies = {
            "https://github.com/MunifTanjim/nui.nvim",
            "https://github.com/rcarriga/nvim-notify",
        }
    },
    {
        -- lualine.nvim plugin
        -- A blazing fast and easy to configure Neovim statusline
        "https://github.com/nvim-lualine/lualine.nvim",
        opts = {
            options = {
                theme = "tokyonight-night",
            },
            sections = {
                lualine_c = {
                    {
                        'filename',
                        symbols = {
                            modified = '󱇧 ',      -- Text to show when the file is modified.
                            readonly = '󰈡 ',      -- Text to show when the file is non-modifiable or readonly.
                            unnamed = '󰡯 ', -- Text to show for unnamed buffers.
                            newfile = '󰝒 ',     -- Text to show for newly created file before first write
                        }                    
                    },
                    'aerial'
                },
                lualine_x = {
                    'encoding',
                    'filetype',
                    -- "require'config.helper_lualine'.lsp_clients()",
                    "lsp_status"
                },
                lualine_z = {
                    'location',
                    --"require'config.helper_lualine'.current_time()"
                },
            },
            tabline = {
                lualine_a = {"require'config.helper_lualine'.buffer_label()"},
                lualine_b = { {
                    "buffers",
                    symbols = {
                        modified = ' ●',      -- Text to show when the buffer is modified
                        alternate_file = ' ', -- Text to show to identify the alternate file
                        directory =  ' ',     -- Text to show when the buffer is a directory
                    },
                } },
                lualine_c = {},
                lualine_x = {},
                lualine_y = {'diff'},
                lualine_z = {'tabs'},
            },
        },
    },
    {
        -- nvim-web-devicons plugin
        -- File type icons for Neovim
        "https://github.com/nvim-tree/nvim-web-devicons",
        lazy = true,
        opts = {},
    },
}

