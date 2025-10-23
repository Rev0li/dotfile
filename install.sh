#!/usr/bin/env bash
# ═══════════════════════════════════════════════════════════
# 🚀 Script d'installation automatique des dotfiles
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

print_header "Vérifications système"

# Vérifier que le script est exécuté depuis le bon répertoire
if [ ! -f "$DOTFILES_DIR/install.sh" ]; then
    print_error "Ce script doit être dans $DOTFILES_DIR"
    exit 1
fi

print_success "Répertoire dotfiles trouvé"

# ─────────────────────────────────────────────
# 📦 Installation des dépendances
# ─────────────────────────────────────────────

print_header "Installation des dépendances"

# Détecter le gestionnaire de paquets
if command_exists apt; then
    PKG_MANAGER="apt"
    INSTALL_CMD="sudo apt install -y"
elif command_exists pacman; then
    PKG_MANAGER="pacman"
    INSTALL_CMD="sudo pacman -S --noconfirm"
elif command_exists dnf; then
    PKG_MANAGER="dnf"
    INSTALL_CMD="sudo dnf install -y"
else
    print_error "Gestionnaire de paquets non supporté"
    exit 1
fi

print_info "Gestionnaire de paquets détecté: $PKG_MANAGER"

# Installer Zsh si nécessaire
if ! command_exists zsh; then
    print_info "Installation de Zsh..."
    $INSTALL_CMD zsh
    print_success "Zsh installé"
else
    print_success "Zsh déjà installé"
fi

# Installer curl, wget, unzip et ripgrep si nécessaire
for cmd in curl wget unzip; do
    if ! command_exists $cmd; then
        print_info "Installation de $cmd..."
        $INSTALL_CMD $cmd
    fi
done

# Installer ripgrep (nécessaire pour Telescope live_grep)
if ! command_exists rg; then
    print_info "Installation de ripgrep (pour Telescope)..."
    if [ "$PKG_MANAGER" = "apt" ]; then
        $INSTALL_CMD ripgrep
    elif [ "$PKG_MANAGER" = "pacman" ]; then
        $INSTALL_CMD ripgrep
    elif [ "$PKG_MANAGER" = "dnf" ]; then
        $INSTALL_CMD ripgrep
    fi
    print_success "Ripgrep installé"
else
    print_success "Ripgrep déjà installé"
fi

# ─────────────────────────────────────────────
# 🎨 Installation de Oh My Posh
# ─────────────────────────────────────────────

print_header "Installation de Oh My Posh"

if ! command_exists oh-my-posh; then
    print_info "Téléchargement et installation de Oh My Posh..."
    curl -s https://ohmyposh.dev/install.sh | bash -s
    print_success "Oh My Posh installé"
else
    print_success "Oh My Posh déjà installé"
fi

# ─────────────────────────────────────────────
# 🔤 Installation des Nerd Fonts
# ─────────────────────────────────────────────

print_header "Installation des Nerd Fonts"

FONT_DIR="$HOME/.local/share/fonts"
mkdir -p "$FONT_DIR"

if [ ! -f "$FONT_DIR/JetBrainsMonoNerdFont-Regular.ttf" ]; then
    print_info "Téléchargement de JetBrains Mono Nerd Font..."
    cd /tmp
    wget -q https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/JetBrainsMono.zip
    unzip -q JetBrainsMono.zip -d "$FONT_DIR"
    rm JetBrainsMono.zip
    fc-cache -fv >/dev/null 2>&1
    print_success "JetBrains Mono Nerd Font installé"
else
    print_success "JetBrains Mono Nerd Font déjà installé"
fi

# ─────────────────────────────────────────────
# 📥 Téléchargement de Neovim
# ─────────────────────────────────────────────

print_header "Installation de Neovim"

NVIM_DIR="$DOTFILES_DIR/nvim/nvim-linux64"

if [ ! -d "$NVIM_DIR" ]; then
    print_info "Téléchargement de Neovim..."
    cd /tmp
    wget -q https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
    tar -xzf nvim-linux64.tar.gz
    mv nvim-linux64 "$DOTFILES_DIR/nvim/"
    rm nvim-linux64.tar.gz
    print_success "Neovim installé dans $NVIM_DIR"
else
    print_success "Neovim déjà présent"
fi

# ─────────────────────────────────────────────
# 🖥️ Téléchargement de Kitty
# ─────────────────────────────────────────────

print_header "Installation de Kitty"

KITTY_DIR="$DOTFILES_DIR/kitty/kitty-linux64"

if [ ! -d "$KITTY_DIR" ]; then
    print_info "Téléchargement de Kitty..."
    cd /tmp
    curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin dest=/tmp/kitty-install
    mkdir -p "$DOTFILES_DIR/kitty"
    mv /tmp/kitty-install "$KITTY_DIR"
    print_success "Kitty installé dans $KITTY_DIR"
else
    print_success "Kitty déjà présent"
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

# Créer le symlink pour Neovim
print_info "Création du symlink pour Neovim..."
mkdir -p "$HOME/.config"
ln -sf "$DOTFILES_DIR/nvim" "$HOME/.config/nvim"
print_success "Symlink ~/.config/nvim créé"

# Créer le symlink pour Kitty
print_info "Création du symlink pour Kitty..."
ln -sf "$DOTFILES_DIR/kitty/kitty.conf" "$HOME/.config/kitty/kitty.conf"
print_success "Symlink ~/.config/kitty/kitty.conf créé"

# ─────────────────────────────────────────────
# ⚙️ Configuration finale
# ─────────────────────────────────────────────

# print_header "Configuration finale"

# # Définir Zsh comme shell par défaut
# if [ "$SHELL" != "$(which zsh)" ]; then
#     print_info "Changement du shell par défaut vers Zsh..."
#     chsh -s "$(which zsh)"
#     print_success "Shell par défaut changé vers Zsh"
# else
#     print_success "Zsh est déjà le shell par défaut"
# fi

# ─────────────────────────────────────────────
# ✅ Installation terminée
# ─────────────────────────────────────────────

print_header "Installation terminée !"

echo ""
echo -e "${GREEN}🎉 Tous les dotfiles sont installés avec succès !${NC}"
echo ""
echo -e "${YELLOW}Prochaines étapes :${NC}"
echo -e "  1. Ferme et rouvre ton terminal (ou exécute: ${BLUE}exec zsh${NC})"
echo -e "  2. Lance Neovim avec: ${BLUE}nvim${NC}"
echo -e "  3. Les plugins Neovim s'installeront automatiquement"
echo ""
echo -e "${YELLOW}Commandes utiles :${NC}"
echo -e "  • Neovim:  ${BLUE}nvim${NC} ou ${BLUE}vi${NC}"
echo -e "  • Kitty:   ${BLUE}kitty${NC}"
echo -e "  • Recharger Zsh: ${BLUE}source ~/.zshrc${NC}"
echo ""
