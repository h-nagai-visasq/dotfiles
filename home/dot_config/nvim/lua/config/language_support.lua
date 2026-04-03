-- LSP settings

-- See `:help vim.lsp` for documentation on any of the below functions
-- See https://github.com/neovim/nvim-lspconfig for language server setup

local M = {}

local autocompletion_setup = function()
    vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("my.lsp", {}),
        callback = function(args)
            local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

            -- 補完の設定
            if client:supports_method('textDocument/completion') then
                -- 文字を入力する度に補完を表示（遅くなる可能性あり）
                -- local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end
                -- client.server_capabilities.completionProvider.triggerCharacters = chars

                -- 特定の文字で補完を表示
                client.server_capabilities.completionProvider.triggerCharacters = { '.', '::', '->', ':::', '>' }

                -- 補完を有効化
                vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
            end
        end,
    })
end

local autoformat_setup = function()
    vim.api.nvim_create_autocmd("LspAttach",{
        group = vim.api.nvim_create_augroup("my.lsp", {}),
        callback = function(args)
            local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

            -- フォーマット
            if not client:supports_method('textDocument/willSaveWaitUntil')
                and client:supports_method('textDocument/formatting') then
                vim.api.nvim_create_autocmd('BufWritePre', {
                    group = vim.api.nvim_create_augroup('my.lsp', { clear = false }),
                    buffer = args.buf,
                    callback = function()
                        vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 3000 })
                    end,
                })
            end
        end,
    })
end

M.setup = function()
    -- LSP settings can be configured here if needed

    -- autocompletion_setup()
    -- autoformat_setup()
end

return M
