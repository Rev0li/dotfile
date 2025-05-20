vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.wrap = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = false
vim.opt.winbar = "%=%m %f"

-- Affichage des caractères invisibles
vim.opt.list = true
vim.opt.listchars = {
  tab = "→ ",
  trail = "·",
  space = "·",
  extends = "»",
  precedes = "«",
  eol = "↴",
}
-- Sauvegarde automatique à la sortie du mode insert
vim.api.nvim_create_autocmd("InsertLeave", {
  pattern = "*",
  callback = function()
    if vim.bo.modified then
      vim.cmd("silent! write") -- Évite d'afficher un message
    end
  end,
})

-- Ajouter commande pour changer de repertoire courant, utile pour nvim treesitter
vim.api.nvim_create_user_command("Here", function()
  vim.cmd("cd %:p:h")
  print("Répertoire changé vers : " .. vim.fn.getcwd())
end, {})

-- Définir un groupe de couleurs pour simuler une bordure active
vim.cmd [[
  highlight ActiveWindow   guibg=#1e1e2e
  highlight InactiveWindow guibg=#11111b
]]

-- Appliquer ces styles aux fenêtres
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

