-- WezTerm Configuration
-- https://wezfurlong.org/wezterm/

local wezterm = require 'wezterm'
local config = wezterm.config_builder()

-- ═══════════════════════════════════════════════════════════
-- 🎨 Apparence
-- ═══════════════════════════════════════════════════════════

-- Thème Rose Pine Moon (pour correspondre avec Helix)
config.color_scheme = 'rose-pine-moon'

-- Police (JetBrains Mono Nerd Font)
config.font = wezterm.font('JetBrainsMono Nerd Font', { weight = 'Regular' })
config.font_size = 11.0

-- Transparence et blur
config.window_background_opacity = 0.95
config.macos_window_background_blur = 20

-- Padding
config.window_padding = {
  left = 8,
  right = 8,
  top = 8,
  bottom = 8,
}

-- Désactiver la barre de titre native
config.window_decorations = "RESIZE"

-- Tabs
config.enable_tab_bar = true
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = false

-- ═══════════════════════════════════════════════════════════
-- ⌨️  Raccourcis clavier
-- ═══════════════════════════════════════════════════════════

config.keys = {
  -- Splits
  {
    key = '|',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' },
  },
  {
    key = '_',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  
  -- Navigation entre les panes (comme Helix)
  {
    key = 'h',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.ActivatePaneDirection 'Left',
  },
  {
    key = 'j',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.ActivatePaneDirection 'Down',
  },
  {
    key = 'k',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.ActivatePaneDirection 'Up',
  },
  {
    key = 'l',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.ActivatePaneDirection 'Right',
  },
  
  -- Redimensionner les panes
  {
    key = 'LeftArrow',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.AdjustPaneSize { 'Left', 5 },
  },
  {
    key = 'RightArrow',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.AdjustPaneSize { 'Right', 5 },
  },
  {
    key = 'UpArrow',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.AdjustPaneSize { 'Up', 5 },
  },
  {
    key = 'DownArrow',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.AdjustPaneSize { 'Down', 5 },
  },
  
  -- Fermer le pane actuel
  {
    key = 'w',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.CloseCurrentPane { confirm = true },
  },
  
  -- Nouveau tab
  {
    key = 't',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.SpawnTab 'CurrentPaneDomain',
  },
  
  -- Navigation entre tabs
  {
    key = 'Tab',
    mods = 'CTRL',
    action = wezterm.action.ActivateTabRelative(1),
  },
  {
    key = 'Tab',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.ActivateTabRelative(-1),
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
config.visual_bell = {
  fade_in_function = 'EaseIn',
  fade_in_duration_ms = 150,
  fade_out_function = 'EaseOut',
  fade_out_duration_ms = 150,
}

-- Scrollback
config.scrollback_lines = 10000

-- Shell par défaut
config.default_prog = { '/usr/bin/zsh' }

return config
