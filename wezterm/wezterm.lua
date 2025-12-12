-- ═══════════════════════════════════════════════════════════
-- 🎨 WezTerm Configuration
-- ═══════════════════════════════════════════════════════════

local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- ═══════════════════════════════════════════════════════════
-- 🎨 Apparence
-- ═══════════════════════════════════════════════════════════

-- Thème
config.color_scheme = 'Tokyo Night'

-- Police
config.font = wezterm.font('JetBrains Mono', { weight = 'Medium' })
config.font_size = 12.0

-- Fenêtre
config.window_padding = {
  left = 10,
  right = 10,
  top = 10,
  bottom = 10,
}

config.window_background_opacity = 1.0
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = false
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = false

-- Couleurs personnalisées néon
config.colors = {
  cursor_bg = '#e0b3e5',
  cursor_border = '#e0b3e5',
  cursor_fg = '#1a1b26',
  
  selection_bg = '#b297b9',
  selection_fg = '#ffffff',
  
  tab_bar = {
    background = '#1a1b26',
    active_tab = {
      bg_color = '#b297b9',
      fg_color = '#1a1b26',
      intensity = 'Bold',
    },
    inactive_tab = {
      bg_color = '#2a2b36',
      fg_color = '#6b7089',
    },
    inactive_tab_hover = {
      bg_color = '#3a3b46',
      fg_color = '#b297b9',
    },
  },
  
  split = '#b297b9',
}

config.inactive_pane_hsb = {
  saturation = 0.7,
  brightness = 0.6,
}

-- ═══════════════════════════════════════════════════════════
-- ⌨️  Raccourcis clavier (UNE SEULE TABLE)
-- ═══════════════════════════════════════════════════════════

config.keys = {
  -- ═══════════════════════════════════════════════════════════
  -- 🔀 SPLITS avec SUPER (touche Windows)
  -- ═══════════════════════════════════════════════════════════
  
  -- Split HORIZONTAL (haut/bas)
  {
    key = 'c',
    mods = 'ALT',
    action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  
  -- Split VERTICAL (gauche/droite)
  {
    key = 'v',
    mods = 'ALT',
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  
  -- ═══════════════════════════════════════════════════════════
  -- 🧭 NAVIGATION entre panes
  -- ═══════════════════════════════════════════════════════════
  
 
  -- Flèches (garde aussi CTRL|SHIFT pour compatibilité)
  {
    key = 'LeftArrow',
    mods = 'CTRL',
    action = wezterm.action.ActivatePaneDirection 'Left',
  },
  {
    key = 'RightArrow',
    mods = 'CTRL',
    action = wezterm.action.ActivatePaneDirection 'Right',
  },
  {
    key = 'UpArrow',
    mods = 'CTRL',
    action = wezterm.action.ActivatePaneDirection 'Up',
  },
  {
    key = 'DownArrow',
    mods = 'CTRL',
    action = wezterm.action.ActivatePaneDirection 'Down',
  },
  
  -- ═══════════════════════════════════════════════════════════
  -- 📏 REDIMENSIONNER les panes
  -- ═══════════════════════════════════════════════════════════
  
  -- Avec flèches aussi
  {
    key = 'LeftArrow',
    mods = 'SHIFT|ALT',
    action = wezterm.action.AdjustPaneSize { 'Left', 5 },
  },
  {
    key = 'RightArrow',
    mods = 'SHIFT|ALT',
    action = wezterm.action.AdjustPaneSize { 'Right', 5 },
  },
  {
    key = 'UpArrow',
    mods = 'SHIFT|ALT',
    action = wezterm.action.AdjustPaneSize { 'Up', 5 },
  },
  {
    key = 'DownArrow',
    mods = 'SHIFT|ALT',
    action = wezterm.action.AdjustPaneSize { 'Down', 5 },
  },
  
  -- ═══════════════════════════════════════════════════════════
  -- 🗑️  FERMER
  -- ═══════════════════════════════════════════════════════════
  
  -- Fermer pane
  {
    key = 'w',
    mods = 'SUPER',
    action = wezterm.action.CloseCurrentPane { confirm = true },
  },
  -- ═══════════════════════════════════════════════════════════
  -- 📑 TABS
  -- ═══════════════════════════════════════════════════════════
  
  -- Nouveau tab
  {
    key = 'e',
    mods = 'SUPER',
    action = wezterm.action.SpawnTab 'CurrentPaneDomain',
  },
  
}

-- ═══════════════════════════════════════════════════════════
-- 🚀 Performance
-- ═══════════════════════════════════════════════════════════

config.max_fps = 120
config.animation_fps = 60
config.cursor_blink_rate = 500

-- ═══════════════════════════════════════════════════════════
-- 🔔 Comportement
-- ═══════════════════════════════════════════════════════════

config.audible_bell = "Disabled"
--[[ config.visual_bell = {
  fade_in_function = 'EaseIn',
  fade_in_duration_ms = 150,
  fade_out_function = 'EaseOut',
  fade_out_duration_ms = 150,
} --]]

-- Scrollback
config.scrollback_lines = 10000

-- Shell par défaut
config.default_prog = { '/usr/bin/zsh' }

return config
