-- init.lua: Point d’entrée principal pour la configuration
require("settings")   -- Options générales de Neovim
require("plugins")    -- Gestionnaire de plugins
require("keymaps")    -- Raccourcis personnalisés
require("lsp")        -- Configuration des Language Servers
require("treesitter") -- Configuration de Treesitter
require("nvimtree")   -- Configuration de Nvim Tree
vim.cmd("colorscheme habamax")
