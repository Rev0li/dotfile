#!/usr/bin/env bash
# ═══════════════════════════════════════════════════════════
# 🩺 Script de diagnostic de l'environnement
# Vérifie que tout est correctement installé et configuré
# ═══════════════════════════════════════════════════════════

set -e

# Couleurs
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Compteurs
SUCCESS=0
WARNING=0
ERROR=0

# ═══════════════════════════════════════════════════════════
# 🛠️ Fonctions
# ═══════════════════════════════════════════════════════════

print_header() {
    echo -e "${BLUE}═══════════════════════════════════════════════${NC}"
    echo -e "${BLUE}  $1${NC}"
    echo -e "${BLUE}═══════════════════════════════════════════════${NC}"
}

check_success() {
    echo -e "${GREEN}✓${NC} $1"
    ((SUCCESS++))
}

check_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
    ((WARNING++))
}

check_error() {
    echo -e "${RED}✗${NC} $1"
    ((ERROR++))
}

check_command() {
    local cmd="$1"
    local name="$2"
    local install_hint="$3"
    
    if command -v "$cmd" >/dev/null 2>&1; then
        local version=$($cmd --version 2>&1 | head -n1)
        check_success "$name est installé ($version)"
    else
        check_error "$name n'est pas installé"
        [ -n "$install_hint" ] && echo "  → Installer: $install_hint"
    fi
}

check_symlink() {
    local link="$1"
    local name="$2"
    
    if [ -L "$link" ]; then
        local target=$(readlink -f "$link")
        check_success "$name est symlinké → $target"
    elif [ -e "$link" ]; then
        check_warning "$name existe mais n'est pas un symlink"
    else
        check_error "$name n'existe pas"
    fi
}

# ═══════════════════════════════════════════════════════════
# 🔍 Vérifications
# ═══════════════════════════════════════════════════════════

print_header "🩺 Diagnostic de l'environnement"
echo ""

# ─────────────────────────────────────────────
# 🛠️ Vérification des outils
# ─────────────────────────────────────────────

print_header "Outils installés"

check_command "starship" "Starship" "curl -sS https://starship.rs/install.sh | sh"
check_command "hx" "Helix" "Voir https://github.com/helix-editor/helix/releases"
check_command "wezterm" "WezTerm" "Voir https://github.com/wez/wezterm/releases"
check_command "zsh" "Zsh" "sudo apt install zsh"
check_command "git" "Git" "sudo apt install git"

echo ""

# ─────────────────────────────────────────────
# 🔗 Vérification des symlinks
# ─────────────────────────────────────────────

print_header "Symlinks de configuration"

check_symlink "$HOME/.zshrc" ".zshrc"
check_symlink "$HOME/.config/helix" "Helix config"
check_symlink "$HOME/.config/wezterm/wezterm.lua" "WezTerm config"

echo ""

# ─────────────────────────────────────────────
# 🔤 Vérification des fonts
# ─────────────────────────────────────────────

print_header "Nerd Fonts"

if fc-list 2>/dev/null | grep -qi "JetBrains.*Nerd"; then
    check_success "JetBrains Mono Nerd Font détectée"
else
    check_warning "JetBrains Mono Nerd Font non détectée"
    echo "  → Installer: wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/JetBrainsMono.zip"
fi

echo ""

# ─────────────────────────────────────────────
# 📁 Vérification des dossiers
# ─────────────────────────────────────────────

print_header "Structure des dossiers"

if [ -d "$HOME/dotfiles" ]; then
    check_success "Dossier dotfiles présent"
else
    check_error "Dossier dotfiles absent"
fi

if [ -d "$HOME/.local/bin" ]; then
    check_success "Dossier ~/.local/bin présent"
else
    check_warning "Dossier ~/.local/bin absent"
fi

if [ -d "$HOME/.config" ]; then
    check_success "Dossier ~/.config présent"
else
    check_error "Dossier ~/.config absent"
fi

echo ""

# ─────────────────────────────────────────────
# 🎯 Vérification du PATH
# ─────────────────────────────────────────────

print_header "Configuration du PATH"

if [[ ":$PATH:" == *":$HOME/.local/bin:"* ]]; then
    check_success "~/.local/bin dans le PATH"
else
    check_warning "~/.local/bin absent du PATH"
fi

if [[ ":$PATH:" == *":$HOME/dotfiles/bin:"* ]]; then
    check_success "~/dotfiles/bin dans le PATH"
else
    check_warning "~/dotfiles/bin absent du PATH"
fi

echo ""

# ─────────────────────────────────────────────
# 🎨 Vérification du shell
# ─────────────────────────────────────────────

print_header "Configuration du shell"

if [ "$SHELL" = "$(which zsh)" ]; then
    check_success "Zsh est le shell par défaut"
else
    check_warning "Zsh n'est pas le shell par défaut"
    echo "  → Changer: chsh -s \$(which zsh)"
fi

if [ -n "$STARSHIP_CONFIG" ]; then
    check_success "STARSHIP_CONFIG défini ($STARSHIP_CONFIG)"
else
    check_warning "STARSHIP_CONFIG non défini"
fi

echo ""

# ─────────────────────────────────────────────
# 🔧 Vérification des variables d'env
# ─────────────────────────────────────────────

print_header "Variables d'environnement"

if [ "$EDITOR" = "hx" ] || [ "$EDITOR" = "helix" ]; then
    check_success "EDITOR défini sur Helix ($EDITOR)"
else
    check_warning "EDITOR non défini ou différent ($EDITOR)"
fi

echo ""

# ═══════════════════════════════════════════════════════════
# 📊 Résumé
# ═══════════════════════════════════════════════════════════

print_header "Résumé du diagnostic"

echo ""
echo -e "${GREEN}✓ Succès:${NC}      $SUCCESS"
echo -e "${YELLOW}⚠ Avertissements:${NC} $WARNING"
echo -e "${RED}✗ Erreurs:${NC}     $ERROR"
echo ""

if [ $ERROR -eq 0 ] && [ $WARNING -eq 0 ]; then
    echo -e "${GREEN}🎉 Tout est parfaitement configuré !${NC}"
elif [ $ERROR -eq 0 ]; then
    echo -e "${YELLOW}⚠️  Configuration OK avec quelques avertissements${NC}"
else
    echo -e "${RED}❌ Problèmes détectés - vérifier les erreurs ci-dessus${NC}"
fi

echo ""

# ═══════════════════════════════════════════════════════════
# 💡 Suggestions
# ═══════════════════════════════════════════════════════════

if [ $ERROR -gt 0 ] || [ $WARNING -gt 0 ]; then
    print_header "Suggestions de correction"
    echo ""
    
    if ! command -v starship >/dev/null 2>&1; then
        echo "• Installer Starship:"
        echo "  curl -sS https://starship.rs/install.sh | sh"
        echo ""
    fi
    
    if ! command -v hx >/dev/null 2>&1; then
        echo "• Installer Helix:"
        echo "  Voir https://github.com/helix-editor/helix/releases"
        echo ""
    fi
    
    if [ ! -L "$HOME/.zshrc" ]; then
        echo "• Créer les symlinks:"
        echo "  cd ~/dotfiles && ./install.sh"
        echo ""
    fi
    
    if [ "$SHELL" != "$(which zsh)" ]; then
        echo "• Définir Zsh comme shell par défaut:"
        echo "  chsh -s \$(which zsh)"
        echo ""
    fi
fi

echo -e "${BLUE}Pour plus d'aide, voir:${NC} ~/dotfiles/README.md"
echo ""
