-- Completion plugin configuration
-- .config/nvim/lua/plugins/completion.lua

return {
    -- blink.cmp plugin
    -- A fast and lightweight completion plugin for Neovim
    'https://github.com/saghen/blink.cmp',
    version = '*',
    dependencies = { 'https://github.com/rafamadriz/friendly-snippets' },
    event = { "InsertEnter", "CmdLineEnter" },
    opts_extend = { "sources.default" },

    ---@module 'blink.cmp'
    opts = {
        keymap = {
            preset = 'default',
            -- 補完と署名ヘルプは明示操作でのみ開く
            ['<C-Space>'] = { 'show', 'show_documentation', 'hide_documentation' },
            ['<C-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
        },
        -- enabled = function() return not vim.tbl_contains({ "markdown" }, vim.bo.filetype) end,
        completion = {
            documentation = {
                window = { border = "rounded" },
                auto_show = false,
            },
            menu = {
                auto_show = false,
                border = "rounded",
                draw = {
                    treesitter = { 'lsp' },
                    columns = { { 'kind_icon' }, { 'label', 'label_description', gap = 1 }, { 'source_name' }, },
                },
            },
            trigger = {
                prefetch_on_insert = false,
                show_on_keyword = false,
                show_on_trigger_character = false,
                show_on_insert = false,
                show_on_backspace = false,
                show_on_backspace_in_keyword = false,
                show_on_backspace_after_accept = false,
                show_on_backspace_after_insert_enter = false,
                show_on_accept_on_trigger_character = false,
                show_on_insert_on_trigger_character = false,
            },
        },
        sources = {
            default = { 'lsp', 'path', 'snippets', 'buffer' },
            providers = {
                snippets = {
                    -- `.` や `>` 直後は LSP 補完を優先し、HTML/JS系で snippet 候補が暴れすぎないようにする
                    should_show_items = function(ctx)
                        return ctx.trigger.initial_kind ~= 'trigger_character'
                    end,
                },
            },
        },
        signature = {
            enabled = true,
            trigger = {
                enabled = false,
                show_on_keyword = false,
                show_on_trigger_character = false,
                show_on_insert = false,
                show_on_insert_on_trigger_character = false,
            },
            window = { border = "rounded" },
        },
    },
}
