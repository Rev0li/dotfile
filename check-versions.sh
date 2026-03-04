#!/usr/bin/env bash
# ═══════════════════════════════════════════════════════════
# 🔍 Vérificateur de versions des outils
# Compare les versions installées avec les dernières releases
# ═══════════════════════════════════════════════════════════

set -e

# Couleurs
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

# ═══════════════════════════════════════════════════════════
# 📦 Configuration des projets
# ═══════════════════════════════════════════════════════════

declare -A PROJECTS=(
    ["starship"]="starship-rs/starship"
    ["helix"]="helix-editor/helix"
    ["wezterm"]="wez/wezterm"
)

declare -A RELEASE_URLS=(
    ["starship"]="https://github.com/starship-rs/starship/releases"
    ["helix"]="https://github.com/helix-editor/helix/releases"
    ["wezterm"]="https://github.com/wez/wezterm/releases"
)

# ═══════════════════════════════════════════════════════════
# 🛠️ Fonctions utilitaires
# ═══════════════════════════════════════════════════════════

print_header() {
    echo -e "${BLUE}═══════════════════════════════════════════════${NC}"
    echo -e "${BLUE}  $1${NC}"
    echo -e "${BLUE}═══════════════════════════════════════════════${NC}"
}

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}⚠${NC} $1"
}

print_info() {
    echo -e "${CYAN}→${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

# Récupérer la dernière version depuis GitHub
get_latest_version() {
    local repo="$1"
    local version=$(curl -s "https://api.github.com/repos/${repo}/releases/latest" | grep -Po '"tag_name": "\K.*?(?=")')
    echo "$version"
}

# Récupérer la version installée
get_installed_version() {
    local tool="$1"
    
    case "$tool" in
        "starship")
            if command -v starship >/dev/null 2>&1; then
                starship --version | grep -oP 'v[\d.]+'
            else
                echo "non installé"
            fi
            ;;
        "helix")
            if command -v hx >/dev/null 2>&1; then
                hx --version | grep -oP 'helix \K[\d.]+'
            else
                echo "non installé"
            fi
            ;;
        "wezterm")
            if command -v wezterm >/dev/null 2>&1; then
                wezterm --version | grep -oP '\d+\.\d+\.\d+'
            else
                echo "non installé"
            fi
            ;;
    esac
}

# Comparer les versions
compare_versions() {
    local installed="$1"
    local latest="$2"
    
    if [[ "$installed" == "non installé" ]]; then
        echo "missing"
    elif [[ "$installed" == "$latest" ]]; then
        echo "up-to-date"
    else
        echo "outdated"
    fi
}

# ═══════════════════════════════════════════════════════════
# 🔍 Vérification des versions
# ═══════════════════════════════════════════════════════════

print_header "Vérification des versions"
echo ""

for tool in "${!PROJECTS[@]}"; do
    local repo="${PROJECTS[$tool]}"
    local release_url="${RELEASE_URLS[$tool]}"
    
    print_info "Vérification de ${tool}..."
    
    # Récupérer les versions
    local installed=$(get_installed_version "$tool")
    local latest=$(get_latest_version "$repo")
    
    # Comparer
    local status=$(compare_versions "$installed" "$latest")
    
    # Affichage
    echo -e "  Installé : ${CYAN}${installed}${NC}"
    echo -e "  Dernière : ${CYAN}${latest}${NC}"
    
    case "$status" in
        "up-to-date")
            print_success "${tool} est à jour !"
            ;;
        "outdated")
            print_warning "${tool} peut être mis à jour"
            echo -e "  ${BLUE}→${NC} Releases: ${release_url}"
            ;;
        "missing")
            print_error "${tool} n'est pas installé"
            echo -e "  ${BLUE}→${NC} Releases: ${release_url}"
            ;;
    esac
    
    echo ""
done

# ═══════════════════════════════════════════════════════════
# 📋 Résumé
# ═══════════════════════════════════════════════════════════

print_header "Liens utiles"
echo ""
echo -e "${BLUE}Starship:${NC}  https://github.com/starship-rs/starship/releases"
echo -e "${BLUE}Helix:${NC}     https://github.com/helix-editor/helix/releases"
echo -e "${BLUE}WezTerm:${NC}   https://github.com/wez/wezterm/releases"
echo ""
print_info "Pour installer/mettre à jour, utilise install.sh ou install_42.sh"
echo ""
