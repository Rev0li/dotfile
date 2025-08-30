#!/usr/bin/env zsh
# ~/.zshrc (via dotfiles symlink)
# Configuration Zsh modulaire

# Définir le répertoire des dotfiles
export DOTFILES_DIR="$HOME/dotfiles"
export ZSH_CONFIG_DIR="$DOTFILES_DIR/zsh"

# Charger tous les modules dans l'ordre
source "$ZSH_CONFIG_DIR/exports.zsh"
source "$ZSH_CONFIG_DIR/plugins.zsh"
source "$ZSH_CONFIG_DIR/options.zsh"
source "$ZSH_CONFIG_DIR/styles.zsh"      # 🎨 Nouveau fichier de styles
source "$ZSH_CONFIG_DIR/aliases.zsh"
source "$ZSH_CONFIG_DIR/functions.zsh"   # 🛠️ Fonctions nettoyées

# Charger les configurations locales (non versionnées)
[ -f "$ZSH_CONFIG_DIR/local.zsh" ] && source "$ZSH_CONFIG_DIR/local.zsh"

# Charger les scripts existants
[ -f "$ZSH_CONFIG_DIR/brightness.sh" ] && source "$ZSH_CONFIG_DIR/brightness.sh"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Oh My Posh (si installé)
if command -v oh-my-posh &> /dev/null; then
  eval "$(oh-my-posh init zsh --config ~/dotfiles/OhMyPosh/hul10.omp.json)"
fi
