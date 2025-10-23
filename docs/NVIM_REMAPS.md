# ⌨️ Remaps Neovim - Touches simplifiées

## 🎯 **Problème résolu : `'` et `"` remappés**

### **Avant :**
- `'` → Aller aux marks (conflit avec `ci'`)
- `"` → Utiliser les registers (conflit avec `ci"`)

### **Après :**
- `\` → Aller aux marks (remplace `'`)
- `|` → Utiliser les registers (remplace `"`)

---

## ✅ **Avantages :**

1. ✅ **`ci'` et `ci"` fonctionnent instantanément** (plus de timeout)
2. ✅ **Plus besoin de taper rapidement**
3. ✅ **Touches `\` et `|` plus accessibles** sur clavier AZERTY/QWERTY

---

## 📋 **Nouveaux raccourcis**

### **Marks (marques) :**

| Avant | Après | Description |
|-------|-------|-------------|
| `'a` | `\a` | Aller au mark 'a' (début de ligne) |
| `'A` | `\A` | Aller au mark 'A' (global) |
| `` `a `` | `` `a `` | Aller au mark 'a' (position exacte) - **Inchangé** |

**Note :** `` ` `` (backtick) reste inchangé et fonctionne toujours !

---

### **Registers (registres) :**

| Avant | Après | Description |
|-------|-------|-------------|
| `"ay` | `\|ay` | Yank dans register 'a' |
| `"ap` | `\|ap` | Paste depuis register 'a' |
| `"+y` | `\|+y` | Yank vers clipboard système |
| `"+p` | `\|+p` | Paste depuis clipboard système |
| `"0p` | `\|0p` | Paste dernier yank (pas delete) |

**Note :** Les deux syntaxes fonctionnent (`"ay` et `|ay`) !

---

## 🎯 **Text Objects - Maintenant sans problème !**

### **Avant (avec timeout) :**
```
ci'   → Fallait taper rapidement (< 300ms)
ci"   → Fallait taper rapidement (< 300ms)
```

### **Après (instantané) :**
```
ci'   → ✅ Fonctionne instantanément !
ci"   → ✅ Fonctionne instantanément !
```

---

## 📊 **Exemples pratiques**

### **Exemple 1 : Changer texte entre guillemets**

```python
print("Hello World")
      ^
      curseur ici
```

**Tape :** `ci"` (à n'importe quelle vitesse)

**Résultat :**
```python
print("")  # Prêt à taper le nouveau texte
```

---

### **Exemple 2 : Utiliser les marks**

```
1. Ligne 10 : ma     (créer mark 'a')
2. Aller ligne 50
3. Tape : \a         (retour au mark 'a')
```

**Avant :** `'a`  
**Après :** `\a`

---

### **Exemple 3 : Copier dans un register**

```
1. Sélectionne du texte (visual mode)
2. Tape : |ay        (yank dans register 'a')
3. Ailleurs : |ap    (paste depuis register 'a')
```

**Avant :** `"ay` et `"ap`  
**Après :** `|ay` et `|ap`

---

## 🔧 **Configuration (keymaps.lua)**

```lua
-- Remapper ' et " pour éviter la confusion avec les marks
vim.keymap.set('n', '\\', "'", { noremap = true, desc = "Aller au mark" })
vim.keymap.set('n', '|', '"', { noremap = true, desc = "Utiliser register" })
```

---

## 💡 **Pourquoi ces touches ?**

### **`\` (backslash) pour les marks :**
- ✅ Proche de `'` conceptuellement
- ✅ Facile à taper
- ✅ Pas utilisé par défaut en mode normal

### **`|` (pipe) pour les registers :**
- ✅ Proche de `"` visuellement
- ✅ Facile à taper (AltGr+6 sur AZERTY)
- ✅ Pas utilisé par défaut en mode normal

---

## 🎓 **Mémorisation**

### **Astuce mnémotechnique :**

- **`\`** = "Slash" → **S**aut vers mark
- **`|`** = "Pipe" → **P**aste/register

---

## 📚 **Cheatsheet mis à jour**

Le cheatsheet (`<leader>k`) affiche maintenant :

```
┌─ 🔖 MARKS (Marques) ─────────────────────────────────────────────────────────┐
│ \a          Aller au mark 'a' (début de ligne) - REMAPPÉ de 'a              │
│ `a          Aller au mark 'a' (position exacte)                              │
└──────────────────────────────────────────────────────────────────────────────┘

┌─ 🔄 REGISTERS ───────────────────────────────────────────────────────────────┐
│ |ay         Yank dans register a    │ |ap       Paste depuis register a     │
│ ℹ️  NOTE : | remplace " pour les registers (plus facile à taper)            │
└──────────────────────────────────────────────────────────────────────────────┘

┌─ ✂️ TEXT OBJECTS ────────────────────────────────────────────────────────────┐
│ ✅ PLUS DE PROBLÈME : ci' et ci" fonctionnent maintenant sans timeout !     │
└──────────────────────────────────────────────────────────────────────────────┘
```

---

## ⚠️ **Note importante**

Si tu préfères garder les touches originales, tu peux :

1. Supprimer les remaps dans `keymaps.lua`
2. Utiliser le timeout (300ms) comme avant
3. Ou utiliser `` ` `` au lieu de `'` pour les marks

---

## ✅ **Résumé**

| Fonctionnalité | Ancienne touche | Nouvelle touche | Status |
|----------------|-----------------|-----------------|--------|
| **Marks** | `'a` | `\a` | ✅ Remappé |
| **Marks (exact)** | `` `a `` | `` `a `` | ✅ Inchangé |
| **Registers** | `"ay` | `\|ay` | ✅ Remappé |
| **Text objects** | `ci'` | `ci'` | ✅ Fonctionne sans timeout ! |

---

**Teste maintenant : ouvre Neovim et essaie `ci'` ou `ci"` à n'importe quelle vitesse !** 🚀
