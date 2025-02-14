-- keymaps.lua: Raccourcis personnalisés
vim.g.mapleader = "\\" -- Leader key

-- Toggle NvimTree
vim.api.nvim_set_keymap('n', '<leader>d', ':NvimTreeToggle<CR>', { noremap = true, silent = true, desc = 'TreeToggle' })

-- Add groups "File/Search" & "Navigation"
vim.keymap.set('n', '<leader>f', '<Nop>', { desc = 'File/Search' }) -- Groupe "f"
vim.keymap.set('n', '<leader>n', '<Nop>', { desc = 'NavTab' })      -- Groupe "n"

-- Shortcut tab
vim.api.nvim_set_keymap('n', '<leader>nn', ':tabnew<CR>', { noremap = true, silent = true, desc = 'NewTab' })
vim.api.nvim_set_keymap('n', '<leader>nc', ':tabclose<CR>', { noremap = true, silent = true, desc = 'CloseTab' })
-- Change tab with Ctrl + right / left
vim.api.nvim_set_keymap('n', '<C-Right>', ':tabnext<CR>', { noremap = true, silent = true, desc = 'Next Tab' })
vim.api.nvim_set_keymap('n', '<C-Left>', ':tabprev<CR>', { noremap = true, silent = true, desc = 'Previous Tab' })

-- Shortcut Telescope
local status, builtin = pcall(require, "telescope.builtin")
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'help tags' })

-- Floaterm
vim.api.nvim_set_keymap('t', '<Esc>', '<C-\\><C-n>:FloatermHide<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>t', ':FloatermToggle<CR>',
{ noremap = true, silent = true, desc = 'Open Terminal' })


-- iLoad file -> stdheader.vim
local header_path = "/usr/share/vim/vim85/plugin/stdheader.vim"
if vim.loop.fs_stat(header_path) then
	vim.cmd("source " .. header_path)
end

-- Header school 42
vim.api.nvim_set_keymap('n', '<leader>h', ':Stdheader<CR>', { noremap = true, silent = true, desc = 'Add 42 Header' })
