# dotfiles

Configuration personnelle pour un environnement de développement portable —
fonctionne sur Linux, Ubuntu, et environnements sans `sudo` (42, machines partagées).

## Stack

| Outil | Rôle |
|---|---|
| **Zsh** | Shell avec config modulaire |
| **Starship** | Prompt |
| **Helix** | Éditeur |
| **WezTerm** | Terminal |
| **clangd** | LSP C/C++ |
| **mdcat** | Rendu Markdown dans le terminal |

## Installation

```bash
git clone https://github.com/ton-user/dotfiles ~/dotfiles
cd ~/dotfiles
./install.sh
```

`install.sh` s'occupe de tout :
- Vérifie les dépendances (`zsh`, `curl`, `tar`, `unzip`)
- Crée les symlinks de configuration
- Télécharge les binaires manquants dans `bin/`
- Expose les binaires dans `~/.local/bin/`

> **Sans `sudo` (42, machines partagées) :** fonctionne nativement.
> WezTerm est extrait depuis son AppImage — pas besoin de `libfuse2`.

## Structure

```
dotfiles/
├── bin/                    # Binaires téléchargés (gitignorés)
├── helix/
│   └── config.toml         # Config Helix
├── starship/
│   ├── starship-dark.toml  # Thème sombre
│   └── starship-light.toml # Thème clair
├── wezterm/
│   └── wezterm.lua         # Config WezTerm
├── zsh/
│   ├── custom_zshrc.zsh    # Point d'entrée (symlinké → ~/.zshrc)
│   ├── aliases.zsh
│   ├── exports.zsh
│   ├── functions.zsh
│   ├── options.zsh
│   ├── plugins.zsh
│   └── styles.zsh
├── install.sh              # Installeur principal
├── check-versions.sh       # Vérifie les mises à jour disponibles
├── doctor.sh               # Diagnostic de l'environnement
├── theme-toggle.sh         # Switch dark / light
├── wezterm-install.sh      # Installe WezTerm sans libfuse2
└── setup-shortcut.sh       # Raccourci GNOME Super+E → WezTerm
```

## Thèmes

Switch instantané entre dark et light — affecte WezTerm, Helix et Starship.

```bash
dark     # Tokyo Night + Rose Pine Moon
light    # Tokyo Night Day + Rose Pine Dawn
theme    # toggle automatique
```

## Aliases utiles

```bash
# Dotfiles
dots            # cd ~/dotfiles
check-versions  # vérifier les mises à jour
helix-conf      # éditer la config Helix
wezterm-conf    # éditer la config WezTerm
starship-conf   # éditer la config Starship
zsh-conf        # éditer ~/.zshrc

# Système
src             # recharger zsh
reload          # exec zsh
c               # clear
myip            # afficher l'IP publique

# Git
gs / gd / ga / gc / gp / gl / gco / gb
```

## Mise à jour des binaires

```bash
# Vérifier ce qui est obsolète
./check-versions.sh

# Forcer la mise à jour d'un outil
rm ~/dotfiles/bin/hx && ./install.sh
```

## Raccourci clavier GNOME

```bash
./setup-shortcut.sh   # Super+E → ouvre WezTerm
```
