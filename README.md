# dotfile

# My Development Environment

This repository contains my personal configuration files for:
- **Zsh** (`.zshrc`) with plugins and aliases.
- **Neovim** with my custom settings and plugins.

Feel free to use it or adapt it to your needs.

---

## 🚀 Installation

1. Clone the repository:

   git clone https://github.com/<your_username>/<repo_name>.git
   cd <repo_name>

chmod +x install.sh
./install.sh

---

### **Alias Zsh**
| Alias           | Commande Équivalente                       | Description                                                |
|------------------|--------------------------------------------|------------------------------------------------------------|
| `cmp`           | `gcc -Wall -Wextra -Werror`               | Compile avec les options de base pour les projets C.       |
| `nv`            | `nvim`                                    | Ouvre Neovim.                                              |
| `src`           | `source ~/.zshrc`                         | Recharge la configuration Zsh.                             |
| `cl`            | `clear`                                   | Efface l'écran du terminal.                                |
| `obs`           | `~/opt/Obsidian/obsidian`                 | Lance Obsidian depuis un chemin personnalisé.              |
| `ccc`           | `cc -Wall -Wextra -Werror`                | Compile avec les mêmes options que `cmp` (autre alias).    |
| `obsi-sync`     | `cd Music/Student_42 && git add . && git commit -m 'Update notes' && git push` | Synchronise vos notes dans Git. |

---

### **Raccourcis Clavier Neovim**
| Raccourci        | Commande Équivalente                | Description                                                |
|-------------------|-------------------------------------|------------------------------------------------------------|
| `<C-h>`          | `:Stdheader<CR>`                   | Ajoute un en-tête standard au fichier courant.             |
| `<C-d>`          | `:NvimTreeToggle<CR>`              | Ouvre ou ferme la barre latérale `nvim-tree`.              |
| `<C-s>`          | `:w<CR>`                           | Sauvegarde le fichier en cours d'édition.                  |

---

### **Fonctionnalités Importantes**

#### **Zsh**
- Basé sur **Oh My Zsh** avec le thème `robbyrussell`.
- Plugin `git` activé pour des raccourcis liés à la gestion des dépôts.

#### **Neovim**
- **Gestionnaire de fichiers :** `nvim-tree` avec icônes personnalisées.
- **Indentation cohérente :** Définit `tabstop` et `shiftwidth` à 4 espaces.
- **Plugin Manager :** Utilise `vim-plug` pour gérer les plugins.

---
