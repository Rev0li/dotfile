#!/usr/bin/env bash
# ═══════════════════════════════════════════════════════════
# 🔗 Installation des dotfiles (symlinks uniquement)
# Les outils doivent être installés manuellement
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
    
    # Sauvegarder si le fichier existe et n'est pas un lien
    backup_if_exists "$target"
    
    # Supprimer le lien existant si présent
    [ -L "$target" ] && rm "$target"
    
    # Créer le symlink
    ln -sf "$source" "$target"
    print_success "Symlink créé: $(basename $target)"
}

# ═══════════════════════════════════════════════════════════
# 🔍 Vérifications
# ═══════════════════════════════════════════════════════════

print_header "Installation des dotfiles"

if [ ! -d "$DOTFILES_DIR" ]; then
    print_error "Le dossier $DOTFILES_DIR n'existe pas"
    exit 1
fi

print_success "Dossier dotfiles trouvé"

# ═══════════════════════════════════════════════════════════
# 🔗 Création des symlinks
# ═══════════════════════════════════════════════════════════

print_header "Création des symlinks"

# Créer les répertoires nécessaires
mkdir -p "$HOME/.config"
mkdir -p "$HOME/.local/bin"

# Zsh
create_symlink "$DOTFILES_DIR/zsh/custom_zshrc.zsh" "$HOME/.zshrc"

# Helix
create_symlink "$DOTFILES_DIR/helix" "$HOME/.config/helix"

# WezTerm
mkdir -p "$HOME/.config/wezterm"
create_symlink "$DOTFILES_DIR/wezterm/wezterm.lua" "$HOME/.config/wezterm/wezterm.lua"

# Starship (config pointé par la variable d'env dans zshrc)
# Pas besoin de symlink, juste que le fichier existe

# Rendre les scripts bin exécutables
chmod +x "$DOTFILES_DIR/bin/"*.sh 2>/dev/null || true

# ═══════════════════════════════════════════════════════════
# ✅ Terminé
# ═══════════════════════════════════════════════════════════

print_header "Installation terminée !"

echo ""
echo -e "${GREEN}🎉 Symlinks créés avec succès !${NC}"
echo ""
echo -e "${YELLOW}⚠️  Note importante :${NC}"
echo -e "  Les outils (Starship, Helix, WezTerm) doivent être installés séparément."
echo ""
echo -e "${YELLOW}Installation rapide des outils :${NC}"
echo ""
echo -e "${BLUE}Starship:${NC}"
echo -e "  curl -sS https://starship.rs/install.sh | sh"
echo ""
echo -e "${BLUE}Helix:${NC}"
echo -e "  # Voir https://github.com/helix-editor/helix/releases"
echo -e "  # Ubuntu/Debian: télécharger le .tar.xz et extraire dans /opt"
echo ""
echo -e "${BLUE}WezTerm:${NC}"
echo -e "  # Voir https://github.com/wez/wezterm/releases"
echo -e "  # Ubuntu: utiliser le .deb"
echo ""
echo -e "${YELLOW}Vérifier les versions installées :${NC}"
echo -e "  ${BLUE}$DOTFILES_DIR/bin/check-versions.sh${NC}"
echo ""
echo -e "${YELLOW}Prochaines étapes :${NC}"
echo -e "  1. Installer les outils manquants (voir ci-dessus)"
echo -e "  2. Recharger le shell: ${BLUE}exec zsh${NC}"
echo -e "  3. Profiter ! 🚀"
echo ""

if [ -d "$BACKUP_DIR" ]; then
    echo -e "${YELLOW}📦 Backup:${NC} $BACKUP_DIR"
    echo ""
fi
