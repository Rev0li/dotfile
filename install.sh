#!/usr/bin/env bash
# ═══════════════════════════════════════════════════════════
# 🚀 Script d'installation automatique des dotfiles
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
    UPDATE_CMD="sudo apt update"
elif command_exists pacman; then
    PKG_MANAGER="pacman"
    INSTALL_CMD="sudo pacman -S --noconfirm"
    UPDATE_CMD="sudo pacman -Sy"
elif command_exists dnf; then
    PKG_MANAGER="dnf"
    INSTALL_CMD="sudo dnf install -y"
    UPDATE_CMD="sudo dnf check-update"
else
    print_error "Gestionnaire de paquets non supporté"
    exit 1
fi

print_info "Gestionnaire de paquets détecté: $PKG_MANAGER"

# Mettre à jour la base de données des paquets
print_info "Mise à jour de la base de données des paquets..."
$UPDATE_CMD || true

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

# Installer ripgrep (utile pour les recherches)
if ! command_exists rg; then
    print_info "Installation de ripgrep..."
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
# 🎨 Installation de Starship
# ─────────────────────────────────────────────

print_header "Installation de Starship"

if ! command_exists starship; then
    print_info "Téléchargement et installation de Starship..."
    curl -sS https://starship.rs/install.sh | sh -s -- -y
    print_success "Starship installé"
else
    print_success "Starship déjà installé"
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
# ✏️  Installation de Helix
# ─────────────────────────────────────────────

print_header "Installation de Helix"

if ! command_exists helix && ! command_exists hx; then
    print_info "Installation de Helix..."
    if [ "$PKG_MANAGER" = "apt" ]; then
        # Pour Ubuntu/Debian, installer depuis les releases GitHub
        cd /tmp
        HELIX_VERSION=$(curl -s https://api.github.com/repos/helix-editor/helix/releases/latest | grep -Po '"tag_name": "\K.*?(?=")')
        wget -q "https://github.com/helix-editor/helix/releases/download/${HELIX_VERSION}/helix-${HELIX_VERSION}-x86_64-linux.tar.xz"
        tar -xf "helix-${HELIX_VERSION}-x86_64-linux.tar.xz"
        sudo mv "helix-${HELIX_VERSION}-x86_64-linux" /opt/helix
        sudo ln -sf /opt/helix/hx /usr/local/bin/hx
        sudo ln -sf /opt/helix/hx /usr/local/bin/helix
        rm "helix-${HELIX_VERSION}-x86_64-linux.tar.xz"
        print_success "Helix installé"
    elif [ "$PKG_MANAGER" = "pacman" ]; then
        $INSTALL_CMD helix
        print_success "Helix installé"
    elif [ "$PKG_MANAGER" = "dnf" ]; then
        sudo dnf copr enable varlad/helix -y
        $INSTALL_CMD helix
        print_success "Helix installé"
    fi
else
    print_success "Helix déjà installé"
fi

# ─────────────────────────────────────────────
# 🖥️  Installation de WezTerm
# ─────────────────────────────────────────────

print_header "Installation de WezTerm"

if ! command_exists wezterm; then
    print_info "Installation de WezTerm..."
    if [ "$PKG_MANAGER" = "apt" ]; then
        # Pour Ubuntu/Debian
        curl -fsSL https://apt.fury.io/wez/gpg.key | sudo gpg --yes --dearmor -o /usr/share/keyrings/wezterm-fury.gpg
        echo 'deb [signed-by=/usr/share/keyrings/wezterm-fury.gpg] https://apt.fury.io/wez/ * *' | sudo tee /etc/apt/sources.list.d/wezterm.list
        sudo apt update
        $INSTALL_CMD wezterm
        print_success "WezTerm installé"
    elif [ "$PKG_MANAGER" = "pacman" ]; then
        $INSTALL_CMD wezterm
        print_success "WezTerm installé"
    elif [ "$PKG_MANAGER" = "dnf" ]; then
        sudo dnf copr enable wezfurlong/wezterm-nightly -y
        $INSTALL_CMD wezterm
        print_success "WezTerm installé"
    fi
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
mkdir -p "$HOME/.config"
ln -sf "$DOTFILES_DIR/helix" "$HOME/.config/helix"
print_success "Symlink ~/.config/helix créé"

# Créer le symlink pour WezTerm
print_info "Création du symlink pour WezTerm..."
mkdir -p "$HOME/.config/wezterm"
ln -sf "$DOTFILES_DIR/wezterm/wezterm.lua" "$HOME/.config/wezterm/wezterm.lua"
print_success "Symlink ~/.config/wezterm/wezterm.lua créé"

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
echo -e "${YELLOW}Stack installée :${NC}"
echo -e "  • ${BLUE}WezTerm${NC}  - Terminal émulateur moderne"
echo -e "  • ${BLUE}Starship${NC}  - Prompt shell élégant"
echo -e "  • ${BLUE}Helix${NC}     - Éditeur de texte modal"
echo -e "  • ${BLUE}Zsh${NC}       - Shell avec configurations personnalisées"
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
