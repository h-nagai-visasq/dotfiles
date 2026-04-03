-- Avante theme plugin configuration
-- .config/nvim/lua/plugins/avante.lua

return {
    {
        -- Avante.nvim plugin
        -- A Neovim theme inspired by Avante GUI design
        "https://github.com/yetone/avante.nvim",
        -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
        build = vim.fn.has("win32") ~= 0
        and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
        or "make",
        event = "VeryLazy",
        version = false, -- Never set this value to "*"! Never!
        ---@module 'avante'
        opts = {
        },
    }
}
