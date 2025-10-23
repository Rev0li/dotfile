-- ════════════════════════════════════════
-- ⚙️  Options générales d'affichage
-- ════════════════════════════════════════
vim.opt.number = true                  -- Affiche les numéros de lignes
vim.opt.relativenumber = true          -- Numéros relatifs
vim.opt.cursorline = true              -- Surligne la ligne courante
vim.opt.wrap = false                   -- Pas de retour à la ligne
vim.opt.ignorecase = true              -- Ignore la casse dans les recherches
vim.opt.smartcase = true               -- Respecte la casse si un caractère maj est présent

-- ════════════════════════════════════════
-- ⏱️  Timeouts (pour éviter confusion marks/text objects)
-- ════════════════════════════════════════
vim.opt.timeoutlen = 1000              -- Temps d'attente pour les séquences (1 seconde)
vim.opt.ttimeoutlen = 10               -- Temps d'attente pour les codes clavier (ms)

-- ════════════════════════════════════════
-- ⬛️  Indentation & tabulations
-- ════════════════════════════════════════
vim.opt.tabstop = 4                    -- Largeur d’un tab = 4 espaces visuellement
vim.opt.shiftwidth = 4                -- Indentation à 4 espaces
vim.opt.expandtab = false             -- Utilise de vraies tabulations (≠ espaces)

-- ════════════════════════════════════════
-- 🪟 Winbar (barre discrète en haut de chaque split)
-- ════════════════════════════════════════
vim.opt.winbar = "%=%m %f"

-- ════════════════════════════════════════
-- 🔍 Affichage des caractères invisibles
-- ════════════════════════════════════════
vim.opt.list = true
vim.opt.listchars = {
  tab = "→ ",
  trail = "·",
  space = "·",
  extends = "»",
  precedes = "«",
  eol = "↴",
}

-- ════════════════════════════════════════
-- 💾 Sauvegarde automatique en quittant le mode insert
-- ════════════════════════════════════════
vim.api.nvim_create_autocmd("InsertLeave", {
  pattern = "*",
  callback = function()
    if vim.bo.modified then
      vim.cmd("silent! write")
    end
  end,
})

-- ════════════════════════════════════════
-- 📁 Commande perso : :Here pour changer vers le répertoire du fichier actif
-- ════════════════════════════════════════
vim.api.nvim_create_user_command("Here", function()
  vim.cmd("cd %:p:h")
  print("📁 Répertoire changé vers : " .. vim.fn.getcwd())
end, {})

-- ════════════════════════════════════════
-- 🪄 Mise en valeur de la fenêtre active (fond discret)
-- ════════════════════════════════════════
vim.cmd [[
  highlight ActiveWindow   guibg=#1e1e2e
  highlight InactiveWindow guibg=#11111b
]]

vim.api.nvim_create_autocmd("WinEnter", {
  callback = function()
    vim.wo.winhighlight = "Normal:ActiveWindow"
  end,
})

vim.api.nvim_create_autocmd("WinLeave", {
  callback = function()
    vim.wo.winhighlight = "Normal:InactiveWindow"
  end,
})

-- Forcer une forme de curseur différente selon les modes
vim.opt.guicursor = {
  "n-v-c:block",       -- Normal, Visual, Command: block
  "i-ci-ve:ver25",     -- Insert, Insert Command-line: vertical bar
  "r-cr:hor20",        -- Replace modes: horizontal bar
  "o:hor50",           -- Operator-pending mode
  "a:blinkon100",      -- blinking in all modes
}

