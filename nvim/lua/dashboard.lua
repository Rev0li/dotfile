-- ════════════════════════════════════════
-- 📦 Chargement de Alpha et initialisation du dashboard
-- ════════════════════════════════════════
local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

-- ════════════════════════════════════════
-- 🖼️ En-tête ASCII du dashboard
-- ════════════════════════════════════════
dashboard.section.header.val = {
  [[⠀⠀⠀⠀⠀⠀⠀⠀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⠀⠀⠀⠀⠀⠀⠀]],
  [[⠀⠀⠀⠀⠀⢀⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⡀⠀⠀⠀⠀⠀]],
  [[⠀⠀⠀⠀⢰⣿⣿⣿⣿⣿⣿⠀NEOVIM DASHBOARD⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀]],
  [[⠀⠀⠀⠀⣿⣿⣿⣿⣿⣿⡟⠀🧠  Bienvenue, boss⠀⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀]],
  [[⠀⠀⠀⠀⢿⣿⣿⣿⣿⠏⠀⠀📁  Projets à dominer⠀⠙⣿⣿⣿⣿⣿⣿⡿⠀⠀⠀⠀]],
  [[⠀⠀⠀⠀⠀⠙⠻⢿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⡿⠟⠋⠀⠀⠀⠀⠀⠀⠀⠀]],
}

-- ════════════════════════════════════════
-- 🧩 Boutons du dashboard
-- ════════════════════════════════════════
dashboard.section.buttons.val = {
  dashboard.button("f", "🔍  Trouver un fichier", ":Telescope find_files<CR>"),
  dashboard.button("e", "📄  Nouveau fichier", ":ene <BAR> startinsert <CR>"),
  dashboard.button("d", "📁  Ouvrir l'arborescence", ":NvimTreeToggle<CR>"),
  dashboard.button("r", "🕘  Fichiers récents", ":Telescope oldfiles<CR>"),
  dashboard.button("t", "🎨  Changer de thème", "<cmd>lua require'dashboard'.show_theme_selector()<CR>"),
  dashboard.button("q", "❌  Quitter", ":qa<CR>"),
}

-- ════════════════════════════════════════
-- 🔻 Footer du dashboard
-- ════════════════════════════════════════
dashboard.section.footer.val = "💻 42 | Config by Rev0li ❤️"
dashboard.section.footer.opts.hl = "Constant"

-- ════════════════════════════════════════
-- 🚀 Activation du dashboard avec config
-- ════════════════════════════════════════
alpha.setup(dashboard.config)

-- ════════════════════════════════════════
-- 🎨 Gestion des thèmes dynamiques
-- ════════════════════════════════════════

-- Fonction pour appliquer et sauvegarder un thème
local function set_theme(name)
  vim.cmd("colorscheme " .. name)

  -- Sauvegarde le thème dans un fichier pour rechargement futur
  local theme_file = vim.fn.stdpath("config") .. "/.theme"
  local f = io.open(theme_file, "w")
  if f then
    f:write(name)
    f:close()
  end
end

-- Liste des thèmes disponibles
local themes = {
  { name = "tokyonight", label = "🌃  Tokyo Night" },
  { name = "catppuccin", label = "🍨  Catppuccin" },
  { name = "nightfox",   label = "🦊  Nightfox" },
  { name = "rose-pine",  label = "🌹  Rose Pine" },
  { name = "gruvbox",    label = "🎨  Gruvbox" },
}

-- 🔥 Menu interactif pour sélectionner un thème avec `vim.ui.select`
local function show_theme_selector()
  local labels = {}
  for _, theme in ipairs(themes) do
    table.insert(labels, theme.label)
  end

  vim.ui.select(labels, {
    prompt = "🎨 Choisis ton thème :",
    format_item = function(item)
      return "  " .. item .. "  "
    end,
    kind = "Theme",
  }, function(choice)
    if not choice then return end
    for _, theme in ipairs(themes) do
      if theme.label == choice then
        set_theme(theme.name)
        vim.notify("🎨 Thème appliqué : " .. theme.label, vim.log.levels.INFO)
        break
      end
    end
  end)
end

-- ════════════════════════════════════════
-- 📦 Export des fonctions du dashboard
-- ════════════════════════════════════════
local M = {}
M.set_theme = set_theme
M.show_theme_selector = show_theme_selector
return M

