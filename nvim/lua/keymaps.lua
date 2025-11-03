-- ════════════════════════════════════════
-- ⌨️ keymaps.lua — Raccourcis clavier Neovim
-- ════════════════════════════════════════

vim.g.mapleader = " " -- Leader key
-- Remap 'jk' to Escape in Insert mode
vim.api.nvim_set_keymap('i', 'jk', '<Esc>', { noremap = true, silent = true })

-- ════════════════════════════════════════
-- ✂️ Faciliter les text objects avec ' et "
-- ════════════════════════════════════════
-- Remapper ' et " pour éviter la confusion avec les marks
-- \ (backslash) pour aller aux marks (remplace ')
-- | (pipe) pour les registers (remplace ")
vim.keymap.set('n', '\\', [[<Cmd>normal! '<CR>]], { noremap = true, desc = "Aller au mark (remplacé par \\)" })
vim.keymap.set('n', '|', [[<Cmd>normal! "<CR>]], { noremap = true, desc = "Utiliser register (remplacé par |)" })

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
-- 🔍 Telescope (recherche de fichiers et texte)
-- ════════════════════════════════════════
-- Charger les keymaps après que Telescope soit prêt
vim.api.nvim_create_autocmd("User", {
    pattern = "VeryLazy",
    callback = function()
        local ok, builtin = pcall(require, "telescope.builtin")
        if ok then
            vim.keymap.set('n', '<leader>f', builtin.find_files, { desc = 'Trouver fichiers' })
            vim.keymap.set('n', '<leader>g', builtin.live_grep, { desc = 'Rechercher texte dans fichiers' })
            vim.keymap.set('n', '<leader>b', builtin.buffers, { desc = 'Lister buffers ouverts' })
        else
            vim.notify("⚠️  Telescope n'est pas chargé", vim.log.levels.WARN)
        end
    end,
})

-- ════════════════════════════════════════
-- 🔁 Terminal flottant (<leader>t)
-- ════════════════════════════════════════
local terminal_bufnr = nil
local terminal_win = nil

-- Échap dans terminal → retourne en mode normal
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { noremap = true })

-- Toggle terminal flottant avec <leader>t
vim.keymap.set("n", "<leader>t", function()
  -- Si le terminal est déjà ouvert, le fermer
  if terminal_win and vim.api.nvim_win_is_valid(terminal_win) then
    vim.api.nvim_win_close(terminal_win, true)
    terminal_win = nil
    return
  end

  -- Créer le buffer terminal si nécessaire
  if not terminal_bufnr or not vim.api.nvim_buf_is_valid(terminal_bufnr) then
    terminal_bufnr = vim.api.nvim_create_buf(false, true)
  end

  -- Calculer la taille de la fenêtre (80% de l'écran)
  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.8)
  
  -- Calculer la position centrée
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)
  
  -- Options de la fenêtre flottante
  local opts = {
    relative = 'editor',
    width = width,
    height = height,
    row = row,
    col = col,
    style = 'minimal',
    border = 'rounded',
    title = ' 💻 Terminal ',
    title_pos = 'center',
  }
  
  -- Créer la fenêtre flottante
  terminal_win = vim.api.nvim_open_win(terminal_bufnr, true, opts)
  
  -- Ouvrir le terminal dans le buffer (seulement si nouveau buffer)
  if vim.api.nvim_buf_line_count(terminal_bufnr) == 1 and vim.api.nvim_buf_get_lines(terminal_bufnr, 0, 1, false)[1] == '' then
    vim.fn.termopen(vim.o.shell)
  end
  
  -- Passer en mode insert automatiquement
  vim.cmd('startinsert')
end, { noremap = true, silent = true, desc = "Terminal flottant" })

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
