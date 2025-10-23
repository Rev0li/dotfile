# 📝 Changelog

Toutes les modifications notables de ce projet seront documentées dans ce fichier.

---

## [2.0.0] - 2025-01-23

### ✨ Ajouts Majeurs

#### **Cheatsheet Intégré**
- Fenêtre flottante avec tous les raccourcis Vim/Neovim
- Sections : Marks, Text Objects, Navigation, Visual, Search, Windows, Undo, Registers, Files, Telescope
- Raccourci : `<leader>k`
- Fermeture : `q`, `Esc`, ou `Enter`

#### **Terminal Flottant**
- Terminal centré prenant 80% de l'écran
- Bordure arrondie avec titre "💻 Terminal"
- Raccourci : `<leader>t`
- Passe automatiquement en mode insert
- Réutilise la même session

#### **Telescope Live Grep**
- Recherche de texte dans tous les fichiers du projet
- Support regex
- Affichage fichier + ligne
- Raccourci : `<leader>g`
- Nécessite ripgrep (installé automatiquement)

#### **Telescope Buffers**
- Liste des buffers ouverts
- Switch rapide entre fichiers
- Raccourci : `<leader>b`

### 🔧 Améliorations

#### **Timeout Text Objects**
- Augmenté à 1 seconde (au lieu de 300ms)
- Plus de temps pour taper `ci'`, `ci"`, etc.
- Configurable dans `settings.lua`

#### **APIs Neovim**
- Remplacement des APIs deprecated
- `vim.bo[buf]` au lieu de `nvim_buf_set_option()`
- `vim.wo[win]` au lieu de `nvim_win_set_option()`

#### **Script d'Installation**
- Ajout de ripgrep dans les dépendances
- Vérifications améliorées
- Messages plus clairs
- Support apt, pacman, dnf

### 📚 Documentation

#### **Nouveaux Fichiers**
- `INSTALL_GUIDE.md` - Guide d'installation complet
- `FEATURES.md` - Liste complète des fonctionnalités
- `CONTRIBUTING.md` - Guide pour les contributeurs
- `docs/TELESCOPE_GUIDE.md` - Guide Telescope détaillé
- `docs/TEXT_OBJECTS_TIPS.md` - Astuces text objects
- `docs/NVIM_REMAPS.md` - Documentation des remaps

#### **README Mis à Jour**
- Ajout des nouvelles fonctionnalités
- Mise à jour des raccourcis
- Amélioration de la structure

### 🐛 Corrections

#### **Dashboard**
- Correction du `dashboard.button()` vide qui causait une erreur
- Suppression de la ligne problématique

#### **Cheatsheet**
- Correction de la ligne text objects manquante
- Mise à jour du timeout (1s au lieu de 300ms)

### 🗑️ Suppressions

- Suppression des remaps `'` et `"` (causaient des erreurs)
- Nettoyage des fichiers temporaires
- Déplacement de la documentation dans `docs/`

---

## [1.0.0] - 2025-01-20

### ✨ Version Initiale

#### **Neovim**
- Dashboard personnalisé (alpha-nvim)
- LSP natif (C, Python, Lua)
- Autocomplétion (nvim-cmp)
- Syntax highlighting (Treesitter)
- Explorateur de fichiers (NvimTree)
- Telescope (recherche de fichiers)
- 7 thèmes disponibles
- Header 42

#### **Zsh**
- Configuration modulaire
- Oh My Posh (prompt moderne)
- Alias et fonctions utiles
- Gestion de la luminosité

#### **Kitty**
- Configuration complète
- Splits et tabs
- Font : JetBrains Mono Nerd Font
- Thème : Catppuccin Mocha

#### **Installation**
- Script d'installation automatique
- Installation de Neovim portable
- Installation de Kitty portable
- Installation des fonts
- Création des symlinks

---

## 📊 Statistiques

### **Version 2.0.0**
- **Fichiers modifiés** : 20+
- **Nouvelles fonctionnalités** : 4 majeures
- **Corrections de bugs** : 3
- **Documentation** : 6 nouveaux fichiers
- **Lignes de code ajoutées** : ~1500

### **Version 1.0.0**
- **Fichiers** : 50+
- **Plugins** : 21
- **Thèmes** : 7
- **Langages LSP** : 3

---

## 🎯 Prochaines Versions

### **v2.1.0 (Prévu)**
- [ ] Support TypeScript/JavaScript LSP
- [ ] Support Go LSP
- [ ] Support Rust LSP
- [ ] Intégration Git (Fugitive ou Neogit)
- [ ] Amélioration du dashboard (projets récents)

### **v2.2.0 (Prévu)**
- [ ] Debugger (DAP)
- [ ] Tests automatisés
- [ ] CI/CD
- [ ] Plus de thèmes
- [ ] Snippets personnalisés

---

## 📝 Format

Ce changelog suit le format [Keep a Changelog](https://keepachangelog.com/fr/1.0.0/),
et ce projet adhère au [Semantic Versioning](https://semver.org/lang/fr/).

### **Types de Changements**
- `Ajouts` - Nouvelles fonctionnalités
- `Améliorations` - Améliorations de fonctionnalités existantes
- `Corrections` - Corrections de bugs
- `Suppressions` - Fonctionnalités supprimées
- `Sécurité` - Corrections de vulnérabilités

---

**Dernière mise à jour : 23 janvier 2025**
