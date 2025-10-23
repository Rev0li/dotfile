# ✂️ Text Objects - Astuces et Solutions

## ❓ **Problème : `ci'` ou `ci"` ouvre le menu des marks**

### **Pourquoi ça arrive ?**

Quand tu tapes `'` ou `` ` `` en mode normal, Neovim pense que tu veux **aller à un mark** (comme `'a` pour aller au mark 'a').

Si tu tapes lentement `ci'`, Neovim attend que tu donnes un nom de mark après le `'`.

---

## ✅ **Solutions**

### **1. Taper rapidement (recommandé)**

Tape `ci'` **d'un coup**, sans pause entre les touches.

**Timeout configuré :** 300ms (0.3 secondes)

Si tu tapes les 3 touches en moins de 300ms, Neovim comprend que c'est un text object, pas un mark.

---

### **2. Comprendre le timeout**

Dans `settings.lua`, on a configuré :

```lua
vim.opt.timeoutlen = 300    -- 300ms pour les séquences de touches
vim.opt.ttimeoutlen = 10    -- 10ms pour les codes clavier
```

**Explication :**
- Si tu tapes `c` puis attends > 300ms, Neovim pense que tu as fini
- Si tu tapes `ci'` en < 300ms, Neovim comprend que c'est une séquence

---

### **3. Augmenter le timeout (si tu tapes lentement)**

Si 300ms c'est trop court pour toi, tu peux augmenter :

```lua
vim.opt.timeoutlen = 500    -- 500ms (0.5 secondes)
```

Ou même :

```lua
vim.opt.timeoutlen = 1000   -- 1 seconde
```

**Inconvénient :** Les menus (comme which-key) mettront plus de temps à apparaître.

---

## 🎯 **Exemples pratiques**

### **Scénario 1 : Changer le texte entre guillemets**

```python
print("Hello World")
      ^
      curseur ici
```

**Tape rapidement :** `ci"` puis `Bonjour<Esc>`

**Résultat :**
```python
print("Bonjour")
```

---

### **Scénario 2 : Changer le texte entre apostrophes**

```python
message = 'old text'
           ^
           curseur ici
```

**Tape rapidement :** `ci'` puis `new text<Esc>`

**Résultat :**
```python
message = 'new text'
```

---

### **Scénario 3 : Supprimer le contenu entre guillemets**

```c
printf("test");
       ^
       curseur ici
```

**Tape :** `di"`

**Résultat :**
```c
printf("");
```

---

## 💡 **Astuces supplémentaires**

### **1. Utiliser des alternatives**

Si tu as vraiment du mal avec `'` et `"`, tu peux utiliser :

- `ciw` - Change inside word (pas besoin de guillemets)
- `caw` - Change around word (inclut espaces)
- `ci(` - Change inside parenthèses (pas de conflit)

### **2. Pratiquer la vitesse**

Entraîne-toi à taper `ci'` rapidement :
1. Ouvre `~/dotfiles/nvim/practice.txt`
2. Tape `ci'` plusieurs fois
3. Augmente ta vitesse progressivement

### **3. Vérifier le timeout actuel**

Dans Neovim, tape :
```vim
:set timeoutlen?
```

Tu devrais voir : `timeoutlen=300`

---

## 🔧 **Configuration actuelle**

Dans `~/dotfiles/nvim/lua/settings.lua` :

```lua
-- ⏱️  Timeouts (pour éviter confusion marks/text objects)
vim.opt.timeoutlen = 300    -- Temps d'attente pour les séquences (ms)
vim.opt.ttimeoutlen = 10    -- Temps d'attente pour les codes clavier (ms)
```

**Valeurs recommandées :**
- **Rapide (expert)** : `timeoutlen = 200`
- **Normal** : `timeoutlen = 300` ✅ (actuel)
- **Lent** : `timeoutlen = 500`
- **Très lent** : `timeoutlen = 1000`

---

## 📊 **Tableau récapitulatif**

| Commande | Description | Conflit avec marks ? |
|----------|-------------|----------------------|
| `ci(` | Change inside `()` | ❌ Non |
| `ci{` | Change inside `{}` | ❌ Non |
| `ci[` | Change inside `[]` | ❌ Non |
| `ci"` | Change inside `""` | ⚠️ Oui (tape vite !) |
| `ci'` | Change inside `''` | ⚠️ Oui (tape vite !) |
| `ciw` | Change inside word | ❌ Non |
| `cit` | Change inside tag | ❌ Non |

---

## 🎓 **Exercice**

1. Ouvre un fichier avec du texte entre guillemets
2. Place ton curseur dans le texte
3. Tape `ci"` **rapidement**
4. Tape du nouveau texte
5. Appuie sur `Esc`

**Répète jusqu'à ce que ce soit naturel !**

---

## ✅ **Résumé**

- ✅ **Timeout configuré à 300ms**
- ✅ **Tape `ci'` ou `ci"` rapidement**
- ✅ **Si trop court, augmente `timeoutlen`**
- ✅ **Pratique pour gagner en vitesse**

**C'est normal d'avoir ce comportement, c'est comme ça que Vim/Neovim fonctionne !** 🚀
