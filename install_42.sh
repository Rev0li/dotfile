#!/usr/bin/env bash
# ═══════════════════════════════════════════════════════════
# 🚀 Script d'installation pour environnement 42
# Installation sans sudo - Tout en local dans $HOME
# Stack: Wezterm + Starship + Helix + Zsh
# ═══════════════════════════════════════════════════════════

set -e  # Arrêter en cas d'erreur

# Couleurs pour l'affichage
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Variables
DOTFILES_DIR="$HOME/dotfiles"
LOCAL_BIN="$HOME/.local/bin"
LOCAL_SHARE="$HOME/.local/share"
BACKUP_DIR="$HOME/dotfiles_backup_$(date +%Y%m%d_%H%M%S)"

# ─────────────────────────────────────────────
# 📝 Fonctions utilitaires
# ─────────────────────────────────────────────

print_header() {
    echo -e "${BLUE}═══════════════════════════════════════════════${NC}"
    echo -e "${BLUE}  $1${NC}"
    echo -e "${BLUE}═══════════════════════════════════════════════${NC}"
}

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

print_info() {
    echo -e "${YELLOW}→${NC} $1"
}

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# ─────────────────────────────────────────────
# 🔍 Vérifications préalables
# ─────────────────────────────────────────────

print_header "Vérifications système (42)"

# Vérifier que le script est exécuté depuis le bon répertoire
if [ ! -f "$DOTFILES_DIR/install_42.sh" ]; then
    print_error "Ce script doit être dans $DOTFILES_DIR"
    exit 1
fi

print_success "Répertoire dotfiles trouvé"

# Créer les répertoires locaux
mkdir -p "$LOCAL_BIN"
mkdir -p "$LOCAL_SHARE"
mkdir -p "$HOME/.config"

# ─────────────────────────────────────────────
# 🎨 Installation de Starship
# ─────────────────────────────────────────────

print_header "Installation de Starship"

if ! command_exists starship; then
    print_info "Téléchargement et installation de Starship..."
    curl -sS https://starship.rs/install.sh | sh -s -- --bin-dir "$LOCAL_BIN" -y
    print_success "Starship installé dans $LOCAL_BIN"
else
    print_success "Starship déjà installé"
fi

# ─────────────────────────────────────────────
# 🔤 Installation des Nerd Fonts
# ─────────────────────────────────────────────

print_header "Installation des Nerd Fonts"

FONT_DIR="$LOCAL_SHARE/fonts"
mkdir -p "$FONT_DIR"

if [ ! -f "$FONT_DIR/JetBrainsMonoNerdFont-Regular.ttf" ]; then
    print_info "Téléchargement de JetBrains Mono Nerd Font..."
    cd /tmp
    wget -q https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/JetBrainsMono.zip
    unzip -q JetBrainsMono.zip -d "$FONT_DIR"
    rm JetBrainsMono.zip
    fc-cache -fv "$FONT_DIR" >/dev/null 2>&1 || true
    print_success "JetBrains Mono Nerd Font installé"
else
    print_success "JetBrains Mono Nerd Font déjà installé"
fi

# ─────────────────────────────────────────────
# ✏️  Installation de Helix
# ─────────────────────────────────────────────

print_header "Installation de Helix"

if ! command_exists hx && ! command_exists helix; then
    print_info "Téléchargement et installation de Helix..."
    cd /tmp
    HELIX_VERSION=$(curl -s https://api.github.com/repos/helix-editor/helix/releases/latest | grep -Po '"tag_name": "\K.*?(?=")')
    wget -q "https://github.com/helix-editor/helix/releases/download/${HELIX_VERSION}/helix-${HELIX_VERSION}-x86_64-linux.tar.xz"
    tar -xf "helix-${HELIX_VERSION}-x86_64-linux.tar.xz"
    
    # Installer dans ~/.local
    HELIX_DIR="$HOME/.local/helix"
    rm -rf "$HELIX_DIR"
    mv "helix-${HELIX_VERSION}-x86_64-linux" "$HELIX_DIR"
    
    # Créer les symlinks
    ln -sf "$HELIX_DIR/hx" "$LOCAL_BIN/hx"
    ln -sf "$HELIX_DIR/hx" "$LOCAL_BIN/helix"
    
    rm "helix-${HELIX_VERSION}-x86_64-linux.tar.xz"
    print_success "Helix installé dans $HELIX_DIR"
else
    print_success "Helix déjà installé"
fi

# ─────────────────────────────────────────────
# 🖥️  Installation de WezTerm
# ─────────────────────────────────────────────

print_header "Installation de WezTerm (portable, sans FUSE)"

if ! command_exists wezterm; then
    # Symlink
    ln -sf "$DOTFILES_DIR/wezterm/wezterm" "$LOCAL_BIN/wezterm"

    print_success "WezTerm installé en mode portable dans $DOTFILES_DIR"
else
    print_success "WezTerm déjà installé"
fi

# ─────────────────────────────────────────────
# 🔗 Création des symlinks
# ─────────────────────────────────────────────

print_header "Configuration des symlinks"

# Créer un backup si nécessaire
if [ -f "$HOME/.zshrc" ] && [ ! -L "$HOME/.zshrc" ]; then
    mkdir -p "$BACKUP_DIR"
    print_info "Sauvegarde de l'ancienne configuration dans $BACKUP_DIR"
    cp "$HOME/.zshrc" "$BACKUP_DIR/"
fi

# Créer le symlink pour Zsh
print_info "Création du symlink pour Zsh..."
ln -sf "$DOTFILES_DIR/zsh/custom_zshrc.zsh" "$HOME/.zshrc"
print_success "Symlink ~/.zshrc créé"

# Créer le symlink pour Helix
print_info "Création du symlink pour Helix..."
ln -sf "$DOTFILES_DIR/helix" "$HOME/.config/helix"
print_success "Symlink ~/.config/helix créé"

# Créer le symlink pour WezTerm
print_info "Création du symlink pour WezTerm..."
mkdir -p "$HOME/.config/wezterm"
ln -sf "$DOTFILES_DIR/wezterm/wezterm.lua" "$HOME/.config/wezterm/wezterm.lua"
print_success "Symlink ~/.config/wezterm/wezterm.lua créé"

# ─────────────────────────────────────────────
# ⚙️ Configuration du PATH
# ─────────────────────────────────────────────

print_header "Configuration du PATH"

# Vérifier si ~/.local/bin est dans le PATH
if [[ ":$PATH:" != *":$LOCAL_BIN:"* ]]; then
    print_info "Ajout de $LOCAL_BIN au PATH..."
    echo "" >> "$HOME/.zshrc"
    echo "# Ajouté par install_42.sh" >> "$HOME/.zshrc"
    echo "export PATH=\"$LOCAL_BIN:\$PATH\"" >> "$HOME/.zshrc"
    print_success "PATH mis à jour dans ~/.zshrc"
else
    print_success "$LOCAL_BIN déjà dans le PATH"
fi

# ─────────────────────────────────────────────
# ✅ Installation terminée
# ─────────────────────────────────────────────

print_header "Installation terminée !"

echo ""
echo -e "${GREEN}🎉 Tous les dotfiles sont installés avec succès !${NC}"
echo ""
echo -e "${YELLOW}Stack installée (sans sudo) :${NC}"
echo -e "  • ${BLUE}WezTerm${NC}  - Terminal émulateur (AppImage)"
echo -e "  • ${BLUE}Starship${NC}  - Prompt shell élégant"
echo -e "  • ${BLUE}Helix${NC}     - Éditeur de texte modal"
echo -e "  • ${BLUE}Zsh${NC}       - Shell avec configurations personnalisées"
echo ""
echo -e "${YELLOW}Emplacements :${NC}"
echo -e "  • Binaires:  ${BLUE}$LOCAL_BIN${NC}"
echo -e "  • Helix:     ${BLUE}$HOME/.local/helix${NC}"
echo -e "  • Fonts:     ${BLUE}$FONT_DIR${NC}"
echo ""
echo -e "${YELLOW}Prochaines étapes :${NC}"
echo -e "  1. Ferme et rouvre ton terminal (ou exécute: ${BLUE}exec zsh${NC})"
echo -e "  2. Lance WezTerm avec: ${BLUE}wezterm${NC}"
echo -e "  3. Lance Helix avec: ${BLUE}hx${NC} ou ${BLUE}helix${NC}"
echo ""
echo -e "${YELLOW}Commandes utiles :${NC}"
echo -e "  • Helix:     ${BLUE}hx <fichier>${NC}"
echo -e "  • WezTerm:   ${BLUE}wezterm${NC}"
echo -e "  • Recharger Zsh: ${BLUE}source ~/.zshrc${NC}"
echo ""
echo -e "${YELLOW}Note :${NC} Tous les outils sont installés dans $HOME/.local"
echo -e "       Aucun droit sudo n'a été nécessaire ! 🎓"
echo ""
