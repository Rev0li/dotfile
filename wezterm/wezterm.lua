-- ═══════════════════════════════════════════════════════════
-- 🎨 WezTerm Configuration
-- ═══════════════════════════════════════════════════════════

local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- ═══════════════════════════════════════════════════════════
-- 🎨 Thème dynamique (dark / light)
-- Contrôlé par ~/.config/theme via theme-toggle.sh
-- ═══════════════════════════════════════════════════════════

local function read_theme()
  local theme_file = wezterm.home_dir .. '/.config/theme'
  local f = io.open(theme_file, 'r')
  if f then
    local mode = f:read('*l')
    f:close()
    return mode and mode:match('^%s*(.-)%s*$') or 'dark'
  end
  return 'dark'
end

local THEMES = {
  dark = {
    color_scheme = 'Tokyo Night',
    tab_bar_bg   = '#1a1b26',
    tab_active   = { bg = '#b297b9', fg = '#1a1b26' },
    tab_inactive = { bg = '#2a2b36', fg = '#6b7089' },
    tab_hover    = { bg = '#3a3b46', fg = '#b297b9' },
    cursor_bg    = '#e0b3e5',
    cursor_fg    = '#1a1b26',
    selection_bg = '#b297b9',
    selection_fg = '#ffffff',
    split        = '#b297b9',
  },
  light = {
    color_scheme = 'Tokyo Night Day',
    tab_bar_bg   = '#e1e2ea',
    tab_active   = { bg = '#7c6f9f', fg = '#ffffff' },
    tab_inactive = { bg = '#cbccd6', fg = '#6b7089' },
    tab_hover    = { bg = '#b8b9c6', fg = '#7c6f9f' },
    cursor_bg    = '#7c6f9f',
    cursor_fg    = '#ffffff',
    selection_bg = '#7c6f9f',
    selection_fg = '#ffffff',
    split        = '#7c6f9f',
  },
}

local mode = read_theme()
local theme = THEMES[mode] or THEMES['dark']

config.color_scheme = theme.color_scheme

config.colors = {
  cursor_bg    = theme.cursor_bg,
  cursor_border = theme.cursor_bg,
  cursor_fg    = theme.cursor_fg,
  selection_bg = theme.selection_bg,
  selection_fg = theme.selection_fg,
  split        = theme.split,
  tab_bar = {
    background = theme.tab_bar_bg,
    active_tab = {
      bg_color  = theme.tab_active.bg,
      fg_color  = theme.tab_active.fg,
      intensity = 'Bold',
    },
    inactive_tab = {
      bg_color = theme.tab_inactive.bg,
      fg_color = theme.tab_inactive.fg,
    },
    inactive_tab_hover = {
      bg_color = theme.tab_hover.bg,
      fg_color = theme.tab_hover.fg,
    },
  },
}

-- ═══════════════════════════════════════════════════════════
-- 🔤 Police
-- ═══════════════════════════════════════════════════════════

config.font = wezterm.font('JetBrains Mono', { weight = 'Medium' })
config.font_size = 12.0

-- ═══════════════════════════════════════════════════════════
-- 🪟 Fenêtre — FULLSCREEN + Layout
-- ═══════════════════════════════════════════════════════════

-- ✅ Démarrer en fullscreen
config.initial_window_state = 'Maximized'

-- ✅ Padding
config.window_padding = {
  left = 10, right = 10, top = 10, bottom = 10,
}

config.window_background_opacity = 1.0
config.enable_tab_bar            = true
config.hide_tab_bar_if_only_one_tab = false
config.use_fancy_tab_bar         = false
config.tab_bar_at_bottom         = false

config.inactive_pane_hsb = {
  saturation = 0.7,
  brightness = 0.6,
}

-- ═══════════════════════════════════════════════════════════
-- 🚀 Layout au démarrage — 3 panes automatiques
-- ═══════════════════════════════════════════════════════════

wezterm.on('gui-startup', function(cmd)
  local tab, pane, window = wezterm.mux.spawn_window(cmd or {})
  
  -- Split 1 : Horizontal → 60% TOP + 40% BAS
  local pane_bottom = pane:split { direction = 'Bottom', size = 0.4 }
  
  -- Split 2 : Vertical sur le BAS → 30% LEFT + 70% RIGHT
  local pane_bottom_right = pane_bottom:split { direction = 'Right', size = 0.3 }
  
  -- Maximiser la fenêtre
  window:gui_window():maximize()
end)

-- ═══════════════════════════════════════════════════════════
-- 📋 Palette de raccourcis (comme Space dans Helix)
-- ═══════════════════════════════════════════════════════════

wezterm.on('show-keybindings', function(window, pane)
  window:perform_action(
    wezterm.action.SplitPane {
      direction = 'Right',
      size = { Percent = 50 },
      command = {
        args = { '/usr/bin/zsh', '-c', [[cat << 'EOF'
 ╔══════════════════════════════════════════════════════╗
 ║              🎹  Raccourcis WezTerm                  ║
 ╠══════════════════════════════════════════════════════╣
 ║  SPLITS                                              ║
 ║    ALT+c          → Split horizontal (haut/bas)      ║
 ║    ALT+v          → Split vertical (gauche/droite)   ║
 ╠══════════════════════════════════════════════════════╣
 ║  NAVIGATION                                          ║
 ║    CTRL+←↑↓→      → Changer de pane                  ║
 ╠══════════════════════════════════════════════════════╣
 ║  REDIMENSIONNER                                      ║
 ║    SHIFT+ALT+←↑↓→ → Resize pane                      ║
 ╠══════════════════════════════════════════════════════╣
 ║  TABS                                                ║
 ║    SUPER+e        → Nouveau tab                      ║
 ║    SUPER+r        → Renommer le tab                  ║
 ║    SUPER+w        → Fermer pane                      ║
 ╠══════════════════════════════════════════════════════╣
 ║  THÈME                                               ║
 ║    alias dark     → Passer en dark                   ║
 ║    alias light    → Passer en light                  ║
 ║    alias theme    → Toggle automatique               ║
 ╠══════════════════════════════════════════════════════╣
 ║  Appuie sur q ou ENTRÉE pour fermer                  ║
 ╚══════════════════════════════════════════════════════╝
EOF
read -k1 key; exit]] },
      },
    },
    pane
  )
end)

-- ═══════════════════════════════════════════════════════════
-- ⌨️  Raccourcis clavier
-- ═══════════════════════════════════════════════════════════

config.keys = {
  -- ── Splits ──────────────────────────────────────────────
  { key = 'c', mods = 'ALT', action = wezterm.action.SplitVertical  { domain = 'CurrentPaneDomain' } },
  { key = 'v', mods = 'ALT', action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' } },

  -- ── Navigation panes ────────────────────────────────────
  { key = 'LeftArrow',  mods = 'CTRL', action = wezterm.action.ActivatePaneDirection 'Left'  },
  { key = 'RightArrow', mods = 'CTRL', action = wezterm.action.ActivatePaneDirection 'Right' },
  { key = 'UpArrow',    mods = 'CTRL', action = wezterm.action.ActivatePaneDirection 'Up'    },
  { key = 'DownArrow',  mods = 'CTRL', action = wezterm.action.ActivatePaneDirection 'Down'  },

  -- ── Resize panes ────────────────────────────────────────
  { key = 'LeftArrow',  mods = 'SHIFT|ALT', action = wezterm.action.AdjustPaneSize { 'Left',  5 } },
  { key = 'RightArrow', mods = 'SHIFT|ALT', action = wezterm.action.AdjustPaneSize { 'Right', 5 } },
  { key = 'UpArrow',    mods = 'SHIFT|ALT', action = wezterm.action.AdjustPaneSize { 'Up',    5 } },
  { key = 'DownArrow',  mods = 'SHIFT|ALT', action = wezterm.action.AdjustPaneSize { 'Down',  5 } },

  -- ── Tabs ────────────────────────────────────────────────
  { key = 'w', mods = 'SUPER', action = wezterm.action.CloseCurrentPane { confirm = true } },
  { key = 'e', mods = 'SUPER', action = wezterm.action.SpawnTab 'CurrentPaneDomain' },
  {
    key = 'r', mods = 'SUPER',
    action = wezterm.action.PromptInputLine {
      description = '✏️  Renommer le tab',
      action = wezterm.action_callback(function(window, pane, line)
        if line then window:active_tab():set_title(line) end
      end),
    },
  },

  -- ── Aide raccourcis ─────────────────────────────────────
  { key = '/', mods = 'SUPER', action = wezterm.action.EmitEvent 'show-keybindings' },
}

-- ═══════════════════════════════════════════════════════════
-- 🚀 Performance
-- ═══════════════════════════════════════════════════════════

config.max_fps       = 120
config.animation_fps = 60
config.cursor_blink_rate = 500

-- ═══════════════════════════════════════════════════════════
-- 🔔 Comportement
-- ═══════════════════════════════════════════════════════════

config.audible_bell    = 'Disabled'
config.scrollback_lines = 10000
config.default_prog    = { '/usr/bin/zsh' }

return config
