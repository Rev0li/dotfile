-- treesitter.lua
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "lua", "python", "javascript", "c", "cpp" }, -- Langages à installer
  sync_install = false, -- Installer les parsers de manière asynchrone
  auto_install = true, -- Installer automatiquement les parsers manquants
  ignore_install = {}, -- Liste des parsers à ignorer
  highlight = {
    enable = true, -- Activer la coloration syntaxique
    additional_vim_regex_highlighting = false, -- Désactiver les anciennes regex
  },
  indent = { enable = true }, -- Activer l'indentation intelligente
  modules = {}, -- Ajouter une section modules vide pour éviter les erreurs
}

