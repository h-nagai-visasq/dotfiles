
local M = {}

M.options = {
    -- unnamed: * register
    -- unnamedplus: + register
}

local function get_current_buffer_path(opts)
    local current_file = vim.api.nvim_buf_get_name(0)
    if current_file == '' then
        return nil, 'Current buffer is not associated with a file'
    end

    if opts.absolute then
        return vim.fn.fnamemodify(current_file, ':p')
    end

    return vim.fn.fnamemodify(current_file, ':.')
end

M.setup_get_path = function()
    vim.api.nvim_create_user_command(
        'GetPath',
        function(command_opts)
            local path, err = get_current_buffer_path({
                absolute = command_opts.args == 'abs',
            })

            if err ~= nil then
                vim.notify(err, vim.log.levels.WARN, { title = 'GetPath' })
                return
            end

            vim.fn.setreg('"', path)
            vim.notify('Yanked: ' .. path, vim.log.levels.INFO, { title = 'GetPath' })
        end,
        {
            nargs = '?',
            complete = function()
                return { 'abs' }
            end,
            desc = 'Yank current buffer path relative to cwd, or absolute with :GetPath abs',
        }
    )
end

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
    vim.keymap.set('n', '[.', '`.', {silent = true, desc = "goto last change"})
    vim.keymap.set('n', '[0', '`.0', {silent = true, desc = "goto beginning of last change"})
    vim.keymap.set('n', '<leader>m', ':marks<CR>', {silent = true, desc = "list all marks"})
end

M.setup = function()
    M.setup_get_path()
    M.setup_config_file()
    M.setup_movekeys()
end

return M
