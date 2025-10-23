# 🔍 Guide Telescope - Recherche de fichiers et texte

## 🎯 **Nouveaux raccourcis**

| Raccourci | Fonction | Description |
|-----------|----------|-------------|
| `<leader>f` | **Find Files** | Rechercher fichiers par nom |
| `<leader>g` | **Live Grep** | Rechercher texte dans tous les fichiers |
| `<leader>b` | **Buffers** | Lister les buffers ouverts |

---

## 📋 **Utilisation détaillée**

### **1. Rechercher un fichier par nom (`<leader>f`)**

**Utilisation :**
```
<leader>f
```

**Ce qui se passe :**
- Une fenêtre Telescope s'ouvre
- Tu tapes le nom du fichier (ou partie du nom)
- Les résultats s'affichent en temps réel
- Appuie sur `Enter` pour ouvrir le fichier

**Exemple :**
```
<leader>f
Tape : "main"
→ Affiche : main.c, main.py, main.js, etc.
```

---

### **2. Rechercher du texte dans les fichiers (`<leader>g`)**

**Utilisation :**
```
<leader>g
```

**Ce qui se passe :**
- Une fenêtre Telescope s'ouvre
- Tu tapes le texte à rechercher
- Telescope cherche dans **tous les fichiers** du projet
- Les résultats montrent le fichier + la ligne contenant le texte
- Appuie sur `Enter` pour ouvrir le fichier à la ligne trouvée

**Exemple :**
```
<leader>g
Tape : "function hello"
→ Affiche tous les fichiers contenant "function hello"
```

**Cas d'usage :**
- Trouver où une fonction est définie
- Chercher toutes les occurrences d'une variable
- Trouver un message d'erreur spécifique
- Chercher un commentaire TODO

---

### **3. Lister les buffers ouverts (`<leader>b`)**

**Utilisation :**
```
<leader>b
```

**Ce qui se passe :**
- Affiche la liste de tous les fichiers ouverts (buffers)
- Tu peux naviguer entre eux
- Appuie sur `Enter` pour switcher vers un buffer

---

## ⌨️ **Navigation dans Telescope**

| Touche | Action |
|--------|--------|
| `Ctrl-n` ou `↓` | Résultat suivant |
| `Ctrl-p` ou `↑` | Résultat précédent |
| `Enter` | Ouvrir le fichier sélectionné |
| `Esc` | Fermer Telescope |
| `Ctrl-c` | Annuler |
| `Ctrl-u` | Effacer le texte de recherche |
| `Ctrl-q` | Envoyer résultats vers quickfix list |

---

## 🎯 **Exemples pratiques**

### **Exemple 1 : Trouver un fichier de config**

```
<leader>f
Tape : "config"
→ Affiche : config.lua, .config, settings.conf, etc.
```

### **Exemple 2 : Trouver où une fonction est utilisée**

```
<leader>g
Tape : "calculate_total"
→ Affiche tous les fichiers qui contiennent "calculate_total"
```

### **Exemple 3 : Trouver tous les TODO**

```
<leader>g
Tape : "TODO"
→ Affiche tous les fichiers avec des commentaires TODO
```

### **Exemple 4 : Chercher une erreur spécifique**

```
<leader>g
Tape : "Error: Connection failed"
→ Affiche où ce message d'erreur apparaît
```

---

## 🔧 **Configuration actuelle**

Dans `keymaps.lua` :

```lua
-- Telescope
vim.keymap.set('n', '<leader>f', builtin.find_files, { desc = 'Trouver fichiers' })
vim.keymap.set('n', '<leader>g', builtin.live_grep, { desc = 'Rechercher texte' })
vim.keymap.set('n', '<leader>b', builtin.buffers, { desc = 'Lister buffers' })
```

---

## 💡 **Astuces**

### **1. Recherche floue (fuzzy)**
Tu n'as pas besoin de taper le nom exact :
```
Fichier : "my_super_long_filename.py"
Tape : "mysuper" ou "long" ou "filename"
→ Telescope le trouvera !
```

### **2. Recherche avec regex**
Dans `live_grep`, tu peux utiliser des regex :
```
<leader>g
Tape : "function.*hello"
→ Trouve "function hello", "function test_hello", etc.
```

### **3. Ignorer certains fichiers**
Telescope ignore automatiquement :
- Les fichiers dans `.gitignore`
- `node_modules/`
- `.git/`

---

## 🚀 **Workflow recommandé**

### **Scénario 1 : Débugger un bug**
1. `<leader>g` → Cherche le message d'erreur
2. `Enter` → Ouvre le fichier à la ligne
3. Corrige le bug
4. `:w` → Sauvegarde

### **Scénario 2 : Refactoring**
1. `<leader>g` → Cherche le nom de la fonction
2. Vois toutes les occurrences
3. Modifie chaque occurrence
4. `:wa` → Sauvegarde tout

### **Scénario 3 : Navigation rapide**
1. `<leader>b` → Liste des buffers ouverts
2. `Enter` → Switch vers le buffer
3. Travaille
4. `<leader>b` → Retour au buffer précédent

---

## 📊 **Comparaison avec d'autres outils**

| Outil | Équivalent Telescope |
|-------|---------------------|
| `Ctrl-P` (VSCode) | `<leader>f` |
| `Ctrl-Shift-F` (VSCode) | `<leader>g` |
| `Ctrl-Tab` (VSCode) | `<leader>b` |
| `grep -r "text"` | `<leader>g` |
| `find . -name "file"` | `<leader>f` |

---

## ⚠️ **Prérequis**

Pour que `live_grep` fonctionne, tu dois avoir **ripgrep** installé :

```bash
# Vérifier si ripgrep est installé
rg --version

# Si pas installé (sur Ubuntu/Debian)
sudo apt install ripgrep

# Sur macOS
brew install ripgrep
```

---

## ✅ **Résumé**

| Besoin | Raccourci | Exemple |
|--------|-----------|---------|
| **Trouver un fichier** | `<leader>f` | "main.c" |
| **Chercher du texte** | `<leader>g` | "function hello" |
| **Switcher de buffer** | `<leader>b` | Liste des fichiers ouverts |

---

**Teste maintenant : `<leader>g` puis cherche "TODO" dans ton projet !** 🚀
