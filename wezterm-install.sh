#!/usr/bin/env bash
# ═══════════════════════════════════════════════════════════
# 🖥️  WezTerm — Installation sans libfuse2
# Extrait l'AppImage directement dans dotfiles/bin/
# ═══════════════════════════════════════════════════════════

set -euo pipefail

# ── Couleurs ────────────────────────────────────────────────
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'

ok()   { echo -e "  ${GREEN}✓${NC} $1"; }
info() { echo -e "  ${CYAN}→${NC} $1"; }
warn() { echo -e "  ${YELLOW}⚠${NC} $1"; }
err()  { echo -e "  ${RED}✗${NC} $1"; }

print_header() {
    echo ""
    echo -e "${BOLD}${BLUE}═══════════════════════════════════════════════${NC}"
    echo -e "${BOLD}${BLUE}  $1${NC}"
    echo -e "${BOLD}${BLUE}═══════════════════════════════════════════════${NC}"
}

# ── Chemins ─────────────────────────────────────────────────
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BIN_DIR="$DOTFILES_DIR/bin"
LOCAL_BIN="$HOME/.local/bin"
WEZTERM_DIR="$BIN_DIR/wezterm-app"
WEZTERM_REPO="wez/wezterm"

# ═══════════════════════════════════════════════════════════
# 🔍 Vérifications
# ═══════════════════════════════════════════════════════════

print_header "Vérification"

# Vérifier si wezterm est déjà extrait et fonctionnel
if [ -f "$BIN_DIR/wezterm" ] && [ -x "$BIN_DIR/wezterm" ]; then
    # Tester si le binaire fonctionne vraiment (pas juste présent)
    if "$BIN_DIR/wezterm" --version &>/dev/null; then
        ok "wezterm déjà installé et fonctionnel"
        "$BIN_DIR/wezterm" --version
        echo ""
        echo -e "  ${CYAN}→${NC} Pour forcer la réinstallation :"
        echo -e "    rm -rf $BIN_DIR/wezterm $BIN_DIR/wezterm-app"
        echo -e "    $0"
        exit 0
    else
        warn "Binaire wezterm présent mais non fonctionnel — réinstallation..."
        rm -f "$BIN_DIR/wezterm" "$BIN_DIR/wezterm-gui" "$BIN_DIR/wezterm-mux-server"
        rm -rf "$WEZTERM_DIR"
    fi
fi

check_dep() {
    local cmd="$1"
    if command -v "$cmd" &>/dev/null; then
        ok "$cmd disponible"
    else
        err "$cmd manquant — sudo apt install $cmd"
        exit 1
    fi
}

check_dep "curl"

# ═══════════════════════════════════════════════════════════
# 📥 Téléchargement de l'AppImage
# ═══════════════════════════════════════════════════════════

print_header "Téléchargement de WezTerm"

info "Récupération de la dernière version..."
WEZ_VERSION=$(curl -fsSL "https://api.github.com/repos/${WEZTERM_REPO}/releases/latest" \
    | grep '"tag_name"' \
    | sed -E 's/.*"tag_name": "([^"]+)".*/\1/')

ok "Version : $WEZ_VERSION"

APPIMAGE_URL="https://github.com/${WEZTERM_REPO}/releases/download/${WEZ_VERSION}/WezTerm-${WEZ_VERSION}-Ubuntu20.04.AppImage"
APPIMAGE_TMP=$(mktemp -d)
APPIMAGE_PATH="$APPIMAGE_TMP/wezterm.AppImage"

info "Téléchargement depuis GitHub..."
curl -fsSL --progress-bar "$APPIMAGE_URL" -o "$APPIMAGE_PATH"
chmod +x "$APPIMAGE_PATH"
ok "AppImage téléchargée"

# ═══════════════════════════════════════════════════════════
# 📦 Extraction (contourne libfuse2)
# ═══════════════════════════════════════════════════════════

print_header "Extraction (sans libfuse2)"

info "Extraction de l'AppImage dans bin/wezterm-app/ ..."
info "Cela peut prendre quelques secondes..."

mkdir -p "$BIN_DIR"
cd "$APPIMAGE_TMP"

# --appimage-extract extrait le squashfs sans avoir besoin de FUSE
"$APPIMAGE_PATH" --appimage-extract > /dev/null 2>&1

# Le dossier extrait s'appelle toujours "squashfs-root"
if [ ! -d "$APPIMAGE_TMP/squashfs-root" ]; then
    err "Extraction échouée — dossier squashfs-root introuvable"
    rm -rf "$APPIMAGE_TMP"
    exit 1
fi

# Déplacer dans dotfiles/bin/wezterm-app/
rm -rf "$WEZTERM_DIR"
mv "$APPIMAGE_TMP/squashfs-root" "$WEZTERM_DIR"
ok "Extrait dans bin/wezterm-app/"

rm -rf "$APPIMAGE_TMP"

# ═══════════════════════════════════════════════════════════
# 🔗 Création des binaires dans dotfiles/bin/
# ═══════════════════════════════════════════════════════════

print_header "Exposition des binaires"

# Trouver les vrais binaires dans l'extraction
WEZTERM_REAL=$(find "$WEZTERM_DIR" -type f -name "wezterm-gui" | head -1)

if [ -z "$WEZTERM_REAL" ]; then
    err "Binaire wezterm-gui introuvable dans l'extraction"
    exit 1
fi

WEZTERM_REAL_DIR="$(dirname "$WEZTERM_REAL")"

# Wrapper principal — pointe vers wezterm-gui dans l'extraction
# On wrappe pour que le WEZTERM_APP_PATH soit toujours correct
cat > "$BIN_DIR/wezterm" << WRAPPER
#!/usr/bin/env bash
export WEZTERM_APP="${WEZTERM_DIR}"
exec "${WEZTERM_REAL_DIR}/wezterm-gui" "\$@"
WRAPPER
chmod +x "$BIN_DIR/wezterm"

# Symlink wezterm-gui et wezterm-mux-server directement
ln -sf "${WEZTERM_REAL_DIR}/wezterm-gui"        "$BIN_DIR/wezterm-gui"
ln -sf "${WEZTERM_REAL_DIR}/wezterm-mux-server" "$BIN_DIR/wezterm-mux-server"
chmod +x "$BIN_DIR/wezterm-gui" "$BIN_DIR/wezterm-mux-server"

ok "bin/wezterm          (wrapper)"
ok "bin/wezterm-gui      → $WEZTERM_REAL_DIR/wezterm-gui"
ok "bin/wezterm-mux-server → $WEZTERM_REAL_DIR/wezterm-mux-server"

# Symlinks dans ~/.local/bin/
mkdir -p "$LOCAL_BIN"
for bin_name in "wezterm" "wezterm-gui" "wezterm-mux-server"; do
    [ -L "$LOCAL_BIN/$bin_name" ] && rm "$LOCAL_BIN/$bin_name"
    ln -sf "$BIN_DIR/$bin_name" "$LOCAL_BIN/$bin_name"
    ok "~/.local/bin/$bin_name"
done

# ═══════════════════════════════════════════════════════════
# ✅ Test final
# ═══════════════════════════════════════════════════════════

print_header "Test"

if "$BIN_DIR/wezterm" --version &>/dev/null; then
    ok "wezterm fonctionne !"
    echo -e "  $("$BIN_DIR/wezterm" --version)"
else
    err "wezterm ne répond pas — vérifier les libs du système"
    exit 1
fi

# ═══════════════════════════════════════════════════════════
# ✅ Résumé
# ═══════════════════════════════════════════════════════════

print_header "Installation terminée 🖥️"

echo ""
echo -e "  ${GREEN}WezTerm $WEZ_VERSION installé sans libfuse2${NC}"
echo ""
echo -e "  Structure dans dotfiles/bin/ :"
echo -e "    ${CYAN}bin/wezterm${NC}             ← commande principale"
echo -e "    ${CYAN}bin/wezterm-app/${NC}         ← AppImage extraite (~150 Mo)"
echo ""
echo -e "  ${YELLOW}Note :${NC} Ajouter bin/wezterm-app/ à ton .gitignore"
echo -e "    ${CYAN}echo 'bin/wezterm-app/' >> $DOTFILES_DIR/.gitignore${NC}"
echo ""
echo -e "  Raccourci clavier : ${CYAN}./setup-shortcut.sh${NC}"
echo ""
