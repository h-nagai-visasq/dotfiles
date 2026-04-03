
local M = {}

M.options = {
    -- unnamed: * register
    -- unnamedplus: + register
}

M.setup_for_neovide = function()
    if vim.g.neovide then
        -- Put anything you want to happen only in Neovide here
        vim.o.guifont = "moralerspace argon:h14"
    end
end

M.setup = function()
    M.setup_for_neovide()
end

return M
