# 🚀 Dotfiles - Configuration refactorisée

Configuration épurée pour Helix, Starship et WezTerm.

## 📦 Stack

- **🖥️ WezTerm** - Terminal émulateur
- **⭐ Starship** - Prompt shell
- **✏️ Helix** - Éditeur de texte modal
- **🐚 Zsh** - Shell avec configuration modulaire

## ⚡ Installation rapide

```bash
# 1. Cloner/copier dans ~/dotfiles
cd ~
cp -r dotfiles ~/dotfiles  # ou git clone si repo

# 2. Installer les symlinks
cd ~/dotfiles
chmod +x install.sh
./install.sh

# 3. Recharger
exec zsh

# 4. Vérifier
./bin/doctor.sh
```

## 📁 Structure

```
dotfiles/
├── bin/                    # Scripts utilitaires
│   ├── check-versions.sh   # Vérifier versions
│   ├── doctor.sh           # Diagnostic
│   └── releases.txt        # Liens GitHub
├── helix/                  # Config Helix
│   └── config.toml
├── starship/               # Config Starship
│   └── starship.toml
├── wezterm/                # Config WezTerm
│   └── wezterm.lua
├── zsh/                    # Config Zsh
│   ├── zshrc
│   ├── aliases.zsh
│   ├── exports.zsh
│   ├── functions.zsh
│   ├── options.zsh
│   └── local.zsh.template
├── install.sh              # Installation standard
├── install_42.sh           # Installation 42 (sans sudo)
├── .gitignore
└── README.md
```

## 🛠️ Installation des outils

Les outils doivent être installés séparément (install.sh crée uniquement des symlinks).

### Starship
```bash
curl -sS https://starship.rs/install.sh | sh
```

### Helix
```bash
# Voir https://github.com/helix-editor/helix/releases
# Ubuntu: télécharger le .tar.xz
cd /tmp
VERSION=$(curl -s https://api.github.com/repos/helix-editor/helix/releases/latest | grep tag_name | cut -d'"' -f4)
wget "https://github.com/helix-editor/helix/releases/download/${VERSION}/helix-${VERSION}-x86_64-linux.tar.xz"
tar -xf "helix-${VERSION}-x86_64-linux.tar.xz"
sudo mv "helix-${VERSION}-x86_64-linux" /opt/helix
sudo ln -sf /opt/helix/hx /usr/local/bin/hx
```

### WezTerm
```bash
# Voir https://github.com/wez/wezterm/releases
# Ubuntu: installer le .deb
```

### Nerd Font
```bash
cd /tmp
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/JetBrainsMono.zip
unzip JetBrainsMono.zip -d ~/.local/share/fonts/
fc-cache -fv
```

## 🏫 Installation pour 42 (sans sudo)

```bash
chmod +x install_42.sh
./install_42.sh
# Suivre les instructions affichées
```

## 🔍 Scripts utilitaires

```bash
# Vérifier les versions vs dernières releases
./bin/check-versions.sh

# Diagnostic complet de l'environnement
./bin/doctor.sh

# Voir les liens de téléchargement
cat bin/releases.txt
```

## ⌨️ Raccourcis clavier

### WezTerm
| Raccourci | Action |
|-----------|--------|
| `Alt+v` | Split vertical |
| `Alt+c` | Split horizontal |
| `Ctrl+←→↑↓` | Naviguer entre panes |
| `Shift+Alt+←→↑↓` | Redimensionner |
| `Super+w` | Fermer pane |
| `Super+e` | Nouveau tab |
| `Super+/` | Aide |

### Helix
| Raccourci | Action |
|-----------|--------|
| `Alt+←→↑↓` | Naviguer entre fenêtres |
| `Space+f` | Ouvrir fichier |
| `Space+b` | Buffers |
| `:w` | Sauvegarder |
| `:q` | Quitter |

[Doc complète](https://docs.helix-editor.com/)

## 🎨 Alias utiles

```bash
# Navigation
dots              # cd ~/dotfiles

# Édition configs
helix-conf        # Éditer config Helix
starship-conf     # Éditer config Starship
wezterm-conf      # Éditer config WezTerm
zsh-conf          # Éditer .zshrc

# Vérification
check-versions    # Vérifier versions outils

# Git
gs                # git status
gd                # git diff
ga                # git add .
gc                # git commit
```

Voir tous les alias : `cat ~/dotfiles/zsh/aliases.zsh`

## 🎯 Personnalisation

### Changer le thème

**Helix** (`helix/config.toml`) :
```toml
theme = "rose_pine_moon"  # ou catppuccin_mocha, tokyonight, gruvbox...
```

**WezTerm** (`wezterm/wezterm.lua`) :
```lua
config.color_scheme = 'Tokyo Night'  -- ou rose-pine-moon...
```

### Ajouter des alias

Éditer `zsh/aliases.zsh` :
```bash
alias mon_alias="ma_commande"
```

### Configuration locale (non versionnée)

```bash
# Créer depuis le template
cp zsh/local.zsh.template zsh/local.zsh
# Éditer avec tes configs spécifiques (tokens, proxys, etc.)
hx zsh/local.zsh
```

## 🔧 Dépannage

### Starship ne s'affiche pas
```bash
which starship
curl -sS https://starship.rs/install.sh | sh
source ~/.zshrc
```

### Icônes cassées (□□□)
```bash
# Installer JetBrains Mono Nerd Font (voir ci-dessus)
fc-cache -fv
```

### Helix : commande non trouvée
```bash
which hx
echo $PATH
# Réinstaller Helix (voir ci-dessus)
```

### Diagnostic complet
```bash
./bin/doctor.sh
```

## 📚 Ressources

- [WezTerm](https://wezfurlong.org/wezterm/)
- [Starship](https://starship.rs/)
- [Helix](https://docs.helix-editor.com/)
- [Zsh](https://zsh.sourceforge.io/Doc/)

## 🆕 Nouveautés de cette version

### ✨ Ajouté
- Dossier `bin/` avec scripts de vérification
- Template `local.zsh` pour configs non versionnées
- `.gitignore`

### 🔄 Modifié
- `install.sh` simplifié (symlinks only)
- EDITOR changé de nvim à hx
- Configs Zsh réorganisées

### ❌ Supprimé
- Références à nvim (non utilisé)
- Doublons de code
- Fonctions complexes peu utilisées

## 📝 Notes

- Les outils (Starship, Helix, WezTerm) doivent être installés manuellement
- `install.sh` crée uniquement des symlinks
- JetBrains Mono Nerd Font requis pour les icônes
- Zsh requis (Starship est un prompt, pas un shell)

---

**Bon développement ! 🚀**
