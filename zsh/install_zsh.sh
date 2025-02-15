#!/bin/bash

echo "🔹 Installation de Oh My Zsh et plugins..."

if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    echo "✔️ Oh My Zsh installé."
else
    echo "✔️ Oh My Zsh est déjà installé."
fi

ZSH_CUSTOM=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}
git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions 2>/dev/null || true
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting 2>/dev/null || true
echo "✔️ Plugins Zsh installés."

# Lier le fichier .zshrc
DOTFILES_DIR="$(dirname $(realpath $0))"
ln -sf "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
echo "✔️ Fichier ~/.zshrc lié."

echo "✅ Installation de Zsh terminée."

