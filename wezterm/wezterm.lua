local wezterm = require 'wezterm'
local config  = wezterm.config_builder()
local act     = wezterm.action

-- ── Thème dynamique ─────────────────────────────────────────

local function read_theme()
  local f = io.open(wezterm.home_dir .. '/.config/theme', 'r')
  if f then
    local v = f:read('*l'); f:close()
    return v and v:match('^%s*(.-)%s*$') or 'dark'
  end
  return 'dark'
end

local THEMES = {
  dark  = { color_scheme = 'Tokyo Night',     cursor_bg = '#e0b3e5', cursor_fg = '#1a1b26', selection_bg = '#b297b9', selection_fg = '#ffffff', split = '#b297b9' },
  light = { color_scheme = 'Tokyo Night Day', cursor_bg = '#7c6f9f', cursor_fg = '#ffffff', selection_bg = '#7c6f9f', selection_fg = '#ffffff', split = '#7c6f9f' },
}

local theme = THEMES[read_theme()] or THEMES.dark
config.color_scheme = theme.color_scheme
config.colors = {
  cursor_bg    = theme.cursor_bg,
  cursor_border = theme.cursor_bg,
  cursor_fg    = theme.cursor_fg,
  selection_bg = theme.selection_bg,
  selection_fg = theme.selection_fg,
  split        = theme.split,
}

-- ── Police & fenêtre ────────────────────────────────────────

config.font             = wezterm.font('JetBrains Mono', { weight = 'Medium' })
config.font_size        = 12.0
config.window_padding   = { left = 10, right = 10, top = 10, bottom = 10 }
config.enable_tab_bar   = true
config.use_fancy_tab_bar = false
config.inactive_pane_hsb = { saturation = 0.7, brightness = 0.6 }

-- ── Perf ────────────────────────────────────────────────────

config.max_fps           = 120
config.animation_fps     = 60
config.cursor_blink_rate = 500
config.audible_bell      = 'Disabled'
config.scrollback_lines  = 10000
config.default_prog      = { '/usr/bin/zsh' }

-- ── Layout au démarrage ─────────────────────────────────────

local HELP_CMD = os.getenv('HOME') .. '/dotfiles/script/wezterm-help.sh'

wezterm.on('gui-startup', function(cmd)
  local _, pane, window = wezterm.mux.spawn_window(cmd or {})
  window:gui_window():maximize()

  -- Colonne droite (30%) : aide permanente
  local help = pane:split { direction = 'Right', size = 0.3 }

  -- Colonne gauche (70%) : pane haut + pane bas
  pane:split { direction = 'Bottom', size = 0.35 }

  -- Lancer l'aide dans la colonne droite (q pour fermer less)
  help:send_text('clear && ' .. HELP_CMD .. ' | less -R\n')
end)

-- ── Status badge droite : INSERT / VISUAL ───────────────────

local BADGE = {
  INSERT = { text = ' INSERT ', fg = '#1a1b26', bg = '#a6e3a1' },
  VISUAL = { text = ' VISUAL ', fg = '#1a1b26', bg = '#cba6f7' },
}

config.status_update_interval = 100

wezterm.on('update-right-status', function(window, _)
  local b = window:active_key_table() == 'copy_mode' and BADGE.VISUAL or BADGE.INSERT
  window:set_right_status(wezterm.format {
    { Background = { Color = b.bg } },
    { Foreground = { Color = b.fg } },
    { Attribute  = { Intensity = 'Bold' } },
    { Text = b.text },
    'ResetAttributes',
  })
end)

-- ── Raccourcis (s'ajoutent aux defaults, ne remplacent rien) ─

config.keys = {
  { key = 'c', mods = 'ALT',       action = act.SplitVertical   { domain = 'CurrentPaneDomain' } },
  { key = 'v', mods = 'ALT',       action = act.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  { key = 'LeftArrow',  mods = 'CTRL', action = act.ActivatePaneDirection 'Left'  },
  { key = 'RightArrow', mods = 'CTRL', action = act.ActivatePaneDirection 'Right' },
  { key = 'UpArrow',    mods = 'CTRL', action = act.ActivatePaneDirection 'Up'    },
  { key = 'DownArrow',  mods = 'CTRL', action = act.ActivatePaneDirection 'Down'  },
  { key = 'LeftArrow',  mods = 'SHIFT|ALT', action = act.AdjustPaneSize { 'Left',  5 } },
  { key = 'RightArrow', mods = 'SHIFT|ALT', action = act.AdjustPaneSize { 'Right', 5 } },
  { key = 'UpArrow',    mods = 'SHIFT|ALT', action = act.AdjustPaneSize { 'Up',    5 } },
  { key = 'DownArrow',  mods = 'SHIFT|ALT', action = act.AdjustPaneSize { 'Down',  5 } },
  { key = 'w', mods = 'SUPER', action = act.CloseCurrentPane { confirm = true } },
  { key = 'e', mods = 'SUPER', action = act.SpawnTab 'CurrentPaneDomain' },
  { key = 'r', mods = 'SUPER', action = act.PromptInputLine {
      description = 'Rename tab',
      action = wezterm.action_callback(function(window, _, line)
        if line then window:active_tab():set_title(line) end
      end),
  }},
}

return config
