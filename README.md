# 🚀 Dotfiles - Configuration moderne pour développeurs

Configuration personnalisée pour un environnement de développement moderne et efficace.

## 📦 Stack

- **🖥️ WezTerm** - Terminal émulateur GPU-accelerated moderne
- **⭐ Starship** - Prompt shell minimaliste et rapide
- **✏️ Helix** - Éditeur de texte modal post-moderne
- **🐚 Zsh** - Shell avec configurations personnalisées

## ✨ Fonctionnalités

### WezTerm
- Thème Rose Pine Moon (cohérent avec Helix)
- Navigation entre panes avec `Ctrl+Shift+hjkl`
- Splits horizontaux/verticaux
- Transparence et blur
- Configuration Lua moderne

### Starship
- Prompt élégant et informatif
- Affichage Git intelligent
- Icônes pour langages de programmation
- Temps d'exécution des commandes
- Configuration personnalisable

### Helix
- Thème Rose Pine Moon
- Numéros de ligne relatifs
- LSP activé avec inlay hints
- Navigation entre fenêtres avec `Ctrl+hjkl`
- Configuration minimaliste

### Zsh
- Aliases personnalisés
- Fonctions utilitaires
- Plugins optimisés
- Styles et options configurés

## 🔧 Installation

### Installation automatique

```bash
cd ~/dotfiles
chmod +x install.sh
./install.sh
```

Le script d'installation va :
1. ✅ Détecter votre gestionnaire de paquets (apt/pacman/dnf)
2. ✅ Installer les dépendances nécessaires
3. ✅ Installer WezTerm, Starship et Helix
4. ✅ Installer JetBrains Mono Nerd Font
5. ✅ Créer les symlinks de configuration
6. ✅ Sauvegarder vos anciennes configurations

### Installation manuelle

Si vous préférez installer manuellement :

```bash
# 1. Installer les outils
# Voir les commandes spécifiques à votre distribution dans install.sh

# 2. Créer les symlinks
ln -sf ~/dotfiles/zsh/custom_zshrc.zsh ~/.zshrc
ln -sf ~/dotfiles/helix ~/.config/helix
ln -sf ~/dotfiles/wezterm/wezterm.lua ~/.config/wezterm/wezterm.lua

# 3. Recharger Zsh
exec zsh
```

## 📁 Structure

```
dotfiles/
├── helix/              # Configuration Helix
│   └── config.toml
├── starship/           # Configuration Starship
│   └── starship.toml
├── wezterm/            # Configuration WezTerm
│   └── wezterm.lua
├── zsh/                # Configuration Zsh
│   ├── aliases.zsh
│   ├── custom_zshrc.zsh
│   ├── exports.zsh
│   ├── functions.zsh
│   ├── options.zsh
│   ├── plugins.zsh
│   └── styles.zsh
├── Old/                # Anciennes configurations (kitty, nvim, OhMyPosh)
└── install.sh          # Script d'installation
```

## ⌨️ Raccourcis clavier

### WezTerm

| Raccourci | Action |
|-----------|--------|
| `Ctrl+Shift+\|` | Split horizontal |
| `Ctrl+Shift+_` | Split vertical |
| `Ctrl+Shift+h/j/k/l` | Navigation entre panes |
| `Ctrl+Shift+←/→/↑/↓` | Redimensionner panes |
| `Ctrl+Shift+w` | Fermer pane |
| `Ctrl+Shift+t` | Nouveau tab |
| `Ctrl+Tab` | Tab suivant |
| `Ctrl+Shift+Tab` | Tab précédent |

### Helix

| Raccourci | Action |
|-----------|--------|
| `Ctrl+h/j/k/l` | Navigation entre fenêtres |
| `Space+f` | Ouvrir fichier |
| `Space+b` | Liste des buffers |
| `:w` | Sauvegarder |
| `:q` | Quitter |

Voir la [documentation Helix](https://docs.helix-editor.com/) pour plus de raccourcis.

## 🎨 Personnalisation

### Changer le thème

**Helix** (`helix/config.toml`) :
```toml
theme = "rose_pine_moon"  # Changer ici
```

**WezTerm** (`wezterm/wezterm.lua`) :
```lua
config.color_scheme = 'rose-pine-moon'  -- Changer ici
```

**Starship** (`starship/starship.toml`) :
Modifier les couleurs dans chaque section `style = "bold color"`

### Ajouter des aliases Zsh

Éditer `zsh/aliases.zsh` :
```bash
alias mon_alias="ma_commande"
```

## 🔄 Mise à jour

```bash
cd ~/dotfiles
git pull
source ~/.zshrc  # Recharger Zsh
```

## 🐛 Dépannage

### Starship ne s'affiche pas
```bash
# Vérifier que Starship est installé
which starship

# Réinstaller si nécessaire
curl -sS https://starship.rs/install.sh | sh
```

### WezTerm ne trouve pas la config
```bash
# Vérifier le symlink
ls -la ~/.config/wezterm/wezterm.lua

# Recréer si nécessaire
ln -sf ~/dotfiles/wezterm/wezterm.lua ~/.config/wezterm/wezterm.lua
```

### Helix : LSP ne fonctionne pas
```bash
# Installer les language servers nécessaires
# Exemple pour Rust :
rustup component add rust-analyzer

# Exemple pour Python :
pip install python-lsp-server
```

## 📚 Ressources

- [WezTerm Documentation](https://wezfurlong.org/wezterm/)
- [Starship Documentation](https://starship.rs/)
- [Helix Documentation](https://docs.helix-editor.com/)
- [Zsh Documentation](https://zsh.sourceforge.io/Doc/)

## 📝 Notes

- Les anciennes configurations (Kitty, Neovim, Oh My Posh) sont dans le dossier `Old/`
- La police JetBrains Mono Nerd Font est requise pour l'affichage des icônes
- Zsh est conservé car Starship est un prompt, pas un shell

## 🤝 Contribution

N'hésitez pas à proposer des améliorations via des pull requests !

## 📄 Licence

Configuration personnelle - Utilisez librement et adaptez à vos besoins.
