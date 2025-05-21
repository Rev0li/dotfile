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
vim.keymap.set('n', '<A-Right>', ':vertical resize +2<CR>',  { noremap = true, silent = true })

