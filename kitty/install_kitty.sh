#!/bin/bash

echo "🔹 Installation et configuration de Kitty..."

if command -v kitty &> /dev/null; then
    echo "✔️ Kitty est déjà installé."
else
    if [[ "$(uname -s)" == "Linux" ]]; then
        if command -v apt &> /dev/null; then
            sudo apt update && sudo apt install -y kitty
        elif command -v pacman &> /dev/null; then
            sudo pacman -S --noconfirm kitty
        elif command -v dnf &> /dev/null; then
            sudo dnf install -y kitty
        elif command -v zypper &> /dev/null; then
            sudo zypper install -y kitty
        else
            echo "❌ Gestionnaire de paquets non pris en charge. Installez Kitty manuellement."
            exit 1
        fi
    elif [[ "$(uname -s)" == "Darwin" ]]; then
        if command -v brew &> /dev/null; then
            brew install kitty
        else
            echo "❌ Homebrew non installé. Installez Homebrew pour continuer."
            exit 1
        fi
    else
        echo "❌ Système non pris en charge pour l'installation automatique de Kitty."
        exit 1
    fi
    echo "✔️ Kitty installé avec succès."
fi

DOTFILES_DIR="$(dirname $(realpath $0))/.."
ln -sf "$DOTFILES_DIR/kitty" "$HOME/.config/"
echo "✔️ Configuration Kitty liée."

echo "✅ Installation de Kitty terminée."

