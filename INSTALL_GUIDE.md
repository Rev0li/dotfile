# 📦 Guide d'Installation Complet

## 🚀 Installation Rapide (Recommandée)

```bash
# 1. Cloner le dépôt
git clone https://github.com/Rev0li/dotfile.git ~/dotfiles

# 2. Lancer le script d'installation
cd ~/dotfiles
chmod +x install.sh
./install.sh

# 3. Recharger le terminal
exec zsh
```

---

## 📋 Ce que le script installe

### **Dépendances système :**
- ✅ Zsh (shell)
- ✅ curl, wget, unzip (outils)
- ✅ ripgrep (pour Telescope live_grep)

### **Applications :**
- ✅ Neovim (dernière version, portable)
- ✅ Kitty (terminal, portable)
- ✅ Oh My Posh (prompt moderne)

### **Fonts :**
- ✅ JetBrains Mono Nerd Font

### **Configuration :**
- ✅ Symlinks pour Zsh, Neovim, Kitty
- ✅ Backup de l'ancienne config (si existe)

---

## 🔍 Vérifications Pré-Installation

Le script vérifie automatiquement :

1. **Gestionnaire de paquets** (apt, pacman, dnf)
2. **Présence des dépendances**
3. **Existence des fichiers de config**
4. **Création de backups si nécessaire**

---

## 📂 Structure Après Installation

```
~/
├── dotfiles/                    # Dépôt cloné
│   ├── nvim/
│   │   ├── nvim-linux64/       # Binaire Neovim (téléchargé)
│   │   └── lua/                # Configuration Neovim
│   ├── kitty/
│   │   ├── kitty-linux64/      # Binaire Kitty (téléchargé)
│   │   └── kitty.conf          # Configuration Kitty
│   ├── zsh/                    # Configuration Zsh
│   └── install.sh              # Script d'installation
│
├── .zshrc → ~/dotfiles/zsh/custom_zshrc.zsh  # Symlink
├── .config/
│   ├── nvim → ~/dotfiles/nvim                # Symlink
│   └── kitty/
│       └── kitty.conf → ~/dotfiles/kitty/kitty.conf  # Symlink
│
└── .local/share/fonts/         # Nerd Fonts installées
```

---

## ⚙️ Configuration Post-Installation

### **1. Premier lancement de Neovim**

```bash
nvim
```

**Ce qui se passe :**
- Les plugins s'installent automatiquement (Lazy.nvim)
- Les LSP se téléchargent (Mason)
- Le dashboard s'affiche

**Temps estimé :** 1-2 minutes

---

### **2. Configuration de Kitty**

```bash
kitty
```

**Vérifier la font :**
- Ouvre Kitty
- Vérifie que les icônes s'affichent correctement
- Si problème : `kitty +list-fonts | grep JetBrains`

---

### **3. Vérification de Zsh**

```bash
echo $SHELL  # Devrait afficher /usr/bin/zsh ou /bin/zsh
```

Si ce n'est pas le cas :
```bash
chsh -s $(which zsh)
```

Puis redémarre ta session.

---

## 🔧 Dépannage

### **Problème : Neovim ne démarre pas**

```bash
# Vérifier que le binaire existe
ls ~/dotfiles/nvim/nvim-linux64/bin/nvim

# Vérifier les permissions
chmod +x ~/dotfiles/nvim/nvim-linux64/bin/nvim

# Tester directement
~/dotfiles/nvim/nvim-linux64/bin/nvim
```

---

### **Problème : Les icônes ne s'affichent pas**

**Cause :** Font non installée ou non configurée

**Solution :**
```bash
# Réinstaller les fonts
cd ~/dotfiles
./minimum_install.sh

# Vérifier l'installation
fc-list | grep JetBrains

# Configurer Kitty pour utiliser la font
# Dans ~/.config/kitty/kitty.conf :
# font_family JetBrainsMono Nerd Font
```

---

### **Problème : Telescope live_grep ne fonctionne pas**

**Cause :** ripgrep non installé

**Solution :**
```bash
# Ubuntu/Debian
sudo apt install ripgrep

# Arch
sudo pacman -S ripgrep

# Vérifier
rg --version
```

---

### **Problème : Oh My Posh ne s'affiche pas**

**Cause :** PATH non configuré

**Solution :**
```bash
# Vérifier l'installation
which oh-my-posh

# Si non trouvé, ajouter au PATH
export PATH="$HOME/.local/bin:$PATH"

# Recharger Zsh
source ~/.zshrc
```

---

## 🧹 Désinstallation

Pour supprimer complètement la configuration :

```bash
# 1. Supprimer les symlinks
rm ~/.zshrc
rm -rf ~/.config/nvim
rm ~/.config/kitty/kitty.conf

# 2. Restaurer l'ancienne config (si backup existe)
cp ~/dotfiles_backup_*/.zshrc ~/.zshrc

# 3. Supprimer le dépôt
rm -rf ~/dotfiles

# 4. Changer le shell (optionnel)
chsh -s /bin/bash
```

---

## 📊 Commandes de Vérification

### **Vérifier l'installation complète :**

```bash
# Zsh
echo $SHELL

# Neovim
nvim --version

# Kitty
kitty --version

# Oh My Posh
oh-my-posh --version

# Ripgrep
rg --version

# Fonts
fc-list | grep JetBrains
```

---

## 🎯 Prochaines Étapes

Après l'installation :

1. **Ouvre Neovim** : `nvim`
   - Attends que les plugins s'installent
   - Teste `<leader>k` pour le cheatsheet

2. **Configure ton terminal** :
   - Ouvre Kitty
   - Vérifie que tout s'affiche correctement

3. **Personnalise** :
   - Change le thème : `t` dans le dashboard Neovim
   - Modifie les raccourcis dans `~/dotfiles/nvim/lua/keymaps.lua`

4. **Explore la documentation** :
   - `~/dotfiles/README.md` - Vue d'ensemble
   - `~/dotfiles/docs/TELESCOPE_GUIDE.md` - Guide Telescope
   - `~/dotfiles/docs/TEXT_OBJECTS_TIPS.md` - Astuces text objects

---

## 💡 Conseils

### **Performance :**
- Neovim démarre en < 50ms
- Les plugins sont lazy-loaded
- LSP démarre uniquement pour les langages configurés

### **Maintenance :**
```bash
# Mettre à jour les dotfiles
cd ~/dotfiles
git pull

# Mettre à jour Neovim
cd ~/dotfiles/nvim
rm -rf nvim-linux64
# Puis relancer install.sh

# Mettre à jour les plugins Neovim
nvim
:Lazy update
```

### **Backup :**
```bash
# Sauvegarder ta config personnalisée
cp -r ~/dotfiles ~/dotfiles_backup_$(date +%Y%m%d)
```

---

## ✅ Checklist Post-Installation

- [ ] Neovim démarre sans erreur
- [ ] Dashboard s'affiche avec header ASCII
- [ ] Icônes visibles dans NvimTree
- [ ] Telescope fonctionne (`<leader>f` et `<leader>g`)
- [ ] Terminal flottant s'ouvre (`<leader>t`)
- [ ] Cheatsheet s'affiche (`<leader>k`)
- [ ] LSP fonctionne (autocomplétion)
- [ ] Oh My Posh affiche le prompt
- [ ] Kitty affiche les icônes correctement

---

## 🆘 Support

**Problème non résolu ?**

1. Vérifie les logs : `nvim --startuptime startup.log`
2. Consulte la documentation dans `~/dotfiles/docs/`
3. Ouvre une issue sur GitHub

---

**Installation terminée ! Profite de ta nouvelle configuration ! 🚀**
