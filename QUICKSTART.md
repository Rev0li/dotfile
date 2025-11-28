# ⚡ Quick Start - Installation en 5 minutes

## 🚀 Installation rapide

```bash
# 1. Cloner ou aller dans le dossier dotfiles
cd ~/dotfiles

# 2. Rendre le script exécutable
chmod +x install.sh

# 3. Lancer l'installation
./install.sh

# 4. Recharger le shell
exec zsh
```

C'est tout ! 🎉

## ✅ Vérification

Après l'installation, vérifiez que tout fonctionne :

```bash
# Vérifier Zsh
echo $SHELL
# Devrait afficher: /usr/bin/zsh ou /bin/zsh

# Vérifier Starship
starship --version

# Vérifier Helix
hx --version

# Vérifier WezTerm
wezterm --version
```

## 🎯 Premiers pas

### 1. Lancer WezTerm
```bash
wezterm
```

### 2. Tester Helix
```bash
# Tutoriel interactif (30 min)
hx --tutor

# Ouvrir un fichier
hx README.md
```

### 3. Personnaliser

Éditer les configs selon vos préférences :
- **Helix** : `hx ~/dotfiles/helix/config.toml`
- **Starship** : `hx ~/dotfiles/starship/starship.toml`
- **WezTerm** : `hx ~/dotfiles/wezterm/wezterm.lua`
- **Zsh** : `hx ~/dotfiles/zsh/aliases.zsh`

## 📝 Raccourcis essentiels

### WezTerm
- `Ctrl+Shift+|` : Split vertical
- `Ctrl+Shift+_` : Split horizontal
- `Ctrl+Shift+h/j/k/l` : Navigation entre panes
- `Ctrl+Shift+t` : Nouveau tab

### Helix
- `Space` : Menu de commandes
- `Space+f` : Ouvrir un fichier
- `Space+b` : Liste des buffers
- `:w` : Sauvegarder
- `:q` : Quitter
- `Ctrl+h/j/k/l` : Navigation entre fenêtres

## 🔧 Problèmes courants

### Starship ne s'affiche pas
```bash
# Vérifier l'installation
which starship

# Si absent, réinstaller
curl -sS https://starship.rs/install.sh | sh

# Recharger
source ~/.zshrc
```

### Police avec carrés au lieu d'icônes
```bash
# Installer JetBrains Mono Nerd Font
cd /tmp
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/JetBrainsMono.zip
unzip JetBrainsMono.zip -d ~/.local/share/fonts/
fc-cache -fv

# Configurer WezTerm pour utiliser la police
# (déjà fait dans wezterm.lua)
```

### Helix : commandes non trouvées
```bash
# Vérifier l'installation
which hx

# Si absent, réinstaller selon votre distribution
# Voir install.sh pour les commandes
```

## 📚 Ressources

- **Documentation complète** : `README.md`
- **Guide de migration** : `MIGRATION.md`
- **Helix tutorial** : `hx --tutor`
- **WezTerm docs** : https://wezfurlong.org/wezterm/
- **Starship docs** : https://starship.rs/
- **Helix docs** : https://docs.helix-editor.com/

## 💡 Conseils

1. **Prenez le temps d'apprendre Helix** - Le tutoriel interactif est excellent
2. **Personnalisez progressivement** - Commencez avec la config par défaut
3. **Explorez les thèmes** - Helix et WezTerm ont de nombreux thèmes intégrés
4. **Installez les LSP** - Pour une meilleure expérience de développement

## 🎨 Thèmes disponibles

### Helix
```bash
# Voir tous les thèmes
hx --health

# Changer le thème dans helix/config.toml
theme = "rose_pine_moon"  # ou autre
```

Thèmes populaires :
- `rose_pine_moon` (défaut)
- `catppuccin_mocha`
- `tokyonight`
- `gruvbox`
- `nord`

### WezTerm
```bash
# Voir tous les thèmes
wezterm show-keys

# Changer dans wezterm/wezterm.lua
config.color_scheme = 'rose-pine-moon'
```

## 🚀 Prochaines étapes

1. ✅ Installer les language servers pour vos langages
2. ✅ Personnaliser les aliases Zsh
3. ✅ Configurer Git avec Helix comme éditeur
4. ✅ Explorer les plugins Zsh disponibles

```bash
# Configurer Git pour utiliser Helix
git config --global core.editor "hx"
```

Bon développement ! 🎉
