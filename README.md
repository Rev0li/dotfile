# 🧪 Configuration Neovim + Zsh personnalisée

Bienvenue dans mon setup personnel de développement basé sur **Neovim** (intégré dans les dotfiles) et **Zsh** pour une expérience fluide, esthétique et ultra-modulaire.

---

## 🗂️ Arborescence

```
dotfiles/
├── nvim/
│   ├── lua/
│   │   ├── dashboard.lua      # Page d'accueil personnalisée
│   │   ├── keymaps.lua        # Tous les raccourcis clavier
│   │   ├── lsp.lua            # Configuration LSP (clangd, pyright, lua_ls)
│   │   ├── nvimtree.lua       # Explorateur de fichiers
│   │   ├── plugins.lua        # Plugins gérés avec Lazy.nvim
│   │   ├── settings.lua       # Options générales
│   │   └── treesitter.lua     # Syntax highlighting performant
│   ├── nvim-linux64/          # Neovim compilé et intégré (aucune install requise)
│   │   └── ...
│   ├── .theme                 # Dernier thème sélectionné sauvegardé
│   ├── init.lua               # Point d'entrée principal
│   └── lazy-lock.json
├── zsh/
│   └── zshrc_cleaned.zsh      # Fichier de config Zsh propre
└── README.md
```

---

## 🚀 Aperçu visuel

📸 **Page d'accueil Neovim (Dashboard personnalisé)**  
👉 *[]*

📸 **Explorateur NvimTree avec icônes stylisées**  
👉 *[https://imgur.com/a/nnt7uHV]*

📸 **Sélecteur de thème interactif**  
👉 *[]*

---

## 🛠️ Installation rapide

### 1. Cloner ton dépôt (ou copier les fichiers)

```bash
git clone https://github.com/Rev0li/dotfile.git ~/dotfiles
```

---

### 2. Installer Zsh (si pas déjà présent)

```bash
sudo apt install zsh     # Debian / Ubuntu
sudo pacman -S zsh       # Arch / Manjaro
chsh -s $(which zsh)     # Pour définir Zsh comme shell par défaut
```

---

### 3. Lier le fichier zsh propre

```bash
ln -sf ~/dotfiles/zsh/zshrc_cleaned.zsh ~/.zshrc
source ~/.zshrc
```

---

### 4. Lancer Neovim depuis le binaire embarqué

```bash
~/dotfiles/nvim/nvim-linux64/bin/nvim
```

Ou créer un alias dans ton `.zshrc` :

```bash
alias nv="~/dotfiles/nvim/nvim-linux64/bin/nvim"
```

---

## ⚙️ Points forts

✅ Neovim 100% portable (aucune install système)  
✅ Dashboard custom + sélection de thème dynamique  
✅ Navigation améliorée avec split, tabs, resize, terminal toggle  
✅ Sauvegarde automatique à la sortie du mode insert  
✅ Affichage des caractères invisibles, indentation claire  
✅ Zsh propre avec alias utiles, thème, et support complet Neovim

---

## ✅ TODO personnels (pour plus tard)

- [ ] Ajouter plus de thèmes avec preview live
- [ ] Ajouter un menu "Projets récents"
- [ ] Ajouter une section "derniers commits Git" dans le dashboard

---

## ❤️ Config faite maison pour bosser comme un boss.
