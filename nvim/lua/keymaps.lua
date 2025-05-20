-- keymaps.lua
vim.g.mapleader = " "

-- Tree toggle
vim.api.nvim_set_keymap('n', '<leader>d', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

-- Tabs
vim.api.nvim_set_keymap('n', '<leader>nn', ':tabnew<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>nc', ':tabclose<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-Right>', ':tabnext<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-Left>', ':tabprev<CR>', { noremap = true, silent = true })

-- Telescope
local ok, builtin = pcall(require, "telescope.builtin")
if ok then
    vim.keymap.set('n', '<leader>f', builtin.find_files, { desc = 'find files' })
end

-- Terminal (horizontal en bas)
vim.api.nvim_set_keymap('n', '<leader>t', ':belowright split | terminal<CR>', { noremap = true, silent = true })

-- Quitter le terminal en mode normal avec <Esc>
vim.api.nvim_set_keymap('t', '<Esc>', [[<C-\><C-n>]], { noremap = true })

-- Toggle liste des caractères invisibles
vim.keymap.set("n", "<leader>l", function()
  vim.opt.list = not vim.opt.list:get()
end, { desc = "Toggle list mode" })

-- Navigation entre fenêtres avec Ctrl + flèches
vim.keymap.set('n', '<C-Left>',  '<C-w>h', { noremap = true, silent = true })
vim.keymap.set('n', '<C-Down>',  '<C-w>j', { noremap = true, silent = true })
vim.keymap.set('n', '<C-Up>',    '<C-w>k', { noremap = true, silent = true })
vim.keymap.set('n', '<C-Right>', '<C-w>l', { noremap = true, silent = true })

vim.keymap.set('n', '<A-Up>', ':resize +2<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<A-Down>', ':resize -2<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<A-Left>', ':vertical resize -2<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<A-Right>', ':vertical resize +2<CR>', { noremap = true, silent = true })

