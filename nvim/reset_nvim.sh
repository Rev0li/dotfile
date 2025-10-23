#!/bin/bash
# Script pour nettoyer et réinitialiser Neovim

echo "🧹 Nettoyage de Neovim..."

# Supprimer les caches
echo "  → Suppression du cache Lazy..."
rm -rf ~/.local/share/nvim/lazy
rm -rf ~/.local/state/nvim/lazy

echo "  → Suppression du cache Neovim..."
rm -rf ~/.cache/nvim

echo "  → Suppression des données Neovim..."
rm -rf ~/.local/share/nvim/site
rm -rf ~/.local/share/nvim/swap

echo ""
echo "✅ Nettoyage terminé !"
echo ""
echo "📝 Prochaines étapes :"
echo "  1. Lancer Neovim : nvim"
echo "  2. Lazy va réinstaller les plugins automatiquement"
echo "  3. Attendre la fin de l'installation"
echo "  4. Redémarrer Neovim"
echo ""
