-- Description: Configure key mappings for text selection in Neovim

local M = {}

M.setup_keymaps = function()
    vim.keymap.set('i', '<S-down>', '<ESC>v', { silent = true, desc = "Start selection downwards" })
    vim.keymap.set('i', '<S-up>', '<ESC>v<up>', { silent = true, desc = "Start selection upwards" })
    vim.keymap.set('i', '<S-left>', '<ESC>v', { silent = true, desc = "Start selection leftwards" })
    vim.keymap.set('i', '<S-right>', '<ESC><right>v', { silent = true, desc = "Start selection rightwards" })
    vim.keymap.set('x', '<S-down>', '<down>', { silent = true, desc = "Move selection downwards" })
    vim.keymap.set('x', '<S-up>', '<up>', { silent = true, desc = "Move selection upwards" })
    vim.keymap.set('x', '<S-left>', '<left>', { silent = true, desc = "Move selection leftwards" })
    vim.keymap.set('x', '<S-right>', '<right>', { silent = true, desc = "Move selection rightwards" })
end

M.setup = function(args)
    M.setup_keymaps()
end

return M
