# 📚 Cheatsheet Neovim Interactif

## 🎯 **Raccourci principal :**

```
<leader>k
```

Appuie sur `<leader>k` (par défaut `,k` ou `\k`) pour ouvrir le menu interactif !

---

## 📋 **Catégories disponibles :**

| Raccourci | Catégorie | Description |
|-----------|-----------|-------------|
| `<leader>km` | 🔖 **Marks** | Marques pour naviguer |
| `<leader>kt` | ✂️ **Text Objects** | ci/ca/di/da/vi/va |
| `<leader>kn` | 🚀 **Navigation** | Déplacements rapides |
| `<leader>kv` | 👁️ **Visual Mode** | Sélections |
| `<leader>kw` | 📝 **Windows** | Splits et buffers |
| `<leader>ks` | 🔍 **Search** | Recherche et remplacement |
| `<leader>kf` | 📁 **Files** | Fichiers |
| `<leader>ku` | ↩️ **Undo/Redo** | Annuler/Refaire |
| `<leader>kr` | 🔄 **Registers** | Registres |

---

## 🔥 **Exemples pratiques :**

### **1. Text Objects (le plus puissant !) :**

#### **Scénario : Changer le contenu entre guillemets**
```python
print("Hello World")
      ^
      curseur ici
```

Tape : `ci"` puis `Bonjour<Esc>`

Résultat :
```python
print("Bonjour")
```

#### **Scénario : Supprimer une fonction avec ses parenthèses**
```c
printf("test");
      ^
      curseur ici
```

Tape : `da(`

Résultat :
```c
printf;
```

#### **Scénario : Changer le contenu d'un bloc**
```c
if (condition) {
    code here
    ^
    curseur ici
}
```

Tape : `ci{` puis écris ton nouveau code

---

### **2. Marks (marques) :**

#### **Scénario : Naviguer entre plusieurs endroits**
```
1. Ligne 10 : ma    (créer mark 'a')
2. Ligne 50 : mb    (créer mark 'b')
3. Ligne 100 : mc   (créer mark 'c')

Maintenant :
- 'a  → Retour ligne 10
- 'b  → Retour ligne 50
- 'c  → Retour ligne 100
```

#### **Marks automatiques utiles :**
```
`.  → Dernière modification
`^  → Dernière insertion
`[  → Début du dernier yank/change
`]  → Fin du dernier yank/change
```

---

### **3. Navigation rapide :**

#### **Scénario : Aller à un caractère sur la ligne**
```c
int result = calculate(x, y, z);
                       ^
                       aller ici
```

Depuis le début de la ligne, tape : `f(`

Pour aller au `y` : `f,` puis `;` (répéter)

#### **Scénario : Chercher un mot et le modifier**
```
Tape : *     (cherche le mot sous curseur)
Tape : cgn   (change next occurrence)
Tape : .     (répéter sur les suivants)
```

---

### **4. Visual Block (Ctrl-v) :**

#### **Scénario : Commenter plusieurs lignes**
```c
int a = 1;
int b = 2;
int c = 3;
```

1. Place curseur sur `i` de `int a`
2. `Ctrl-v` (visual block)
3. `jj` (descendre 2 lignes)
4. `I` (insert au début)
5. `//` (taper //)
6. `Esc` (applique à toutes les lignes)

Résultat :
```c
//int a = 1;
//int b = 2;
//int c = 3;
```

---

### **5. Registers (registres) :**

#### **Scénario : Copier dans plusieurs registres**
```
1. Sélectionne du texte
2. "ay   (yank dans register 'a')
3. Sélectionne autre texte
4. "by   (yank dans register 'b')

Maintenant :
- "ap  → Paste depuis 'a'
- "bp  → Paste depuis 'b'
```

#### **Clipboard système :**
```
"+y   → Copier vers clipboard système
"+p   → Coller depuis clipboard système
```

---

## 🎓 **Combinaisons avancées :**

### **1. Changer jusqu'à un caractère :**
```c
int result = 0;
    ^
    curseur ici
```

Tape : `ct=` puis `value`

Résultat :
```c
int value = 0;
```

### **2. Supprimer jusqu'à la fin de la ligne :**
```
D   (équivalent à d$)
```

### **3. Dupliquer une ligne :**
```
yyp   (yank ligne + paste)
```

### **4. Échanger deux lignes :**
```
ddp   (delete ligne + paste en dessous)
```

### **5. Joindre deux lignes :**
```
J   (join)
```

---

## 🔥 **Text Objects - Liste complète :**

| Commande | Description | Exemple |
|----------|-------------|---------|
| `ci(` | Change inside `()` | `func(old)` → `func(new)` |
| `ci{` | Change inside `{}` | `if {old}` → `if {new}` |
| `ci"` | Change inside `""` | `"old"` → `"new"` |
| `ci'` | Change inside `''` | `'old'` → `'new'` |
| `ci[` | Change inside `[]` | `[old]` → `[new]` |
| `cit` | Change inside tag | `<p>old</p>` → `<p>new</p>` |
| `ciw` | Change inside word | `word` → `newword` |
| `ca(` | Change around `()` | `func(old)` → `new` |
| `di(` | Delete inside `()` | `func(text)` → `func()` |
| `da(` | Delete around `()` | `func(text)` → `func` |
| `vi(` | Visual inside `()` | Sélectionne contenu |
| `va(` | Visual around `()` | Sélectionne avec `()` |
| `yi(` | Yank inside `()` | Copie contenu |
| `ya(` | Yank around `()` | Copie avec `()` |

**Remplace `(` par `{`, `"`, `'`, `[`, `t` selon besoin !**

---

## 💡 **Astuces bonus :**

### **1. Répéter la dernière action :**
```
.   (point)
```

### **2. Enregistrer une macro :**
```
qa      (enregistrer dans 'a')
...     (actions)
q       (stop)
@a      (rejouer)
@@      (rejouer dernière macro)
```

### **3. Incrémenter/Décrémenter un nombre :**
```
Ctrl-a  (incrémenter)
Ctrl-x  (décrémenter)
```

### **4. Changer la casse :**
```
~       (toggle case)
gU      (uppercase)
gu      (lowercase)
```

### **5. Indenter en visual mode :**
```
>       (indenter)
<       (dé-indenter)
=       (auto-indent)
```

---

## 🎯 **Workflow recommandé :**

### **Pour apprendre :**
1. Ouvre Neovim
2. Tape `<leader>k`
3. Explore les catégories
4. Teste les commandes
5. Répète jusqu'à mémorisation

### **Exercice quotidien :**
Choisis **1 commande par jour** et force-toi à l'utiliser !

**Jour 1** : `ci"` (change inside quotes)  
**Jour 2** : `ma` et `'a` (marks)  
**Jour 3** : `f<char>` (find character)  
**Jour 4** : `Ctrl-v` (visual block)  
**Jour 5** : `*` puis `cgn` (change next)  

---

## 📚 **Ressources :**

- `:help text-objects`
- `:help marks`
- `:help registers`
- `vimtutor` (tutoriel interactif)

---

## 🎉 **Résumé :**

**Le cheatsheet est maintenant accessible avec `<leader>k` !**

Les **Text Objects** (`ci`, `ca`, `di`, `da`, `vi`, `va`) sont les commandes les plus puissantes de Vim. Maîtrise-les et tu seras 10x plus rapide ! 🚀
