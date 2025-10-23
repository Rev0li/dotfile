#!/bin/bash
# Script pour installer Node.js LTS via nvm (déjà installé)

echo "📦 Installation de Node.js LTS pour TypeScript LSP"
echo ""

# Charger nvm
export NVM_DIR="$HOME/dotfiles/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Vérifier que nvm est chargé
if ! command -v nvm &> /dev/null; then
    echo "❌ Erreur : nvm n'est pas chargé"
    echo "Essaye : source ~/.zshrc"
    exit 1
fi

echo "✅ nvm chargé"
echo ""

# Installer Node.js LTS
echo "📥 Installation de Node.js LTS (v20)..."
nvm install --lts
nvm use --lts
nvm alias default lts/*

echo ""
echo "✅ Node.js installé !"
node --version
npm --version

echo ""
echo "📝 Prochaines étapes :"
echo "  1. Ouvrir Neovim"
echo "  2. Décommenter ts_ls dans lua/plugins.lua"
echo "  3. :Lazy sync"
echo "  4. Tester avec un fichier .js ou .ts"
echo ""
