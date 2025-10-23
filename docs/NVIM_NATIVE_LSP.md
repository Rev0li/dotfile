# 🚀 Migration vers LSP natif Neovim

## 🎯 **Pourquoi migrer ?**

### **Avant (avec plugins) :**
```lua
-- 3 plugins nécessaires
require("lspconfig").clangd.setup({...})  -- nvim-lspconfig
require("mason").setup()                   -- mason.nvim
require("mason-lspconfig").setup({...})    -- mason-lspconfig.nvim
```

### **Après (API native) :**
```lua
-- 1 seul plugin (pour installer les binaires)
vim.lsp.config('clangd', {...})  -- API native Neovim 0.11+
vim.lsp.enable('clangd')         -- Activation
require("mason").setup()         -- Seulement pour installer les binaires
```

---

## ✅ **Avantages :**

| Aspect | Avant | Après |
|--------|-------|-------|
| **Plugins** | 3 (lspconfig, mason, mason-lspconfig) | 2 (mason, mason-tool-installer) |
| **API** | Plugin externe | Native Neovim |
| **Performance** | Couche intermédiaire | Direct |
| **Maintenance** | Dépend du plugin | Intégré à Neovim |
| **Complexité** | setup() + handlers | config() + enable() |

---

## 📊 **Changements effectués :**

### **1. Fichiers modifiés :**
- ✅ `init.lua` - Charge `lsp_native.lua` au lieu de `lsp.lua`
- ✅ `plugins.lua` - Supprimé nvim-lspconfig et mason-lspconfig
- ✅ `lsp_native.lua` - Nouvelle config avec API native

### **2. Fichiers obsolètes (à supprimer après test) :**
- ❌ `lsp.lua` - Ancienne config avec lspconfig
- ❌ `lsp.lua.backup` - Backup

---

## 🔧 **Nouvelle architecture :**

```
nvim/
├── init.lua                 # Charge lsp_native.lua
├── lua/
│   ├── lsp_native.lua      # ✅ Config LSP native (nouveau)
│   ├── lsp.lua             # ❌ Ancienne config (à supprimer)
│   ├── plugins.lua         # ✅ Mason seulement
│   ├── settings.lua
│   ├── keymaps.lua
│   ├── treesitter.lua
│   └── ...
```

---

## 📝 **Nouvelle syntaxe LSP :**

### **Configuration d'un LSP :**
```lua
vim.lsp.config('clangd', {
  cmd = { 'clangd' },
  filetypes = { 'c', 'cpp' },
  root_markers = { 'compile_flags.txt', '.git' },
})
```

### **Activation automatique :**
```lua
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'c', 'cpp' },
  callback = function()
    vim.lsp.enable('clangd')
  end,
})
```

### **Keymaps au LspAttach :**
```lua
vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local opts = { buffer = args.buf }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    -- ...
  end,
})
```

---

## 🧪 **Installation et test :**

### **Étape 1 : Nettoyer Neovim**
```bash
cd ~/dotfiles
./nvim/reset_nvim.sh
```

### **Étape 2 : Installer Node.js (pour TypeScript)**
```bash
source ~/.zshrc
./nvim/install_node_lts.sh
```

### **Étape 3 : Lancer Neovim**
```bash
nvim
```

Lazy va installer :
- ✅ mason.nvim
- ✅ mason-tool-installer.nvim
- ✅ Autres plugins (treesitter, etc.)

### **Étape 4 : Vérifier Mason**
```vim
:Mason
```

Tu devrais voir :
- ✅ clangd
- ✅ pyright
- ✅ lua-language-server
- ✅ typescript-language-server

### **Étape 5 : Tester les LSP**
```bash
cd /tmp/nvim_lsp_test
nvim test.c
```

Tu devrais voir :
- ✅ "✓ LSP attaché: clangd"
- ✅ Autocomplétion native (Ctrl+Y pour accepter)
- ✅ Diagnostics

---

## 🎯 **Commandes utiles :**

### **Vérifier la config LSP :**
```vim
:checkhealth vim.lsp
```

### **Info sur les LSP actifs :**
```vim
:LspInfo
```

### **Redémarrer un LSP :**
```vim
:LspRestart
```

### **Voir les logs :**
```vim
:LspLog
```

---

## 📋 **Raccourcis LSP (inchangés) :**

| Raccourci | Action |
|-----------|--------|
| `gd` | Aller à la définition |
| `gD` | Aller à la déclaration |
| `gi` | Aller à l'implémentation |
| `gr` | Voir les références |
| `K` | Documentation (hover) |
| `<leader>rn` | Renommer |
| `<leader>ca` | Actions de code |
| `<leader>f` | Formater le code |
| `[d` | Diagnostic précédent |
| `]d` | Diagnostic suivant |
| `<leader>e` | Afficher diagnostic |

---

## 🆕 **Autocomplétion native :**

Neovim 0.11+ inclut l'autocomplétion native :
- **Trigger** : Automatique ou `Ctrl+Space`
- **Accepter** : `Ctrl+Y`
- **Naviguer** : `Ctrl+N` / `Ctrl+P`

Pas besoin de nvim-cmp pour l'autocomplétion de base !

---

## 🔄 **Rollback (si problème) :**

Si la nouvelle config ne fonctionne pas :

```bash
cd ~/dotfiles/nvim
# Restaurer l'ancienne config
git checkout lua/lsp.lua lua/plugins.lua init.lua
# Nettoyer et réinstaller
./reset_nvim.sh
nvim
```

---

## ✅ **Résumé :**

### **Plugins supprimés :**
- ❌ nvim-lspconfig
- ❌ mason-lspconfig.nvim

### **Plugins ajoutés :**
- ✅ mason-tool-installer.nvim (auto-install des LSP)

### **Fichiers :**
- ✅ `lsp_native.lua` - Config LSP native
- ❌ `lsp.lua` - À supprimer après test

### **Résultat :**
- ✅ Config plus simple
- ✅ Moins de plugins
- ✅ API officielle Neovim
- ✅ Même fonctionnalités

---

## 🎉 **Prochaines étapes :**

1. ✅ Nettoyer Neovim : `./nvim/reset_nvim.sh`
2. ✅ Installer Node.js : `./nvim/install_node_lts.sh`
3. ✅ Lancer Neovim : `nvim`
4. ✅ Tester les LSP
5. ✅ Supprimer `lsp.lua` si tout fonctionne
