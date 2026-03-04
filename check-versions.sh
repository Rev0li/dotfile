#!/usr/bin/env bash
# ═══════════════════════════════════════════════════════════
# 🔍 Vérificateur de versions des outils
# Compare les versions installées avec les dernières releases
# ═══════════════════════════════════════════════════════════

set -euo pipefail

# Couleurs
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ═══════════════════════════════════════════════════════════
# 📦 Configuration des projets
# ═══════════════════════════════════════════════════════════

declare -A PROJECTS=(
    ["starship"]="starship-rs/starship"
    ["hx"]="helix-editor/helix"
    ["wezterm"]="wez/wezterm"
)

declare -A RELEASE_URLS=(
    ["starship"]="https://github.com/starship-rs/starship/releases"
    ["hx"]="https://github.com/helix-editor/helix/releases"
    ["wezterm"]="https://github.com/wez/wezterm/releases"
)

# ═══════════════════════════════════════════════════════════
# 🛠️ Fonctions utilitaires
# ═══════════════════════════════════════════════════════════

print_header() {
    echo ""
    echo -e "${BLUE}═══════════════════════════════════════════════${NC}"
    echo -e "${BLUE}  $1${NC}"
    echo -e "${BLUE}═══════════════════════════════════════════════${NC}"
}

ok()   { echo -e "${GREEN}✓${NC} $1"; }
warn() { echo -e "${YELLOW}⚠${NC} $1"; }
info() { echo -e "${CYAN}→${NC} $1"; }
err()  { echo -e "${RED}✗${NC} $1"; }

# Récupérer la dernière version depuis GitHub
get_latest_version() {
    local repo="$1"
    curl -fsSL "https://api.github.com/repos/${repo}/releases/latest" \
        | grep '"tag_name"' \
        | sed -E 's/.*"tag_name": "([^"]+)".*/\1/'
}

# Récupérer la version installée (depuis dotfiles/bin/)
get_installed_version() {
    local tool="$1"
    local bin_path="$DOTFILES_DIR/bin/$tool"

    if [ ! -f "$bin_path" ]; then
        echo "absent"
        return
    fi

    case "$tool" in
        "starship")
            "$bin_path" --version 2>/dev/null | grep -oE 'v?[0-9]+\.[0-9]+\.[0-9]+' | head -1 || echo "?"
            ;;
        "hx")
            "$bin_path" --version 2>/dev/null | grep -oE '[0-9]+\.[0-9]+(\.[0-9]+)?' | head -1 || echo "?"
            ;;
        "wezterm")
            "$bin_path" --version 2>/dev/null | grep -oE '[0-9]+\.[0-9]+\.[0-9]+' | head -1 || echo "?"
            ;;
        *)
            echo "?"
            ;;
    esac
}

# Normaliser la version pour comparaison (retirer le 'v' prefix)
normalize() {
    echo "$1" | sed 's/^v//'
}

# ═══════════════════════════════════════════════════════════
# 🔍 Vérification des versions
# ═══════════════════════════════════════════════════════════

check_tool() {
    local tool="$1"
    local repo="${PROJECTS[$tool]}"
    local release_url="${RELEASE_URLS[$tool]}"

    info "Vérification de ${tool}..."

    local installed
    installed=$(get_installed_version "$tool")

    local latest
    latest=$(get_latest_version "$repo")

    local installed_norm latest_norm
    installed_norm=$(normalize "$installed")
    latest_norm=$(normalize "$latest")

    echo -e "  Installé : ${CYAN}${installed}${NC}"
    echo -e "  Dernière : ${CYAN}${latest}${NC}"

    if [[ "$installed" == "absent" ]]; then
        err "${tool} absent de dotfiles/bin/"
        echo -e "  ${BLUE}→${NC} Lancer : ${CYAN}./install.sh${NC}"
    elif [[ "$installed_norm" == "$latest_norm" ]]; then
        ok "${tool} est à jour !"
    else
        warn "${tool} peut être mis à jour"
        echo -e "  ${BLUE}→${NC} Releases: ${release_url}"
        echo -e "  ${BLUE}→${NC} Re-lancer : ${CYAN}rm $DOTFILES_DIR/bin/$tool && ./install.sh${NC}"
    fi

    echo ""
}

print_header "Vérification des versions"

for tool in "${!PROJECTS[@]}"; do
    check_tool "$tool"
done

# ═══════════════════════════════════════════════════════════
# 📋 Résumé
# ═══════════════════════════════════════════════════════════

print_header "Liens utiles"

echo ""
echo -e "${BLUE}Starship :${NC}  https://github.com/starship-rs/starship/releases"
echo -e "${BLUE}Helix :${NC}    https://github.com/helix-editor/helix/releases"
echo -e "${BLUE}WezTerm :${NC}  https://github.com/wez/wezterm/releases"
echo ""
info "Pour mettre à jour un outil : supprimer son binaire dans bin/ puis relancer install.sh"
echo ""
