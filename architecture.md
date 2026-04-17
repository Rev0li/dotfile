# Architecture

## Overview

Zero-sudo portable dev environment. All binaries live in `bin/` (gitignored), exposed to `PATH` via `~/.local/bin/` symlinks. Config files are symlinked from the repo into their expected locations.

---

## Symlink map

| Repo path | System target | Created by |
|---|---|---|
| `zsh/custom_zshrc.zsh` | `~/.zshrc` | `install.sh` |
| `helix/` | `~/.config/helix/` | `install.sh` |
| `wezterm/wezterm.lua` | `~/.config/wezterm/wezterm.lua` | `install.sh` |
| `bin/starship` | `~/.local/bin/starship` | `install.sh` |
| `bin/hx` | `~/.local/bin/hx` | `install.sh` |
| `bin/wezterm` | `~/.local/bin/wezterm` | `install.sh` |
| `bin/mdcat` | `~/.local/bin/mdcat` | `install.sh` |
| `bin/clangd` | `~/.local/bin/clangd` | `install.sh` |

> Helix ships as a tarball with a `helix-runtime/` directory alongside the `hx` binary. Both land in `bin/`. `HELIX_RUNTIME` must point to `bin/helix-runtime/runtime` for grammars/themes to load.

---

## Zsh load order

`~/.zshrc` → `zsh/custom_zshrc.zsh` (symlinked), which sets `DOTFILES_DIR` and `PATH` first, then sources:

```
exports.zsh   — env vars, HELIX_RUNTIME, EDITOR, HISTFILE
plugins.zsh   — optional plugin loader (zsh-autosuggestions, etc., all commented out)
styles.zsh    — LS_COLORS, display_tree_centered/no_clear/simple functions
options.zsh   — setopt flags, vi mode (bindkey -v), chpwd() hook → display_tree_centered
aliases.zsh   — shell aliases (modern replacements: eza→ls, bat→cat, rg→grep if present)
functions.zsh — mkcd, up, ff, fdd, extract, archive, sysinfo, dirsize, topproc
```

After modules: `compinit`, Starship init (last), `local.zsh` (unversioned), `.fzf.zsh`, `theme-env`.

**Key constraint:** `options.zsh` calls `display_tree_centered` via `chpwd()`, which is defined in `styles.zsh` — so `styles.zsh` must always be sourced before `options.zsh`.

---

## Theme system

State machine with 3 files on disk:

```
~/.config/theme      — "dark" or "light" (read by wezterm.lua at startup)
~/.config/theme-env  — exports STARSHIP_CONFIG=<path> (sourced by zshrc)
helix/config.toml    — patched in-place via sed (theme = "...")
```

`script/theme-toggle.sh [dark|light|<none>]` orchestrates all three. Zsh default when `theme-env` doesn't exist yet (fresh install): `starship-dark.toml`.

| Component | Dark | Light |
|---|---|---|
| WezTerm | Tokyo Night | Tokyo Night Day |
| Helix | rose_pine_moon | rose_pine_dawn |
| Starship | `starship/starship-dark.toml` | `starship/starship-light.toml` |

WezTerm reads `~/.config/theme` via `read_theme()` in Lua at config load time — requires `Ctrl+Shift+R` or `wezterm cli reload-configuration` to apply after a theme change (the script attempts IPC reload automatically).

---

## WezTerm layout

Auto-created on `gui-startup` event in `wezterm.lua`:

```
┌─────────────────────────┐
│   PANE 1 (60%)          │  main
├────────────┬────────────┤
│  PANE 2    │  PANE 3    │  bottom-left (28%) + bottom-right (12%)
└────────────┴────────────┘
```

Key bindings:

| Key | Action |
|---|---|
| `ALT+c` | SplitVertical (top/bottom) |
| `ALT+v` | SplitHorizontal (left/right) |
| `CTRL+arrows` | Navigate panes |
| `SHIFT+ALT+arrows` | Resize pane |
| `SUPER+e` | New tab |
| `SUPER+w` | Close pane |
| `SUPER+r` | Rename tab |
| `CTRL+?` | Show help popup |

Status bar (right) shows current mode: INSERT / VISUAL / custom key table name.

---

## Binary management

`install.sh` fetches latest releases from GitHub API (`latest_release <org/repo>`). Each binary is guarded by `bin_ok <name>` — skipped if already present.

To force re-download: `rm bin/<tool> && ./install.sh`

Special cases:
- **Helix**: tarball extracts to `bin/helix-runtime/`, binary copied to `bin/hx`. `HELIX_RUNTIME` in `zsh/exports.zsh` must stay in sync.
- **WezTerm**: AppImage (no `libfuse2` needed; runs extracted).
- **Starship**: piped installer, outputs to a temp dir then moved to `bin/`.

`script/check-versions.sh` compares `bin/<tool> --version` against GitHub latest. `DOTFILES_DIR` resolves one level up from `script/` via `dirname BASH_SOURCE[0]/..`.

---

## Scripts

| Script | Purpose |
|---|---|
| `install.sh` | Full setup: deps check → symlinks → binary downloads → `~/.local/bin/` exposure |
| `script/check-versions.sh` | Compare installed vs latest GitHub releases |
| `script/theme-toggle.sh` | Switch dark/light theme across WezTerm + Helix + Starship |
| `script/setup-wezterm-layout.sh` | Register GNOME Super+E shortcut pointing to `wezterm-launcher.sh` |
| `script/clangd-init.sh` | Generate `.clangd` config with gcc include paths for a C/C++ project |
| `script/wezterm-install.sh` | Standalone WezTerm AppImage installer (subset of install.sh) |
