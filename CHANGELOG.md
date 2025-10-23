# 📋 Changelog - Nettoyage et restructuration

## 🗓️ Date : 23 Octobre 2025

### ✅ **Modifications effectuées**

#### **1. Suppression des fichiers inutiles**
- ❌ Supprimé `fish/` (shell non utilisé, tu utilises Zsh)
- ❌ Supprimé `gtk-3.0/` (config système vide)
- ❌ Supprimé `ibus/` (config clavier locale)
- ❌ Supprimé `pulse/` (config audio locale)
- ❌ Supprimé `mimeapps.list` (config système spécifique)

#### **2. Nettoyage du dossier Windsurf**
- 🧹 Supprimé tous les caches et fichiers temporaires (27 MB)
- ✅ Conservé uniquement `Windsurf/User/settings.json`
- 📝 Ajouté des règles `.gitignore` pour ignorer les caches futurs

#### **3. Amélioration du .gitignore**
Ajout de règles complètes pour :
- Binaires (nvim-linux64, kitty-linux64)
- Caches Neovim et Windsurf
- Fichiers temporaires système
- Configurations locales

#### **4. Création du script d'installation automatique**
- 📦 `install.sh` : Installation complète en une commande
  - Détection automatique du gestionnaire de paquets (apt/pacman/dnf)
  - Installation de Zsh, Oh My Posh, Nerd Fonts
  - Téléchargement de Neovim et Kitty
  - Création automatique des symlinks
  - Configuration du shell par défaut

#### **5. Mise à jour de la documentation**
- 📖 README.md mis à jour avec :
  - Instructions d'installation automatique
  - Arborescence complète et à jour
  - Section installation manuelle conservée

---

### 📊 **Résultat**

**Avant :**
- Dépôt encombré avec binaires et caches (~164 MB)
- Fichiers système non portables
- Installation manuelle complexe

**Après :**
- Dépôt propre avec seulement les configs
- `.gitignore` complet
- Installation automatisée en une commande
- Structure claire et documentée

---

### 🎯 **Prochaines étapes recommandées**

1. **Commit et push des changements :**
   ```sh
   git add .
   git commit -m "🧹 Nettoyage complet : suppression fichiers inutiles, ajout install.sh"
   git push
   ```

2. **Nettoyer l'historique Git (optionnel) :**
   Si tu veux supprimer les binaires de l'historique Git pour réduire la taille du dépôt :
   ```sh
   git filter-branch --tree-filter 'rm -rf nvim/nvim-linux64 kitty/kitty-linux64' HEAD
   git push --force
   ```
   ⚠️ **Attention** : Cette opération réécrit l'historique Git !

3. **Tester l'installation sur une machine propre :**
   ```sh
   git clone https://github.com/Rev0li/dotfile.git ~/dotfiles-test
   cd ~/dotfiles-test
   ./install.sh
   ```

---

### 📝 **Notes**

- Les binaires (Neovim, Kitty) sont maintenant téléchargés automatiquement
- Le `.gitignore` empêche de les versionner à l'avenir
- La configuration reste 100% portable
- Oh My Posh est utilisé pour l'affichage du prompt Zsh
