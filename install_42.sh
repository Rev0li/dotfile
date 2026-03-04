#!/usr/bin/env bash
# ═══════════════════════════════════════════════════════════
# 🔗 Installation des dotfiles pour 42 (symlinks uniquement)
# Installation locale dans $HOME/.local
# ═══════════════════════════════════════════════════════════

set -e

# Couleurs
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Variables
DOTFILES_DIR="$HOME/dotfiles"
BACKUP_DIR="$HOME/dotfiles_backup_$(date +%Y%m%d_%H%M%S)"
LOCAL_BIN="$HOME/.local/bin"

# ═══════════════════════════════════════════════════════════
# 🛠️ Fonctions
# ═══════════════════════════════════════════════════════════

print_header() {
    echo -e "${BLUE}═══════════════════════════════════════════════${NC}"
    echo -e "${BLUE}  $1${NC}"
    echo -e "${BLUE}═══════════════════════════════════════════════${NC}"
}

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_info() {
    echo -e "${YELLOW}→${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

backup_if_exists() {
    local file="$1"
    if [ -e "$file" ] && [ ! -L "$file" ]; then
        mkdir -p "$BACKUP_DIR"
        print_info "Sauvegarde: $(basename $file) → $BACKUP_DIR"
        mv "$file" "$BACKUP_DIR/"
    fi
}

create_symlink() {
    local source="$1"
    local target="$2"
    
    backup_if_exists "$target"
    [ -L "$target" ] && rm "$target"
    ln -sf "$source" "$target"
    print_success "Symlink créé: $(basename $target)"
}

# ═══════════════════════════════════════════════════════════
# 🔍 Vérifications
# ═══════════════════════════════════════════════════════════

print_header "Installation des dotfiles (42)"

if [ ! -d "$DOTFILES_DIR" ]; then
    print_error "Le dossier $DOTFILES_DIR n'existe pas"
    exit 1
fi

print_success "Dossier dotfiles trouvé"

# ═══════════════════════════════════════════════════════════
# 📁 Création des répertoires
# ═══════════════════════════════════════════════════════════

print_header "Préparation de l'environnement"

mkdir -p "$HOME/.config"
mkdir -p "$LOCAL_BIN"
mkdir -p "$HOME/.local/share/fonts"

print_success "Répertoires créés"

# ═══════════════════════════════════════════════════════════
# 🔗 Création des symlinks
# ═══════════════════════════════════════════════════════════

print_header "Création des symlinks"

# Zsh
create_symlink "$DOTFILES_DIR/zsh/custom_zshrc.zsh" "$HOME/.zshrc"

# Helix
create_symlink "$DOTFILES_DIR/helix" "$HOME/.config/helix"

# WezTerm
mkdir -p "$HOME/.config/wezterm"
create_symlink "$DOTFILES_DIR/wezterm/wezterm.lua" "$HOME/.config/wezterm/wezterm.lua"

# Rendre les scripts bin exécutables
chmod +x "$DOTFILES_DIR/bin/"*.sh 2>/dev/null || true

# ═══════════════════════════════════════════════════════════
# ⚙️ Configuration du PATH
# ═══════════════════════════════════════════════════════════

print_header "Configuration du PATH"

# Vérifier si ~/.local/bin est dans le PATH
if [[ ":$PATH:" != *":$LOCAL_BIN:"* ]]; then
    print_info "$LOCAL_BIN déjà dans le PATH via zshrc"
else
    print_success "$LOCAL_BIN dans le PATH"
fi

# ═══════════════════════════════════════════════════════════
# ✅ Terminé
# ═══════════════════════════════════════════════════════════

print_header "Installation terminée !"

echo ""
echo -e "${GREEN}🎉 Symlinks créés avec succès !${NC}"
echo ""
echo -e "${YELLOW}⚠️  Installation des outils (sans sudo) :${NC}"
echo ""
echo -e "${BLUE}Starship:${NC}"
echo -e "  curl -sS https://starship.rs/install.sh | sh -s -- --bin-dir \$HOME/.local/bin -y"
echo ""
echo -e "${BLUE}Helix:${NC}"
echo -e "  cd /tmp"
echo -e "  VERSION=\$(curl -s https://api.github.com/repos/helix-editor/helix/releases/latest | grep tag_name | cut -d'\"' -f4)"
echo -e "  wget https://github.com/helix-editor/helix/releases/download/\$VERSION/helix-\$VERSION-x86_64-linux.tar.xz"
echo -e "  tar -xf helix-\$VERSION-x86_64-linux.tar.xz"
echo -e "  mv helix-\$VERSION-x86_64-linux \$HOME/.local/helix"
echo -e "  ln -sf \$HOME/.local/helix/hx \$HOME/.local/bin/hx"
echo ""
echo -e "${BLUE}WezTerm (AppImage):${NC}"
echo -e "  cd /tmp"
echo -e "  wget https://github.com/wez/wezterm/releases/download/latest/WezTerm-latest-Ubuntu20.04.AppImage"
echo -e "  chmod +x WezTerm-latest-Ubuntu20.04.AppImage"
echo -e "  mv WezTerm-latest-Ubuntu20.04.AppImage \$HOME/.local/bin/wezterm"
echo ""
echo -e "${BLUE}Nerd Font (JetBrains Mono):${NC}"
echo -e "  cd /tmp"
echo -e "  wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/JetBrainsMono.zip"
echo -e "  unzip JetBrainsMono.zip -d \$HOME/.local/share/fonts/"
echo -e "  fc-cache -fv \$HOME/.local/share/fonts/"
echo ""
echo -e "${YELLOW}Vérifier les versions :${NC}"
echo -e "  ${BLUE}$DOTFILES_DIR/bin/check-versions.sh${NC}"
echo ""
echo -e "${YELLOW}Prochaines étapes :${NC}"
echo -e "  1. Installer les outils (voir commandes ci-dessus)"
echo -e "  2. Recharger le shell: ${BLUE}exec zsh${NC}"
echo -e "  3. Enjoy ! 🎓"
echo ""

if [ -d "$BACKUP_DIR" ]; then
    echo -e "${YELLOW}📦 Backup:${NC} $BACKUP_DIR"
    echo ""
fi
