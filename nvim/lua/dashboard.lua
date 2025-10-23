-- ════════════════════════════════════════
-- 📦 Chargement de Alpha et initialisation du dashboard
-- ════════════════════════════════════════
local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")
local header_random = require("header_random")

-- ════════════════════════════════════════
-- 🖼️ En-tête ASCII dynamique du dashboard
-- ════════════════════════════════════════
dashboard.section.header.val = header_random.generate()

-- ════════════════════════════════════════
-- 🧩 Boutons du dashboard
-- ════════════════════════════════════════
dashboard.section.buttons.val = {
  dashboard.button("e", "📄  Nouveau fichier", ":ene <BAR> startinsert <CR>"),
  dashboard.button("d", "📁  Ouvrir l'arborescence", ":NvimTreeToggle<CR>"),
  dashboard.button("r", "🕘  Fichiers récents", ":Telescope oldfiles<CR>"),
  dashboard.button("t", "🎨  Changer de thème", "<cmd>lua require'dashboard.theme'.show()<CR>"),
  dashboard.button("q", "❌  Quitter", ":qa<CR>"),
}

-- ════════════════════════════════════════
-- 🔻 Footer
-- ════════════════════════════════════════
dashboard.section.footer.val = {
  "          (｡♥‿♥｡)",
  "♥  Welcome back, Commander.",
}
dashboard.section.footer.opts.hl = "Constant"

-- ════════════════════════════════════════
-- 🚀 Démarrage du dashboard
-- ════════════════════════════════════════
alpha.setup(dashboard.config)
