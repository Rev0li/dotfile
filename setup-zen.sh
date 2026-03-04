#!/usr/bin/env bash
# ═══════════════════════════════════════════════════════════
# 🌐 Zen Browser — Ajout au launcher GNOME
# ═══════════════════════════════════════════════════════════

set -euo pipefail

GREEN='\033[0;32m'; CYAN='\033[0;36m'; YELLOW='\033[1;33m'
RED='\033[0;31m'; BOLD='\033[1m'; BLUE='\033[0;34m'; NC='\033[0m'

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

ZEN_BIN="$HOME/zen/zen"
DESKTOP_DIR="$HOME/.local/share/applications"
DESKTOP_FILE="$DESKTOP_DIR/zen-browser.desktop"

print_header "Zen Browser → GNOME Launcher"

# Vérifier le binaire
if [ ! -f "$ZEN_BIN" ]; then
    err "Binaire introuvable : $ZEN_BIN"
    exit 1
fi
chmod +x "$ZEN_BIN"
ok "Binaire trouvé : $ZEN_BIN"

# Chercher une icône dans le dossier zen/
ICON_PATH=""
for candidate in \
    "$HOME/zen/browser/chrome/icons/default/default128.png" \
    "$HOME/zen/browser/icons/mozicon128.png" \
    "$HOME/zen/zen.png" \
    "$HOME/zen/icons/icon128.png"
do
    if [ -f "$candidate" ]; then
        ICON_PATH="$candidate"
        break
    fi
done

if [ -n "$ICON_PATH" ]; then
    ok "Icône trouvée : $ICON_PATH"
else
    warn "Aucune icône trouvée — icône générique utilisée"
    ICON_PATH="web-browser"
fi

# Créer le fichier .desktop
mkdir -p "$DESKTOP_DIR"

cat > "$DESKTOP_FILE" << EOF
[Desktop Entry]
Version=1.0
Name=Zen Browser
GenericName=Web Browser
Comment=Browse the web with Zen
Exec=${ZEN_BIN} %u
Icon=${ICON_PATH}
Terminal=false
Type=Application
Categories=Network;WebBrowser;
MimeType=text/html;text/xml;application/xhtml+xml;x-scheme-handler/http;x-scheme-handler/https;
StartupNotify=true
StartupWMClass=zen
EOF

ok ".desktop créé : $DESKTOP_FILE"

# Mettre à jour la base des applications GNOME
update-desktop-database "$DESKTOP_DIR" 2>/dev/null || true
ok "Base GNOME mise à jour"

# Vider la corbeille proprement
TRASH_ZEN="$HOME/.local/share/Trash/files/zen (1).linux-x86_64"
if [ -d "$TRASH_ZEN" ]; then
    rm -rf "$TRASH_ZEN"
    rm -f "$HOME/.local/share/Trash/info/zen (1).linux-x86_64.trashinfo" 2>/dev/null || true
    ok "Ancienne version supprimée de la corbeille"
fi

print_header "Terminé 🌐"

echo ""
echo -e "  ${GREEN}Zen Browser est maintenant dans tes applications GNOME${NC}"
echo ""
echo -e "  Pour l'épingler dans la barre du bas :"
echo -e "    1. Appuie sur ${CYAN}Super${NC} pour ouvrir le launcher"
echo -e "    2. Cherche ${CYAN}Zen${NC}"
echo -e "    3. Clic droit → ${CYAN}Ajouter aux favoris${NC}"
echo ""
