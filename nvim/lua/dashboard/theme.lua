-- ════════════════════════════════════════
-- 🎨 dashboard/theme.lua — Sélecteur de thème
-- ════════════════════════════════════════
local M = {}

-- 📦 Appliquer un thème et le sauvegarder dans .theme
function M.set(name)
  vim.cmd("colorscheme " .. name)
  local file = vim.fn.stdpath("config") .. "/.theme"
  local f = io.open(file, "w")
  if f then
    f:write(name)
    f:close()
  end
end

-- 📋 Liste des thèmes disponibles
local themes = {
  { name = "tokyonight", label = "🌃  Tokyo Night" },
  { name = "catppuccin", label = "🍨  Catppuccin" },
  { name = "nightfox",   label = "🦊  Nightfox" },
  { name = "rose-pine",  label = "🌹  Rose Pine" },
  { name = "gruvbox",    label = "🎨  Gruvbox" },
}

-- 🔥 Menu interactif flottant pour choisir un thème
function M.show()
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
        M.set(theme.name)
        vim.notify("🎨 Thème appliqué : " .. theme.label, vim.log.levels.INFO)
        break
      end
    end
  end)
end

return M
