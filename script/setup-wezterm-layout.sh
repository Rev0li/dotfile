#!/usr/bin/env bash
# ═══════════════════════════════════════════════════════════
# ⌨️  Shortcut GNOME : Super+E → WezTerm avec layout
# ═══════════════════════════════════════════════════════════

set -euo pipefail

# ── Couleurs ────────────────────────────────────────────────
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
CYAN='\033[0;36m'
BOLD='\033[1m'
BLUE='\033[0;34m'
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

# ═══════════════════════════════════════════════════════════
# 🔍 Vérifications
# ═══════════════════════════════════════════════════════════

print_header "Vérification de l'environnement"

# GNOME requis
if ! command -v gsettings &>/dev/null; then
    err "gsettings introuvable — ce script nécessite un bureau GNOME"
    exit 1
fi
ok "GNOME détecté"

# Trouver le binaire wezterm
WEZTERM_BIN=""
for candidate in \
    "$HOME/.local/bin/wezterm" \
    "$HOME/dotfiles/bin/wezterm" \
    "$(command -v wezterm 2>/dev/null || true)"
do
    if [ -f "$candidate" ] && [ -x "$candidate" ]; then
        WEZTERM_BIN="$candidate"
        break
    fi
done

if [ -z "$WEZTERM_BIN" ]; then
    err "Binaire wezterm introuvable"
    echo -e "    ${CYAN}→${NC} Lancer d'abord : ./install.sh"
    exit 1
fi
ok "wezterm trouvé : $WEZTERM_BIN"

# ═══════════════════════════════════════════════════════════
# 🛠️ Créer le wrapper de démarrage
# ═══════════════════════════════════════════════════════════

print_header "Création du wrapper de démarrage"

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/dotfiles}"
WRAPPER_SCRIPT="$DOTFILES_DIR/script/wezterm-launcher.sh"

mkdir -p "$(dirname "$WRAPPER_SCRIPT")"

cat > "$WRAPPER_SCRIPT" << 'EOF'
#!/usr/bin/env bash
# Wrapper pour lancer WezTerm avec le layout
wezterm_bin="${1:-wezterm}"

# Démarrer WezTerm en fullscreen
"$wezterm_bin" start --cwd "$PWD" &
sleep 0.5

# Attendre que WezTerm se lance
sleep 1

# Créer le layout via CLI
PANES=$("$wezterm_bin" cli list-panes 2>/dev/null | wc -l)

if [ "$PANES" -gt 0 ]; then
    # Récupérer le premier pane
    PANE_ID=$("$wezterm_bin" cli list-panes 2>/dev/null | grep -oP 'pane_id=\K[0-9]+' | head -1)
    
    if [ -n "$PANE_ID" ]; then
        # Split horizontal : 60% haut / 40% bas
        "$wezterm_bin" cli split-pane --pane-id="$PANE_ID" --bottom --percent 40 2>/dev/null || true
        sleep 0.2
        
        # Récupérer le pane du bas
        PANE_BOTTOM=$("$wezterm_bin" cli list-panes 2>/dev/null | grep -oP 'pane_id=\K[0-9]+' | tail -1)
        
        # Split vertical sur le bas : 30% gauche / 70% droite
        if [ -n "$PANE_BOTTOM" ]; then
            "$wezterm_bin" cli split-pane --pane-id="$PANE_BOTTOM" --right --percent 70 2>/dev/null || true
        fi
    fi
fi
EOF

chmod +x "$WRAPPER_SCRIPT"
ok "Wrapper créé : $WRAPPER_SCRIPT"

# ═══════════════════════════════════════════════════════════
# ⌨️  Ajouter le shortcut GNOME
# ═══════════════════════════════════════════════════════════

print_header "Configuration du shortcut Super+E"

SHORTCUT_NAME="Wezterm (Layout)"
SHORTCUT_CMD="$WRAPPER_SCRIPT $WEZTERM_BIN"
SHORTCUT_KEY="<Super>e"
SHORTCUT_PATH="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/wezterm/"
SHORTCUTS_LIST_KEY="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings"

# Lire la liste actuelle des raccourcis custom
CURRENT=$(gsettings get org.gnome.settings-daemon.plugins.media-keys custom-keybindings)

# Vérifier si notre raccourci est déjà dans la liste
if echo "$CURRENT" | grep -q "wezterm"; then
    warn "Raccourci wezterm déjà présent — mise à jour..."
    NEW_LIST="$CURRENT"
else
    # Ajouter notre path à la liste existante
    if [ "$CURRENT" = "@as []" ] || [ "$CURRENT" = "[]" ]; then
        NEW_LIST="['${SHORTCUT_PATH}']"
    else
        # Insérer avant le ']' final
        NEW_LIST="${CURRENT%]}, '${SHORTCUT_PATH}']"
    fi
fi

# Appliquer la liste mise à jour
gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "$NEW_LIST"
ok "Liste des raccourcis mise à jour"

# Définir les propriétés du raccourci
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:"$SHORTCUT_PATH" \
    name    "$SHORTCUT_NAME"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:"$SHORTCUT_PATH" \
    command "$SHORTCUT_CMD"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:"$SHORTCUT_PATH" \
    binding "$SHORTCUT_KEY"

ok "Nom    : $SHORTCUT_NAME"
ok "Cmd    : $SHORTCUT_CMD"
ok "Touche : Super + E"


# ═══════════════════════════════════════════════════════════
# ✅ Résumé
# ═══════════════════════════════════════════════════════════

print_header "Configuration terminée 🎉"

echo ""
echo -e "  ${GREEN}Super + E${NC} → ouvre WezTerm avec layout automatique"
echo ""
echo -e "  ${BOLD}Layout créé :${NC}"
echo -e "    ┌─────────────────────────┐"
echo -e "    │   PANE 1 (60%)          │"
echo -e "    │   (TOP)                 │"
echo -e "    ├────────────┬────────────┤"
echo -e "    │   PANE 2   │   PANE 3   │"
echo -e "    │   (30%)    │   (70%)    │"
echo -e "    │   (BAS)    │   (BAS)    │"
echo -e "    └────────────┴────────────┘"
echo ""
echo -e "  ${YELLOW}Raccourcis :${NC}"
echo -e "    ${CYAN}Alt+c${NC} → Split horizontal"
echo -e "    ${CYAN}Alt+v${NC} → Split vertical"
echo -e "    ${CYAN}Ctrl+←↑↓→${NC} → Naviguer entre panes"
echo ""
