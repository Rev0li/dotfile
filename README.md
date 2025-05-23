
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
│   ├── nvim-linux64/          # Binaire Neovim autonome
│   ├── .theme                 # Thème sélectionné dernièrement
│   ├── init.lua               # Point d'entrée principal
│   └── lazy-lock.json
├── zsh/
│   └── zshrc_cleaned.zsh      # Config Zsh propre et portable
├── kitty/
│   ├── kitty.conf             # Config Kitty complète
│   └── session.conf           # Layout de démarrage personnalisé
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

1. **Clone le dépôt :**

   ```sh
   git clone https://github.com/Rev0li/dotfile.git ~/dotfiles
   ```

2. **Installe Zsh (si besoin) :**

   ```sh
   sudo apt install zsh     # Debian/Ubuntu
   sudo pacman -S zsh       # Arch/Manjaro
   chsh -s $(which zsh)     # Passe Zsh en shell par défaut
   ```

3. **Active la config Zsh :**

   ```sh
   ln -sf ~/dotfiles/zsh/zshrc_cleaned.zsh ~/.zshrc
   source ~/.zshrc
   ```

4. **Lance Neovim avec le binaire fourni :**

   ```sh
   ~/dotfiles/nvim/nvim-linux64/bin/nvim
   ```

   *(ou crée un alias dans ton `.zshrc` : `alias nv="~/dotfiles/nvim/nvim-linux64/bin/nvim"`)*

5. **Kitty (terminal) :**

   * Mets le binaire ou le dossier dans `~/dotfiles/kitty/`
   * Lance avec un alias :

     ```sh
     alias kitty="~/dotfiles/kitty/kitty-linux64/bin/kitty --session ~/dotfiles/kitty/session.conf"
     ```
   * (Optionnel) Ajoute `export DOTFILES_DIR=~/dotfiles` dans ton `.zshrc` pour les chemins dynamiques.

---

## ✨ Fonctionnalités & points forts

* **Neovim 100% portable** (aucune install système)
* **Dashboard custom + header ASCII dynamique**
* **Sélecteur de thème interactif** (popup)
* **Explorateur de fichiers (NvimTree) avec icônes**
* **LSP prêt à l’emploi** (C, Python, Lua)
* **Autocomplétion intelligente et Treesitter**
* **Navigation split, tabs, resize, terminal toggle…**
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
| Fichiers récents               | Depuis le Dashboard |

#### 🪟 Splits & navigation

| Action                                | Raccourci      |
| ------------------------------------- | -------------- |
| Split horizontal                      | `<C-w>s`       |
| Split vertical                        | `<C-w>v`      |
| Naviguer split gauche/droite/haut/bas | `Ctrl+Flèches` |
| Redimensionner split                  | `Alt+Flèches`  |

#### 🖥️ Terminal intégré

| Action              | Raccourci   |
| ------------------- | ----------- |
| Toggle terminal     | `<leader>t` |
| Échap mode terminal | `<Esc>`     |

#### 🗝️ Autres

| Action                       | Raccourci                                          |
| ---------------------------- | -------------------------------------------------- |
| Toggle caractères invisibles | `<leader>l`                                        |
| Changer de thème (popup)     | `t` depuis le dashboard                            |

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
