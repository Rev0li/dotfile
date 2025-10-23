# 🧹 Plan de nettoyage Neovim

## ❌ À supprimer immédiatement :

1. **Symlink récursif** : `nvim/nvim` (boucle infinie)
2. **lazy-lock.json** (optionnel, peut être regénéré)

## 🔧 À configurer dans .gitignore :

```gitignore
# Déjà présent
nvim/nvim-linux64/

# À ajouter
nvim/lazy-lock.json
nvim/.theme
```

## 📋 Structure finale :

```
nvim/
├── init.lua
├── lua/
│   ├── dashboard/
│   ├── dashboard.lua
│   ├── header_random.lua
│   ├── keymaps.lua
│   ├── lsp.lua
│   ├── nvimtree.lua
│   ├── plugins.lua
│   ├── settings.lua
│   ├── treesitter.lua
│   └── utils.lua
└── nvim-linux64/  (ignoré par git)
```

## 🚀 Commandes :

```bash
# Supprimer le symlink récursif
rm nvim/nvim

# Optionnel : supprimer lazy-lock.json
rm nvim/lazy-lock.json
```
