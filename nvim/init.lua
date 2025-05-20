-- init.lua: Point d’entrée principal pour la configuration
require("settings")
require("plugins")
require("keymaps")
require("lsp")
require("treesitter")
require("nvimtree")
require("dashboard")
vim.cmd("colorscheme catppuccin")
