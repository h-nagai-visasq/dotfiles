-- Define lualine_helper module

local M = {}

M.lsp_clients = function()
    local clients = vim.lsp.get_clients({ bufnr = 0 })
    if next(clients) == nil then return "󰐰 -" end

    local client_names = {}
    for _, client in pairs(clients) do
        if (client.name == "null-ls") then
            local sources = {}
            for _, source in ipairs(require("null-ls.sources").get_available(vim.bo.filetype)) do
                table.insert(sources, source.name)
            end
            table.insert(client_names, "null-ls(" .. table.concat(sources, ", ") .. ")")
        else
            table.insert(client_names, client.name)
        end
    end
    return "󰐰 " .. table.concat(client_names, ", ")
end

M.current_time = function()
    return os.date("%H:%M") -- 時:分の形式で現在時刻を取得
end

M.buffer_label = function()
    return " buf:"
end

return M