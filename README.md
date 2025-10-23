
# ⚡ Dotfiles Neovim + Zsh + Kitty — *by Rev0li*

> **Une configuration portable, moderne, et minimaliste pour tous tes besoins de dev sous Linux.**

---

## 🗂️ Arborescence des fichiers

```
dotfiles/
├── nvim/
│   ├── lua/
│   │   ├── dashboard.lua      # Dashboard Neovim personnalisé
│   │   ├── keymaps.lua        # Tous les raccourcis clavier Neovim
│   │   ├── lsp.lua            # Config LSP (C, Python, Lua)
│   │   ├── nvimtree.lua       # Explorateur de fichiers
│   │   ├── plugins.lua        # Plugins via Lazy.nvim
│   │   ├── settings.lua       # Options d'affichage & système
│   │   └── treesitter.lua     # Syntax highlighting performant
│   ├── nvim-linux64/          # Binaire Neovim (téléchargé par install.sh)
│   ├── .theme                 # Thème sélectionné dernièrement
│   └── init.lua               # Point d'entrée principal
├── zsh/
│   ├── custom_zshrc.zsh       # Point d'entrée principal Zsh
│   ├── aliases.zsh            # Alias et raccourcis
│   ├── exports.zsh            # Variables d'environnement
│   ├── functions.zsh          # Fonctions utilitaires
│   ├── options.zsh            # Options Zsh
│   ├── plugins.zsh            # Gestion des plugins
│   ├── styles.zsh             # Styles d'affichage
│   └── brightness.sh          # Script de gestion luminosité
├── kitty/
│   ├── kitty.conf             # Config Kitty complète
│   ├── session.conf           # Layout de démarrage personnalisé
│   └── kitty-linux64/         # Binaire Kitty (téléchargé par install.sh)
├── OhMyPosh/
│   ├── hul10.omp.json         # Thème Oh My Posh personnalisé
│   └── install.sh             # Script d'installation Oh My Posh
├── .gitignore                 # Fichiers à ignorer
├── install.sh                 # 🚀 Script d'installation automatique
├── minimum_install.sh         # Installation minimale (fonts + Oh My Posh)
└── README.md
```

---

## 🚀 Aperçu visuel

📸 **Dashboard Neovim**
![Dashboard](https://imgur.com/hmZqQct.png)

📁 **Explorateur NvimTree avec icônes**
![NvimTree](https://imgur.com/DyqP4kV.png)

🎨 **Sélecteur de thème interactif**
![Theme Selector](https://imgur.com/84xaThl.png)

---

## 🛠️ Installation rapide

### **Installation automatique (recommandée)**

```sh
# Clone le dépôt
git clone https://github.com/Rev0li/dotfile.git ~/dotfiles

# Lance le script d'installation
cd ~/dotfiles
./install.sh
```

Le script va automatiquement :
- ✅ Installer Zsh, curl, wget, unzip
- ✅ Télécharger et installer Oh My Posh
- ✅ Installer JetBrains Mono Nerd Font
- ✅ Télécharger Neovim et Kitty (binaires portables)
- ✅ Créer les symlinks nécessaires
- ✅ Définir Zsh comme shell par défaut

### **Installation manuelle**

Si tu préfères installer manuellement :

1. **Clone le dépôt :**
   ```sh
   git clone https://github.com/Rev0li/dotfile.git ~/dotfiles
   ```

2. **Installe les dépendances :**
   ```sh
   # Debian/Ubuntu
   sudo apt install zsh curl wget unzip

   # Arch/Manjaro
   sudo pacman -S zsh curl wget unzip
   ```

3. **Installe les Nerd Fonts :**
   ```sh
   cd ~/dotfiles
   ./minimum_install.sh
   ```

4. **Crée les symlinks :**
   ```sh
   ln -sf ~/dotfiles/zsh/custom_zshrc.zsh ~/.zshrc
   ln -sf ~/dotfiles/nvim ~/.config/nvim
   mkdir -p ~/.config/kitty
   ln -sf ~/dotfiles/kitty/kitty.conf ~/.config/kitty/kitty.conf
   ```

5. **Change le shell par défaut :**
   ```sh
   chsh -s $(which zsh)
   ```

---

## ✨ Fonctionnalités & points forts

* **Neovim 100% portable** (aucune install système)
* **Dashboard custom + header ASCII dynamique**
* **Sélecteur de thème interactif** (popup)
* **Cheatsheet intégré** (fenêtre flottante avec tous les raccourcis)
* **Terminal flottant** (80% de l'écran, centré, bordure arrondie)
* **Telescope** : recherche de fichiers ET texte dans le projet
* **Explorateur de fichiers (NvimTree) avec icônes**
* **LSP prêt à l'emploi** (C, Python, Lua)
* **Autocomplétion intelligente et Treesitter**
* **Navigation split, tabs, resize, terminal toggle…**
* **Timeout 1 seconde** pour text objects (ci', ci", etc.)
* **Sauvegarde automatique à la sortie du mode insert**
* **Affichage caractères invisibles, indentation claire**
* **Zsh minimaliste, thèmes, alias pratiques**
* **Kitty ultra-configuré (splits, tabs, layouts, etc.)**

---

## ⌨️ **Raccourcis & commandes utiles**

### **Neovim**
<leader> = touche espace en Normal Mode
<C-*>*   = Ctrl+ * puis *
<S-*>    = Shift + *
#### 🗂️ Onglets

| Action                     | Raccourci                 |
| -------------------------- | ------------------------- |
| Ouvrir un nouvel onglet    | `<leader>nn`              |
| Fermer l’onglet courant    | `<leader>nc`              |
| Aller à l’onglet précédent | `<S-H>` ou `<C-PageUp>`   |
| Aller à l’onglet suivant   | `<S-L>` ou `<C-PageDown>` |

#### 🌲 Fichiers & Arborescence

| Action                         | Raccourci           |
| ------------------------------ | ------------------- |
| Ouvrir/fermer l’explorateur    | `<leader>d`         |
| Trouver un fichier (Telescope) | `<leader>f`         |
| Rechercher texte dans fichiers | `<leader>g`         |
| Lister les buffers ouverts     | `<leader>b`         |
| Fichiers récents               | Depuis le Dashboard |

#### 🪟 Splits & navigation

| Action                                | Raccourci      |
| ------------------------------------- | -------------- |
| Split horizontal                      | `<C-w>s`       |
| Split vertical                        | `<C-w>v`      |
| Naviguer split gauche/droite/haut/bas | `Ctrl+Flèches` |
| Redimensionner split                  | `Alt+Flèches`  |

#### 🖥️ Terminal flottant

| Action                    | Raccourci   |
| ------------------------- | ----------- |
| Toggle terminal flottant  | `<leader>t` |
| Échap mode terminal       | `<Esc>`     |
| Fermer terminal           | `<leader>t` |

**Note :** Le terminal est flottant, centré, et prend 80% de l'écran.

#### 🗝️ Autres

| Action                       | Raccourci                                          |
| ---------------------------- | -------------------------------------------------- |
| Afficher le cheatsheet       | `<leader>k`                                        |
| Toggle caractères invisibles | `<leader>l`                                        |
| Changer de thème (popup)     | `t` depuis le dashboard                            |

**Cheatsheet :** Fenêtre flottante avec tous les raccourcis Vim/Neovim (marks, text objects, navigation, etc.)

#### 🏷️ **Header 42**

* Générer ou mettre à jour un header : `:Stdheader` ou touche `<F1>`

---

### **Kitty (terminal)**

> **Super** = Touche `Windows` ou `Cmd` (Mac).
#### 📂 Splits

| Action                                | Raccourci            |
| ------------------------------------- | -------------------- |
| Split                                 | `Ctrl+Shift+e`       |
| Naviguer split gauche/droite/haut/bas | `Ctrl+Shift+Flèches` |
| Redimensionner split                  | `Alt+Shift+Flèches`  |

#### 🗂️ Tabs

| Action                             | Raccourci                    |
| ---------------------------------- | ---------------------------- |
| Nouvel onglet                      | `Super+t`                    |
| Fermer l’onglet courant            | `Super+c`                    |
| Quitter kitty                      | `Super+q`                    |
| Aller à l’onglet suivant/précédent | `Ctrl+Shift+PageDown/PageUp` |

#### 📑 Divers

| Action                  | Raccourci |
| ----------------------- | --------- |
| Changer le nom d’onglet | `Super+r` |
| Fermer une fenêtre      | `Super+w` |


---

## 🪄 **Conseils & prise en main rapide**

* **Tout fonctionne out-of-the-box** : clone, symlink, lance, c’est prêt !
* **Neovim** : Menu dashboard dès l’ouverture, accès rapide à tout via `<leader>`
* **Kitty** : Splits & tabs faciles, navigation intuitive
* **Zsh** : Complet, prompt moderne, alias pour toutes les commandes récurrentes
* **Fichier `.theme`** pour garder le dernier thème sélectionné en mémoire

---

## 🏁 **À venir / TODO**

* [ ] Ajout d’autres thèmes (preview live)
* [ ] Section projets récents & commits Git dans le dashboard
* [ ] Intégration de plugins additionnels pour les besoins avancés

---

## ❤️ *Config maison pensée pour bosser vite et bien — plug & play.*
