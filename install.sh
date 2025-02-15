#!/bin/bash

# Dossier contenant tes dotfiles
DOTFILES_DIR="$(dirname $(realpath $0))"

echo "🚀 Lancement de l'installation..."

# Exécuter chaque install séparément
bash "$DOTFILES_DIR/zsh/install_zsh.sh"
bash "$DOTFILES_DIR/nvim/install_nvim.sh"
bash "$DOTFILES_DIR/kitty/install_kitty.sh"

echo "✅ Installation terminée. Rechargez votre terminal si nécessaire !"

