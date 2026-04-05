-- Configuration for vtsls with Vue support

local vue_language_server_path = vim.fn.stdpath("data")
    .. "/mason/packages/vue-language-server/node_modules/@vue/language-server"

local has_vue_plugin = (vim.uv or vim.loop).fs_stat(vue_language_server_path) ~= nil

---@type vim.lsp.Config
return {
    filetypes = {
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        "vue",
    },
    settings = {
        vtsls = {
            tsserver = {
                globalPlugins = has_vue_plugin and {
                    {
                        name = "@vue/typescript-plugin",
                        location = vue_language_server_path,
                        languages = { "vue" },
                        configNamespace = "typescript",
                    },
                } or {},
            },
        },
    },
}
