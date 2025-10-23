-- ════════════════════════════════════════
-- 🌳 Configuration de nvim-treesitter
-- ════════════════════════════════════════
require('nvim-treesitter.configs').setup {

  -- ════════════════════════════════════════
  -- 📦 Langages à installer automatiquement
  -- ════════════════════════════════════════
  ensure_installed = {
    "lua",
    "python",
    "javascript",
    "typescript",
    "tsx",
    "c",
    "cpp",
    "json",
    "yaml",
    "markdown",
    "markdown_inline",
    "bash",
  },

  -- ════════════════════════════════════════
  -- 🔄 Options d'installation
  -- ════════════════════════════════════════
  sync_install = false,      -- Pas d'installation synchrone (⚠️ peut être lent sinon)
  auto_install = true,       -- Installer automatiquement les parsers manquants
  ignore_install = {},       -- Langages à ignorer à l'installation

  -- ════════════════════════════════════════
  -- ✨ Surlignage syntaxique
  -- ════════════════════════════════════════
  highlight = {
    enable = true,                             -- Active le surlignage syntaxique Treesitter
    additional_vim_regex_highlighting = false, -- Pas besoin de l'ancien moteur en plus
  },

  -- ════════════════════════════════════════
  -- 📏 Indentation intelligente
  -- ════════════════════════════════════════
  indent = {
    enable = true                              -- Active l’indentation contextuelle Treesitter
  },
}

