#!/bin/bash

echo "🔹 Configuration de Neovim..."

DOTFILES_DIR="$(dirname $(realpath $0))"
NVIM_DIR="$DOTFILES_DIR/nvim/nvim-linux64"
NVIM_BIN="$NVIM_DIR/bin/nvim"

if [ ! -f "$NVIM_BIN" ]; then
    echo "❌ Neovim personnalisé non trouvé dans $NVIM_BIN."
    exit 1
fi

export PATH="$NVIM_DIR/bin:$PATH"
echo "export PATH=\"$NVIM_DIR/bin:\$PATH\"" >> "$HOME/.zshrc"
echo "✔️ Neovim ajouté au PATH."

if [ ! -f "$HOME/.local/share/nvim/site/autoload/plug.vim" ]; then
    curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    echo "✔️ vim-plug installé."
fi

"$NVIM_BIN" +PlugInstall +qall
echo "✔️ Plugins Neovim installés."

ln -sf "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"
echo "✔️ Configuration Neovim liée."

echo "✅ Installation de Neovim terminée."

