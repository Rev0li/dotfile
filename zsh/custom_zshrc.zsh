#!/usr/bin/env zsh
# ~/.zshrc (via dotfiles symlink)
# Configuration Zsh modulaire

# Définir le répertoire des dotfiles
export DOTFILES_DIR="$HOME/dotfiles"
export ZSH_CONFIG_DIR="$DOTFILES_DIR/zsh"
export PATH=$HOME/.local/ffmpeg/ffmpeg-*-static:$PATH
export PATH=$HOME/.config/helix/runtime
export PATH="$HOME/.local/bin:$PATH"

# Charger tous les modules dans l'ordre
source "$ZSH_CONFIG_DIR/exports.zsh"
source "$ZSH_CONFIG_DIR/plugins.zsh"
source "$ZSH_CONFIG_DIR/options.zsh"
source "$ZSH_CONFIG_DIR/aliases.zsh"
source "$ZSH_CONFIG_DIR/functions.zsh"

# Charger les configurations locales (non versionnées)
[ -f "$ZSH_CONFIG_DIR/local.zsh" ] && source "$ZSH_CONFIG_DIR/local.zsh"

# Charger les scripts existants
[ -f "$ZSH_CONFIG_DIR/brightness.sh" ] && source "$ZSH_CONFIG_DIR/brightness.sh"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Initialiser le système de complétion Zsh
autoload -Uz compinit
compinit

# ⚠️ STARSHIP EN DERNIER - CRITIQUE !
if command -v starship &> /dev/null; then
  export STARSHIP_CONFIG="$DOTFILES_DIR/starship/starship.toml"
  eval "$(starship init zsh)"
fi

# ⚠️ styles.zsh EN DERNIER (après Starship)
source "$ZSH_CONFIG_DIR/styles.zsh"

# Affichage initial sobre (optionnel, commenté par défaut)
# display_tree_simple
