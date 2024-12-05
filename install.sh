#!/bin/bash
echo "Installing configuration files..."

# Backup existing files
[ -f ~/.zshrc ] && mv ~/.zshrc ~/.zshrc.bak
[ -d ~/.config/nvim ] && mv ~/.config/nvim ~/.config/nvim.bak

# Copy new files
cp ./zshrc ~/.zshrc
mkdir -p ~/.config/nvim
cp -r ./nvim/* ~/.config/nvim/

echo "Done! Don't forget to reload your terminal. -> source ~/.zshrc
"
