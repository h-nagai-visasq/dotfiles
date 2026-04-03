
local M = {}

M.options = {
    -- unnamed: * register
    -- unnamedplus: + register
}

M.setup_config_file = function()
    vim.api.nvim_create_user_command(
        'Config',
        function()
            vim.cmd.edit(vim.fn.stdpath('config') .. '/init.lua')
        end,
        { desc = "Open Neovim configuration file" }
    )
end

M.setup_movekeys = function()
    -- move option mappings
    vim.keymap.set('n', 'g.', '`.', {silent = true, desc = "goto last change"})
    vim.keymap.set('n', 'g0', '`.0', {silent = true, desc = "goto beginning of last change"})
    vim.keymap.set('n', '<leader>m', ':marks<CR>', {silent = true, desc = "list all marks"})
end

M.setup = function()
    M.setup_config_file()
    M.setup_movekeys()
end

return M
