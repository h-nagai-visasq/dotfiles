
local M = {}

M.options = {
    -- unnamed: * register
    -- unnamedplus: + register
    clipboard = {'unnamedplus,unnamed'},
}

M.setup_options = function()
    vim.opt.clipboard:append(M.options.clipboard)
end

M.setup_keymaps = function()
    -- Make 'Y' behave like 'D' and 'C' (yank to end of line)
    vim.keymap.set('n', 'Y', 'y$<ESC>')

    -- vscdode-like clipboard keymaps
    vim.keymap.set({'n', 'x', 'c'}, '<C-c>', '"+y', {silent = true, desc = "Copy to system clipboard"})
    vim.keymap.set({'n', 'x', 'c'}, '<D-c>', '"+y', {silent = true, desc = "Copy to system clipboard"})

    vim.keymap.set({'n', 'x', 'c'}, '<C-x>', '"+x', {silent = true, desc = "Cut to system clipboard"})
    vim.keymap.set({'n', 'x', 'c'}, '<D-x>', '"+x', {silent = true, desc = "Cut to system clipboard"})

    vim.keymap.set({'n', 'x', 'c'}, '<C-v>', '"+P', {silent = true, desc = "Paste from system clipboard"})
    vim.keymap.set('i', '<C-v>', '<C-r>+', {silent = true, desc = "Paste from system clipboard"})
    vim.keymap.set({'n', 'x', 'c'}, '<D-v>', '"+P', {silent = true, desc = "Paste from system clipboard"})
    vim.keymap.set('i', '<D-v>', '<C-r>+', {silent = true, desc = "Paste from system clipboard"})  -- for macOS
end

M.setup = function()
    M.setup_options()
    M.setup_keymaps()
end

return M
