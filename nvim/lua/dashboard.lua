local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

dashboard.section.header.val = {
  [[⠀⠀⠀⠀⠀⠀⠀⠀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⣀⠀⠀⠀⠀⠀⠀⠀]],
  [[⠀⠀⠀⠀⠀⢀⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣦⡀⠀⠀⠀⠀⠀]],
  [[⠀⠀⠀⠀⢰⣿⣿⣿⣿⣿⣿⠀NEOVIM DASHBOARD⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡇⠀⠀⠀⠀]],
  [[⠀⠀⠀⠀⣿⣿⣿⣿⣿⣿⡟⠀🧠  Bienvenue, boss⠀⢻⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀]],
  [[⠀⠀⠀⠀⢿⣿⣿⣿⣿⠏⠀⠀📁  Projets à dominer⠀⠙⣿⣿⣿⣿⣿⣿⡿⠀⠀⠀⠀]],
  [[⠀⠀⠀⠀⠀⠙⠻⢿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣿⡿⠟⠋⠀⠀⠀⠀⠀⠀⠀⠀]],
}

dashboard.section.buttons.val = {
  dashboard.button("f", "🔍  Trouver un fichier", ":Telescope find_files<CR>"),
  dashboard.button("e", "📄  Nouveau fichier", ":ene <BAR> startinsert <CR>"),
  dashboard.button("d", "📁  Ouvrir l'arborescence", ":NvimTreeToggle<CR>"),
  dashboard.button("r", "🕘  Fichiers récents", ":Telescope oldfiles<CR>"),
  dashboard.button("q", "❌  Quitter", ":qa<CR>"),
}

dashboard.section.footer.val = "💻 42 | Config by Rev0li ❤️"
dashboard.section.footer.opts.hl = "Constant"

alpha.setup(dashboard.config)
-- Ajout dans dashboard.lua : Sélecteur de thème
local function set_theme(name)
  vim.cmd("colorscheme " .. name)
end

local themes = {
  { "tokyonight", "🌃  Tokyo Night" },
  { "catppuccin", "🍨  Catppuccin" },
  { "nightfox",   "🦊  Nightfox" },
  { "rose-pine",  "🌹  Rose Pine" },
  { "gruvbox",    "🎨  Gruvbox" },
}

for i, theme in ipairs(themes) do
  table.insert(dashboard.section.buttons.val, i + 5, 
    dashboard.button(tostring(i), theme[2], "<cmd>lua require'dashboard'.set_theme('" .. theme[1] .. "')<CR>"))
end

-- Expose set_theme via require('dashboard').set_theme
local M = {}
M.set_theme = set_theme
return M
