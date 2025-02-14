-- settings.lua: Options globales
vim.opt.number = true         -- Numérotation des lignes
vim.opt.shiftwidth = 4        -- Taille de l'indentation
vim.opt.tabstop = 4           -- Taille des tabulations
vim.opt.relativenumber = true -- Numéros relatifs
vim.opt.cursorline = true     -- Surligne la ligne actuelle
vim.opt.wrap = false          -- Désactive le retour à la ligne automatique
vim.opt.ignorecase = true     -- Recherche insensible à la casse
vim.opt.smartcase = true      -- Recherche intelligente

-- Auto-indent quand on quitte le mode insert
vim.api.nvim_create_autocmd("InsertLeave", {
	pattern = "*",
	callback = function()
		if next(vim.lsp.get_clients()) ~= nil then
			vim.lsp.buf.format({ async = true }) -- Formate avec LSP s'il est actif
		else
			vim.cmd("normal! gg=G")     -- Indente le fichier si LSP n'est pas actif
		end
	end,
})

-- Auto-save quand on quitte le mode insert
vim.api.nvim_create_autocmd("InsertLeave", {
	pattern = "*",
	callback = function()
		if vim.bo.modified then
			vim.cmd("silent! write") -- Sauvegarde seulement si le fichier est modifié
		end
	end,
})

-- Open NvimTree auto after `:tabnew`
vim.api.nvim_create_autocmd("TabNewEntered", {
	pattern = "*",
	command = "NvimTreeOpen"
})


-- Vous pouvez ajouter d'autres options ici !
