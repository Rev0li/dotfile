-- ════════════════════════════════════════
-- 🧠 Point d’entrée principal : init.lua
-- ════════════════════════════════════════

-- 🧩 Modules principaux à charger
require("settings")    -- ⚙️  Options générales
require("plugins")     -- 📦 Gestionnaire de plugins (lazy.nvim)
require("keymaps")     -- ⌨️  Raccourcis clavier
require("lsp")         -- 🔧 Configuration des serveurs LSP
require("treesitter")  -- 🌳 Configuration de Treesitter
require("nvimtree")    -- 📁 Explorateur de fichiers
require("dashboard")   -- 🚀 Page d’accueil personnalisée

-- ════════════════════════════════════════
-- 🎨 Chargement du thème sauvegardé
-- ════════════════════════════════════════
local theme_file = vim.fn.stdpath("config") .. "/.theme"
local f = io.open(theme_file, "r")
if f then
  local theme = f:read("*l")
  f:close()
  if theme and theme ~= "" then
    pcall(vim.cmd, "colorscheme " .. theme)
  end
else
  vim.cmd("colorscheme habamax") -- 🎨 Thème par défaut si rien n’est trouvé
end

