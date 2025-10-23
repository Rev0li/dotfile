# 🤝 Guide de Contribution

Merci de ton intérêt pour contribuer à ce projet ! Voici comment tu peux aider.

---

## 📋 Table des Matières

- [Code de Conduite](#code-de-conduite)
- [Comment Contribuer](#comment-contribuer)
- [Structure du Projet](#structure-du-projet)
- [Standards de Code](#standards-de-code)
- [Pull Requests](#pull-requests)

---

## 📜 Code de Conduite

- Sois respectueux et constructif
- Aide les autres utilisateurs
- Partage tes connaissances
- Signale les bugs de manière claire

---

## 🛠️ Comment Contribuer

### **1. Signaler un Bug**

Ouvre une issue avec :
- Description claire du problème
- Steps to reproduce
- Configuration système (OS, version Neovim, etc.)
- Logs d'erreur si disponibles

### **2. Proposer une Fonctionnalité**

Ouvre une issue avec :
- Description de la fonctionnalité
- Cas d'usage
- Exemples d'implémentation (si possible)

### **3. Améliorer la Documentation**

- Corrige les typos
- Ajoute des exemples
- Clarifie les explications
- Traduis (si multilingue)

### **4. Contribuer au Code**

1. Fork le projet
2. Crée une branche (`git checkout -b feature/ma-feature`)
3. Commit tes changements (`git commit -m 'Add: ma feature'`)
4. Push vers la branche (`git push origin feature/ma-feature`)
5. Ouvre une Pull Request

---

## 📁 Structure du Projet

```
dotfiles/
├── nvim/
│   ├── lua/
│   │   ├── dashboard.lua      # Dashboard configuration
│   │   ├── keymaps.lua        # Keybindings
│   │   ├── lsp.lua            # LSP configuration
│   │   ├── plugins.lua        # Plugin management
│   │   ├── settings.lua       # Neovim settings
│   │   ├── cheatsheet.lua     # Cheatsheet popup
│   │   └── ...
│   └── init.lua               # Entry point
├── zsh/
│   ├── custom_zshrc.zsh       # Main Zsh config
│   ├── aliases.zsh            # Aliases
│   └── ...
├── kitty/
│   └── kitty.conf             # Kitty configuration
├── docs/                      # Documentation
├── install.sh                 # Installation script
└── README.md
```

---

## 📝 Standards de Code

### **Lua (Neovim)**

```lua
-- ════════════════════════════════════════
-- 📝 Section Title
-- ════════════════════════════════════════

-- Utiliser des commentaires clairs
local variable_name = "value"  -- Description

-- Fonctions avec documentation
function M.my_function()
  -- Description de ce que fait la fonction
  return result
end
```

### **Shell (Bash/Zsh)**

```bash
# ════════════════════════════════════════
# 📝 Section Title
# ════════════════════════════════════════

# Utiliser des noms de variables en MAJUSCULES pour les constantes
CONSTANT_NAME="value"

# Fonctions avec description
my_function() {
    # Description
    local var="value"
    echo "$var"
}
```

### **Conventions**

- ✅ Indentation : 4 espaces (ou tabs selon le fichier)
- ✅ Commentaires en français ou anglais (cohérent avec le fichier)
- ✅ Noms de variables descriptifs
- ✅ Sections séparées par des lignes de commentaires
- ✅ Code documenté

---

## 🔍 Pull Requests

### **Checklist PR**

Avant de soumettre une PR, vérifie que :

- [ ] Le code fonctionne sans erreur
- [ ] Les commentaires sont clairs
- [ ] La documentation est à jour
- [ ] Les fichiers sont formatés correctement
- [ ] Pas de fichiers temporaires (`.swp`, `.log`, etc.)
- [ ] Le commit message est clair

### **Format du Commit Message**

```
Type: Description courte

Description détaillée (optionnel)

Fixes #123 (si applicable)
```

**Types :**
- `Add:` Nouvelle fonctionnalité
- `Fix:` Correction de bug
- `Update:` Mise à jour
- `Refactor:` Refactoring
- `Docs:` Documentation
- `Style:` Formatage

**Exemples :**
```
Add: Terminal flottant avec bordure arrondie

Fix: Correction du timeout pour text objects

Docs: Ajout du guide Telescope
```

---

## 🧪 Tests

### **Tester Localement**

Avant de soumettre :

1. **Clone ton fork :**
   ```bash
   git clone https://github.com/TON_USERNAME/dotfile.git ~/dotfiles_test
   ```

2. **Lance l'installation :**
   ```bash
   cd ~/dotfiles_test
   ./install.sh
   ```

3. **Vérifie que tout fonctionne :**
   - Neovim démarre sans erreur
   - Plugins s'installent correctement
   - LSP fonctionne
   - Raccourcis fonctionnent

4. **Teste les nouvelles fonctionnalités**

---

## 📚 Ressources

### **Documentation Neovim**
- [Neovim Documentation](https://neovim.io/doc/)
- [Lua Guide](https://neovim.io/doc/user/lua-guide.html)
- [LSP Configuration](https://github.com/neovim/nvim-lspconfig)

### **Plugins**
- [Lazy.nvim](https://github.com/folke/lazy.nvim)
- [Telescope](https://github.com/nvim-telescope/telescope.nvim)
- [NvimTree](https://github.com/nvim-tree/nvim-tree.lua)

---

## 💡 Idées de Contribution

### **Facile**
- Corriger des typos dans la documentation
- Ajouter des exemples dans le cheatsheet
- Améliorer les commentaires dans le code

### **Moyen**
- Ajouter de nouveaux thèmes
- Créer de nouveaux raccourcis utiles
- Améliorer le dashboard

### **Avancé**
- Ajouter le support de nouveaux LSP
- Créer de nouveaux plugins personnalisés
- Optimiser les performances

---

## 🎯 Roadmap

### **À venir**
- [ ] Support de plus de langages (Go, Rust, TypeScript)
- [ ] Intégration Git (Fugitive ou Neogit)
- [ ] Debugger (DAP)
- [ ] Tests automatisés
- [ ] CI/CD

### **En cours**
- [x] Terminal flottant
- [x] Cheatsheet intégré
- [x] Telescope live_grep

---

## 📞 Contact

- **Issues** : [GitHub Issues](https://github.com/Rev0li/dotfile/issues)
- **Discussions** : [GitHub Discussions](https://github.com/Rev0li/dotfile/discussions)

---

## ❤️ Remerciements

Merci à tous les contributeurs qui rendent ce projet meilleur !

---

**Happy Coding ! 🚀**
