# 🖥️ WezTerm — Guide complet

## Sommaire
1. [Comment WezTerm gère les touches](#1-comment-wezterm-gère-les-touches)
2. [Le problème Ctrl+← et Alt+←](#2-le-problème-ctrl--et-alt-)
3. [La solution — résoudre les conflits](#3-la-solution--résoudre-les-conflits)
4. [Tous tes raccourcis actuels](#4-tous-tes-raccourcis-actuels)
5. [Raccourcis shell utiles dans WezTerm](#5-raccourcis-shell-utiles-dans-wezterm)
6. [Aller plus loin](#6-aller-plus-loin)

---

## 1. Comment WezTerm gère les touches

WezTerm est un émulateur de terminal. Entre toi et ton shell (zsh), il y a deux couches :

```
Clavier
   ↓
WezTerm  ← intercepte certaines combinaisons en premier
   ↓
zsh/readline  ← reçoit le reste sous forme de séquences ANSI
```

Quand tu appuies sur `Ctrl+←`, WezTerm vérifie d'abord sa table de keybindings. S'il trouve une action associée, il l'exécute **et ne transmet rien au shell**. Zsh ne voit jamais la touche.

Si WezTerm ne trouve rien, il convertit la combinaison en une **séquence d'échappement ANSI** et l'envoie au shell. Par exemple `Alt+←` devient `\e[1;3D` que readline interprète comme "mot précédent".

---

## 2. Le problème Ctrl+← et Alt+←

Dans ta config `wezterm.lua` actuelle, tu as défini :

```lua
-- Navigation entre panes
{ key = 'LeftArrow',  mods = 'CTRL', action = ActivatePaneDirection 'Left'  }
{ key = 'RightArrow', mods = 'CTRL', action = ActivatePaneDirection 'Right' }
{ key = 'UpArrow',    mods = 'CTRL', action = ActivatePaneDirection 'Up'    }
{ key = 'DownArrow',  mods = 'CTRL', action = ActivatePaneDirection 'Down'  }
```

`Ctrl+←` est donc **capturé par WezTerm** → zsh ne le reçoit jamais → pas de déplacement mot par mot.

`Alt+←` n'est pas dans ta config WezTerm, mais certains OS (surtout macOS) ou certaines configs zsh en mode vi le capturent aussi.

---

## 3. La solution — résoudre les conflits

Tu as deux options :

### Option A — Changer les raccourcis de navigation panes (recommandé)

Libérer `Ctrl+←/→` pour le shell et utiliser une autre combinaison pour les panes.
Le standard dans la communauté WezTerm/tmux est `Ctrl+Shift` ou `Alt` :

```lua
-- Dans wezterm.lua, remplacer CTRL par CTRL|SHIFT pour les panes
{ key = 'LeftArrow',  mods = 'CTRL|SHIFT', action = wezterm.action.ActivatePaneDirection 'Left'  },
{ key = 'RightArrow', mods = 'CTRL|SHIFT', action = wezterm.action.ActivatePaneDirection 'Right' },
{ key = 'UpArrow',    mods = 'CTRL|SHIFT', action = wezterm.action.ActivatePaneDirection 'Up'    },
{ key = 'DownArrow',  mods = 'CTRL|SHIFT', action = wezterm.action.ActivatePaneDirection 'Down'  },
```

`Ctrl+←` est alors transmis au shell → zsh reçoit `\e[1;5D` → déplacement mot par mot ✓

### Option B — Envoyer explicitement la séquence ANSI au shell

Tu gardes `Ctrl+←` pour les panes ET tu crées un raccourci dédié
pour envoyer la séquence de déplacement mot par mot au shell :

```lua
-- Envoyer Alt+← au shell (mot précédent) avec une autre touche
{ key = 'b', mods = 'ALT', action = wezterm.action.SendString '\x1bb' },
{ key = 'f', mods = 'ALT', action = wezterm.action.SendString '\x1bf' },
```

`\x1bb` = séquence readline pour "mot précédent" (comme `Alt+B` en mode Emacs)
`\x1bf` = séquence readline pour "mot suivant"  (comme `Alt+F` en mode Emacs)

---

## 4. Tous tes raccourcis actuels

| Combinaison       | Action WezTerm            | Disponible pour le shell ? |
|-------------------|---------------------------|----------------------------|
| `Alt+c`           | Split horizontal          | ✗ capturé                  |
| `Alt+v`           | Split vertical            | ✗ capturé                  |
| `Ctrl+←`          | Pane gauche               | ✗ capturé                  |
| `Ctrl+→`          | Pane droite               | ✗ capturé                  |
| `Ctrl+↑`          | Pane haut                 | ✗ capturé                  |
| `Ctrl+↓`          | Pane bas                  | ✗ capturé                  |
| `Shift+Alt+←/→/↑/↓` | Resize pane             | ✗ capturé                  |
| `Super+w`         | Fermer pane               | ✗ capturé                  |
| `Super+e`         | Nouveau tab               | ✗ capturé (= ton shortcut) |
| `Super+r`         | Renommer tab              | ✗ capturé                  |
| `Super+/`         | Aide raccourcis           | ✗ capturé                  |
| `Alt+←`           | *(libre)*                 | ✓ transmis → mot précédent |
| `Alt+→`           | *(libre)*                 | ✓ transmis → mot suivant   |
| `Ctrl+a/e/u/k`    | *(libre)*                 | ✓ transmis → readline      |

---

## 5. Raccourcis shell utiles dans WezTerm

Ces combinaisons ne sont **pas** dans ta config WezTerm donc elles arrivent bien au shell.
Elles fonctionnent en mode Emacs (défaut) et en mode vi-insert.

### Navigation dans la ligne
| Combinaison | Action                        |
|-------------|-------------------------------|
| `Ctrl+a`    | Début de ligne                |
| `Ctrl+e`    | Fin de ligne                  |
| `Alt+←`     | Mot précédent                 |
| `Alt+→`     | Mot suivant                   |
| `Ctrl+←`    | Mot précédent *(après fix)*   |
| `Ctrl+→`    | Mot suivant *(après fix)*     |

### Édition
| Combinaison | Action                        |
|-------------|-------------------------------|
| `Ctrl+u`    | Supprimer jusqu'au début      |
| `Ctrl+k`    | Supprimer jusqu'à la fin      |
| `Ctrl+w`    | Supprimer le mot précédent    |
| `Alt+d`     | Supprimer le mot suivant      |
| `Ctrl+y`    | Coller (yank)                 |

### Historique
| Combinaison | Action                        |
|-------------|-------------------------------|
| `Ctrl+r`    | Recherche dans l'historique   |
| `Ctrl+p`    | Commande précédente           |
| `Ctrl+n`    | Commande suivante             |

### WezTerm natif (toujours disponible)
| Combinaison       | Action                        |
|-------------------|-------------------------------|
| `Ctrl+Shift+c`    | Copier la sélection           |
| `Ctrl+Shift+v`    | Coller                        |
| `Ctrl+Shift+↑`    | Scroll vers le haut           |
| `Ctrl+Shift+f`    | Recherche dans le scrollback  |

---

## 6. Aller plus loin

### Voir exactement quelle séquence envoie une touche
Dans ton terminal WezTerm, tape :
```bash
cat -v
# puis appuie sur la combinaison voulue
# Ctrl+← affichera :  ^[[1;5D
# Alt+←  affichera :  ^[[1;3D
# Ctrl+c pour quitter
```

### Débugger les keybindings WezTerm
```bash
# Lancer wezterm en mode debug pour voir les événements clavier
wezterm --config 'debug_key_events=true' start
```

### Tester qu'une touche arrive bien au shell
```bash
# Dans zsh, afficher les séquences reçues
bindkey | grep backward-word   # voir quelle séquence = mot précédent
```

### Ressources
- [Doc officielle keybindings](https://wezfurlong.org/wezterm/config/keys.html)
- [Séquences ANSI de référence](https://wezfurlong.org/wezterm/config/key-encoding.html)
- [Config complète wezterm.lua](https://wezfurlong.org/wezterm/config/files.html)
