require'nvim-tree'.setup {
  update_cwd = true,
  diagnostics = {
    enable = true,
    icons = {
      hint = "", info = "", warning = "", error = "",
    }
  },
  -- ════════════════════════════════════════
  -- 🖼️ Vue de l’arborescence (position, largeur)
  -- ════════════════════════════════════════
  view = {
    width = function()
      return math.floor(vim.o.columns * 0.15) -- largeur = 15% de l’écran
    end,
    side = 'left',
  },
  -- ════════════════════════════════════════
  -- 📂 Actions sur les fichiers
  -- ════════════════════════════════════════
  actions = {
    open_file = {
      quit_on_open = false, -- Ne ferme pas l’arbre quand on ouvre un fichier
    },
  },

  -- ════════════════════════════════════════
  -- 🎨 Icônes dans l’arbre
  -- ════════════════════════════════════════
  renderer = {
    icons = {
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true,
      },
      glyphs = {
        default = '',
        symlink = '',
        folder = {
          arrow_closed = "",
          arrow_open = "",
          default = "",
          open = "",
          empty = "",
          empty_open = "",
          symlink = "",
          symlink_open = "",
        },
        git = {
          unstaged = "✗",
          staged = "✓",
          unmerged = "",
          renamed = "➜",
          untracked = "★",
          deleted = "",
          ignored = "◌"
        }
      }
    }
  }
}
