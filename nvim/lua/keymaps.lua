-- ════════════════════════════════════════
-- ⌨️ keymaps.lua — Raccourcis clavier Neovim
-- ════════════════════════════════════════

vim.g.mapleader = " " -- Leader key

-- ════════════════════════════════════════
-- 🌲 NvimTree (explorateur de fichiers)
-- ════════════════════════════════════════
vim.api.nvim_set_keymap('n', '<leader>d', ':NvimTreeToggle<CR>', { noremap = true, silent = true })

-- ════════════════════════════════════════
-- 🗂️  Onglets (tabs)
-- ════════════════════════════════════════
vim.api.nvim_set_keymap('n', '<leader>nn', ':tabnew<CR>',   { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>nc', ':tabclose<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<S-H>', ':tabprev<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<S-L>', ':tabnext<CR>', { noremap = true, silent = true })


-- ════════════════════════════════════════
-- 🔍 Telescope (recherche de fichiers)
-- ════════════════════════════════════════
local ok, builtin = pcall(require, "telescope.builtin")
if ok then
    vim.keymap.set('n', '<leader>f', builtin.find_files, { desc = 'find files' })
end

-- ════════════════════════════════════════
-- 🔁 Terminal toggle (<leader>t)
-- ════════════════════════════════════════
local terminal_bufnr = nil

-- Échap dans terminal → retourne en mode normal
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { noremap = true })

-- Toggle terminal avec <leader>t
vim.keymap.set("n", "<leader>t", function()
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    if vim.api.nvim_win_get_buf(win) == terminal_bufnr then
      vim.api.nvim_win_close(win, true)
      terminal_bufnr = nil
      return
    end
  end

  if not terminal_bufnr or not vim.api.nvim_buf_is_valid(terminal_bufnr) then
    vim.cmd("belowright split | terminal")
    terminal_bufnr = vim.api.nvim_get_current_buf()
  else
    vim.cmd("belowright split")
    vim.api.nvim_win_set_buf(0, terminal_bufnr)
  end
end, { noremap = true, silent = true, desc = "Terminal Toggle" })

-- ════════════════════════════════════════
-- 🕵️‍♂️ Toggle caractères invisibles
-- ════════════════════════════════════════
vim.keymap.set("n", "<leader>l", function()
  vim.opt.list = not vim.opt.list:get()
end, { desc = "Toggle list mode" })

-- ════════════════════════════════════════
-- 🪟 Navigation entre splits (Ctrl + flèches)
-- ════════════════════════════════════════
vim.keymap.set('n', '<C-Left>',  '<C-w>h', { noremap = true, silent = true })
vim.keymap.set('n', '<C-Down>',  '<C-w>j', { noremap = true, silent = true })
vim.keymap.set('n', '<C-Up>',    '<C-w>k', { noremap = true, silent = true })
vim.keymap.set('n', '<C-Right>', '<C-w>l', { noremap = true, silent = true })

-- ════════════════════════════════════════
-- 📏 Redimensionnement des fenêtres (Alt + flèches)
-- ════════════════════════════════════════
vim.keymap.set('n', '<A-Up>',    ':resize +2<CR>',           { noremap = true, silent = true })
vim.keymap.set('n', '<A-Down>',  ':resize -2<CR>',           { noremap = true, silent = true })
vim.keymap.set('n', '<A-Left>',  ':vertical resize -2<CR>',  { noremap = true, silent = true })

-- ════════════════════════════════════════
-- Naviguation entre les tabs
-- ════════════════════════════════════════im.keymap.set('n', '<A-Right>', ':vertical resize +2<CR>',  { noremap = true, silent = true })
vim.keymap.set('n', '<C-PageDown>', ':tabnext<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<C-PageUp>', ':tabprevious<CR>', { noremap = true, silent = true })

-- ════════════════════════════════════════
-- 🔀 Git Conflict - Résolution des conflits Git
-- À ajouter dans votre fichier nvim/lua/keymaps.lua
-- ════════════════════════════════════════

-- ════════════════════════════════════════
-- 🎯 Choix de version lors des conflits
-- ════════════════════════════════════════
vim.keymap.set('n', '<leader>gco', '<cmd>GitConflictChooseOurs<CR>', 
    { noremap = true, silent = true, desc = 'Git Conflict: Choose Ours (current/HEAD)' })

vim.keymap.set('n', '<leader>gct', '<cmd>GitConflictChooseTheirs<CR>', 
    { noremap = true, silent = true, desc = 'Git Conflict: Choose Theirs (incoming/branch)' })

vim.keymap.set('n', '<leader>gcb', '<cmd>GitConflictChooseBoth<CR>', 
    { noremap = true, silent = true, desc = 'Git Conflict: Choose Both versions' })

vim.keymap.set('n', '<leader>gcn', '<cmd>GitConflictChooseNone<CR>', 
    { noremap = true, silent = true, desc = 'Git Conflict: Choose None (delete both)' })

-- ════════════════════════════════════════
-- 🧭 Navigation entre les conflits
-- ════════════════════════════════════════
vim.keymap.set('n', '<leader>gcj', '<cmd>GitConflictNextConflict<CR>', 
    { noremap = true, silent = true, desc = 'Git Conflict: Next conflict' })

vim.keymap.set('n', '<leader>gck', '<cmd>GitConflictPrevConflict<CR>', 
    { noremap = true, silent = true, desc = 'Git Conflict: Previous conflict' })

-- ════════════════════════════════════════
-- 📋 Liste des conflits
-- ════════════════════════════════════════
vim.keymap.set('n', '<leader>gcl', '<cmd>GitConflictListQf<CR>', 
    { noremap = true, silent = true, desc = 'Git Conflict: List all conflicts in quickfix' })

-- ════════════════════════════════════════
-- 🔄 Raccourcis alternatifs (plus courts)
-- ════════════════════════════════════════
-- Si vous préférez des raccourcis plus courts, décommentez ces lignes :

-- vim.keymap.set('n', '<leader>go', '<cmd>GitConflictChooseOurs<CR>', { desc = 'Conflict: Ours' })
-- vim.keymap.set('n', '<leader>gt', '<cmd>GitConflictChooseTheirs<CR>', { desc = 'Conflict: Theirs' })
-- vim.keymap.set('n', '<leader>gb', '<cmd>GitConflictChooseBoth<CR>', { desc = 'Conflict: Both' })
-- vim.keymap.set('n', '<leader>gn', '<cmd>GitConflictChooseNone<CR>', { desc = 'Conflict: None' })
-- vim.keymap.set('n', ']c', '<cmd>GitConflictNextConflict<CR>', { desc = 'Next conflict' })
-- vim.keymap.set('n', '[c', '<cmd>GitConflictPrevConflict<CR>', { desc = 'Prev conflict' })
