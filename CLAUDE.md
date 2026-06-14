# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

Portable development environment for Linux/Ubuntu and sudo-less environments (42, shared machines). All binaries are downloaded to `bin/` (gitignored) and exposed via `~/.local/bin/` symlinks — no system-wide installation needed.

## Key Commands

```bash
./install.sh                   # Full setup: symlinks + binary downloads
./script/check-versions.sh     # Compare installed vs latest GitHub releases
./script/doctor.sh             # Full environment diagnostic
./script/theme-toggle.sh       # Toggle dark/light (or pass "dark"/"light")
./script/clangd-init.sh        # Initialize clangd for a C/C++ project
./script/shortcut.sh           # Register GNOME keybinding Super+E → WezTerm
./script/wezterm-help.sh       # Print WezTerm cheatsheet (bottom-left pane; q to quit)
```

To update a binary: delete `bin/<tool>` then re-run `./install.sh`.

## Architecture

### Symlinks created by install.sh
| Source | Target |
|---|---|
| `zsh/custom_zshrc.zsh` | `~/.zshrc` |
| `helix/` | `~/.config/helix` |
| `wezterm/wezterm.lua` | `~/.config/wezterm/wezterm.lua` |
| `bin/<tool>` | `~/.local/bin/<tool>` (starship, hx, wezterm, wezterm-gui, wezterm-mux-server, eza) |

### Zsh module load order
`custom_zshrc.zsh` sources these in sequence: `exports.zsh` → `styles.zsh` → `options.zsh` → `aliases.zsh` → `functions.zsh`. Starship init must stay last. Machine-local config goes in `zsh/local.zsh` (not versioned).

### Theme system
`script/theme-toggle.sh` writes `"dark"` or `"light"` to `~/.config/theme` and updates `~/.config/theme-env` (sourced by zsh for `STARSHIP_CONFIG`). WezTerm reads `~/.config/theme` at startup via `read_theme()` in `wezterm.lua`. Helix config is patched in-place via `sed`. Two Starship configs: `starship/starship-dark.toml` and `starship/starship-light.toml`.

**Dark:** Tokyo Night (WezTerm) + Rose Pine Moon (Helix)  
**Light:** Tokyo Night Day (WezTerm) + Rose Pine Dawn (Helix)

### WezTerm key bindings
Defined in `wezterm/wezterm.lua`: `ALT+c` split vertical, `ALT+v` split horizontal, `CTRL+arrows` navigate panes, `SHIFT+ALT+arrows` resize panes, `SUPER+e` new tab, `SUPER+w` close pane (confirm), `SUPER+r` rename tab.

### Binary management
`install.sh` fetches latest releases from GitHub via the API (`latest_release()` helper). Helix ships a `helix-runtime/` directory alongside its binary — `HELIX_RUNTIME` env var in `exports.zsh` must point to `bin/helix-runtime/runtime`. WezTerm is downloaded as an AppImage (avoids `libfuse2` dependency).
