-- Configuration for the Lua language server

local uv = vim.uv or vim.loop

---@type vim.lsp.Config
return {
    on_init = function(client)
        if client.workspace_folders then
            local path = client.workspace_folders[1].name

            if path ~= vim.fn.stdpath("config")
                and (uv.fs_stat(path .. "/.luarc.json") or uv.fs_stat(path .. "/.luarc.jsonc")) then
                return
            end
        end

        client.config.settings.Lua = vim.tbl_deep_extend("force", client.config.settings.Lua or {}, {
            runtime = {
                version = "LuaJIT",
                path = {
                    "lua/?.lua",
                    "lua/?/init.lua",
                },
            },
            diagnostics = {
                globals = { "vim" },
            },
            workspace = {
                checkThirdParty = false,
                library = {
                    vim.env.VIMRUNTIME,
                    "${3rd}/luv/library",
                },
            },
        })
    end,
    settings = {
        Lua = {},
    },
}
