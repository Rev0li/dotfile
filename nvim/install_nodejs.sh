#!/bin/bash
# Script pour installer Node.js LTS (v20) via nvm

echo "📦 Installation de Node.js LTS pour TypeScript LSP"
echo ""

# Vérifier si nvm est installé
if ! command -v nvm &> /dev/null; then
    echo "📥 Installation de nvm (Node Version Manager)..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
    
    # Charger nvm
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
else
    echo "✅ nvm déjà installé"
fi

# Installer Node.js LTS
echo ""
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
echo "  1. Redémarrer le terminal (ou source ~/.zshrc)"
echo "  2. Ouvrir Neovim"
echo "  3. :Mason pour réinstaller ts_ls"
echo "  4. Tester avec un fichier .js ou .ts"
echo ""
