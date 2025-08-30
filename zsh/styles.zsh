#!/usr/bin/env zsh
# 🎨 Configuration des styles et couleurs

############################
# 🎨 Définitions des couleurs
############################

# Couleurs de base
export RESET="\033[0m"
export BOLD="\033[1m"
export DIM="\033[2m"
export ITALIC="\033[3m"
export UNDERLINE="\033[4m"

# Couleurs standards
export BLACK="\033[30m"
export RED="\033[31m"
export GREEN="\033[32m"
export YELLOW="\033[33m"
export BLUE="\033[34m"
export MAGENTA="\033[35m"
export CYAN="\033[36m"
export WHITE="\033[37m"

# Couleurs vives
export BRIGHT_BLACK="\033[90m"
export BRIGHT_RED="\033[91m"
export BRIGHT_GREEN="\033[92m"
export BRIGHT_YELLOW="\033[93m"
export BRIGHT_BLUE="\033[94m"
export BRIGHT_MAGENTA="\033[95m"
export BRIGHT_CYAN="\033[96m"
export BRIGHT_WHITE="\033[97m"

############################
# 🎨 Couleurs pour les fichiers
############################

# Configuration LS_COLORS personnalisée (couleurs plus vives)
export CUSTOM_LS_COLORS="di=1;96:fi=0;97:ln=1;93:ex=1;92:*.md=1;95:*.txt=0;94:*.json=1;91:*.py=1;92:*.js=1;93:*.sh=1;91:*.conf=1;95:*.log=0;37:*.zip=1;31:*.tar=1;31:*.gz=1;31"

# Alternative avec dossiers encore plus visibles
export BRIGHT_LS_COLORS="di=1;94:fi=0;97:ln=1;96:ex=1;92:*.md=1;95:*.txt=0;94:*.json=1;91:*.py=1;92:*.js=1;93:*.sh=1;91:*.conf=1;95:*.log=0;37:*.zip=1;31:*.tar=1;31:*.gz=1;31"

############################
# 🎨 Styles d'affichage
############################

# Style actuel (par défaut : minimal)
export DISPLAY_STYLE="${DISPLAY_STYLE:-minimal}"

############################
# 🎨 Fonctions de styles
############################

# 📊 Style Header avec bordures
function display_with_header() {
    local current_dir=$(basename "$PWD")
    local full_path="$PWD"
    local term_width=$(tput cols)
    local content
    
    # Récupérer le contenu avec couleurs personnalisées
    if command -v tree >/dev/null 2>&1; then
        content=$(LS_COLORS="$CUSTOM_LS_COLORS" tree -L 1 --dirsfirst -C -a -I '.git')
    else
        content=$(LS_COLORS="$CUSTOM_LS_COLORS" ls -lha --color=auto)
    fi
    
    clear
    
    # Calculer les dimensions adaptatives du header
    local max_content_width=80  # Largeur maximale souhaitée
    local min_header_width=50   # Largeur minimale
    
    # Adapter la taille selon le terminal et le contenu
    local desired_width=$((${#current_dir} + ${#full_path} + 20))
    if [[ $desired_width -gt $max_content_width ]]; then
        desired_width=$max_content_width
    elif [[ $desired_width -lt $min_header_width ]]; then
        desired_width=$min_header_width
    fi
    
    # S'assurer que le header rentre dans le terminal
    if [[ $desired_width -gt $((term_width - 6)) ]]; then
        desired_width=$((term_width - 6))
    fi
    
    local header_width=$desired_width
    local dir_display_width=$((header_width - 4))   # Espace pour "📁 " et bordures
    local path_display_width=$((header_width - 1 ))  # Espace pour bordures
    
    # Tronquer les textes si nécessaire
    local truncated_dir="$current_dir"
    local truncated_path="$full_path"
    
    if [[ ${#current_dir} -gt $dir_display_width ]]; then
        truncated_dir="${current_dir:0:$((dir_display_width-3))}..."
    fi
    
    if [[ ${#full_path} -gt $path_display_width ]]; then
        truncated_path="...${full_path:$((${#full_path}-path_display_width+3))}"
    fi
    
    # Centrer le header dans le terminal
    local header_padding=$(( (term_width - header_width - 2) / 2 ))
    if [[ $header_padding -lt 0 ]]; then
        header_padding=0
    fi
    
    printf "\n"
    # Ligne du haut
    printf "%*s${BRIGHT_CYAN}${BOLD}╭" $header_padding ""
    printf "═%.0s" $(seq 1 $header_width)
    printf "╮${RESET}\n"
    
    # Ligne du nom du dossier avec padding calculé
    local dir_padding=$((dir_display_width - ${#truncated_dir}))
    printf "%*s${BRIGHT_CYAN}${BOLD}│${RESET} 📁 ${BRIGHT_WHITE}${BOLD}%s${RESET}%*s${BRIGHT_CYAN}${BOLD}│${RESET}\n" \
        $header_padding "" "$truncated_dir" $dir_padding ""
    
    # Ligne du chemin avec padding calculé
    local path_padding=$((path_display_width - ${#truncated_path}))
    printf "%*s${BRIGHT_CYAN}${BOLD}│${RESET} ${DIM}%s${RESET}%*s${BRIGHT_CYAN}${BOLD}│${RESET}\n" \
        $header_padding "" "$truncated_path" $path_padding ""
    
    # Ligne du bas
    printf "%*s${BRIGHT_CYAN}${BOLD}╰" $header_padding ""
    printf "═%.0s" $(seq 1 $header_width)
    printf "╯${RESET}\n"
    printf "\n"
    
    # Contenu centré avec meilleur alignement
    while IFS= read -r line; do
        if [[ -n "$line" ]]; then
            # Nettoyer les codes couleur pour calculer la vraie longueur
            local clean_line=$(echo "$line" | sed 's/\x1b\[[0-9;]*[mK]//g')
            local line_len=${#clean_line}
            local content_padding=$(( (term_width - line_len) / 2 ))
            if [[ $content_padding -lt 0 ]]; then
                content_padding=0
            fi
            printf "%*s%s\n" $content_padding "" "$line"
        fi
    done <<< "$content"
    
    printf "\n"
}

# 🌟 Style minimaliste
function display_minimal() {
    local current_dir=$(basename "$PWD")
    local term_width=$(tput cols)
    local content
    
    if command -v tree >/dev/null 2>&1; then
        content=$(LS_COLORS="$CUSTOM_LS_COLORS" tree -L 1 --dirsfirst -C -F)
    else
        content=$(LS_COLORS="$CUSTOM_LS_COLORS" ls -1F --color=auto)
    fi
    
    clear
    
    # Header simple centré
    local header_text="📂 $current_dir"
    local header_len=${#header_text}
    local header_padding=$(( (term_width - header_len) / 2 ))
    if [[ $header_padding -lt 0 ]]; then
        header_padding=0
    fi
    
    printf "\n"
    printf "%*s${BRIGHT_BLUE}${BOLD}%s${RESET}\n" $header_padding "" "$header_text"
    
    # Chemin centré
    local path_len=${#PWD}
    local path_padding=$(( (term_width - path_len) / 2 ))
    if [[ $path_padding -lt 0 ]]; then
        path_padding=0
    fi
    printf "%*s${DIM}%s${RESET}\n\n" $path_padding "" "$PWD"
    
    # Ligne séparatrice centrée
    local separator="────────────────────────────────────────"
    local sep_len=${#separator}
    local sep_padding=$(( (term_width - sep_len) / 2 ))
    if [[ $sep_padding -lt 0 ]]; then
        sep_padding=0
    fi
    printf "%*s${DIM}%s${RESET}\n\n" $sep_padding "" "$separator"
    
    # Contenu centré avec meilleur nettoyage des codes couleur
    while IFS= read -r line; do
        if [[ -n "$line" ]]; then
            # Nettoyer tous les codes ANSI (couleurs, curseur, etc.)
            local clean_line=$(echo "$line" | sed 's/\x1b\[[0-9;]*[mK]//g')
            local line_len=${#clean_line}
            local content_padding=$(( (term_width - line_len) / 2 ))
            if [[ $content_padding -lt 0 ]]; then
                content_padding=0
            fi
            printf "%*s%s\n" $content_padding "" "$line"
        fi
    done <<< "$content"
    
    printf "\n"
}

# 🎯 Style avec statistiques
function display_with_stats() {
    local current_dir=$(basename "$PWD")
    local term_width=$(tput cols)
    local content
    local file_count=0
    local dir_count=0
    
    # Compter les fichiers et dossiers
    if [[ -r "$PWD" ]]; then
        file_count=$(find . -maxdepth 1 -type f ! -name ".*" | wc -l)
        dir_count=$(find . -maxdepth 1 -type d ! -name "." ! -name ".*" | wc -l)
    fi
    
    if command -v tree >/dev/null 2>&1; then
        content=$(LS_COLORS="$CUSTOM_LS_COLORS" tree -L 1 --dirsfirst -C)
    else
        content=$(LS_COLORS="$CUSTOM_LS_COLORS" ls -lh --color=auto)
    fi
    
    clear
    printf "\n"
    
    # En-tête avec stats centré
    local header_width=50
    local header_padding=$(( (term_width - header_width) / 2 ))
    
    printf "%*s${BRIGHT_MAGENTA}${BOLD}┌─ 📁 %-20s ─┐${RESET}\n" $header_padding "" "$current_dir"
    printf "%*s${BRIGHT_MAGENTA}│${RESET} 📊 ${YELLOW}%d fichiers${RESET} • ${CYAN}%d dossiers${RESET} %*s${BRIGHT_MAGENTA}│${RESET}\n" \
        $header_padding "" $file_count $dir_count $((28 - ${#file_count} - ${#dir_count})) ""
    printf "%*s${BRIGHT_MAGENTA}│${RESET} 📍 %-34s ${BRIGHT_MAGENTA}│${RESET}\n" $header_padding "" "${PWD:0:34}"
    printf "%*s${BRIGHT_MAGENTA}└──────────────────────────────────────────────┘${RESET}\n\n" $header_padding ""
    
    # Contenu centré
    while IFS= read -r line; do
        if [[ -n "$line" ]]; then
            local clean_line=$(echo "$line" | sed 's/\x1b\[[0-9;]*m//g')
            local line_len=${#clean_line}
            local padding=$(( (term_width - line_len) / 2 ))
            printf "%*s%s\n" $padding "" "$line"
        fi
    done <<< "$content"
    
    printf "\n"
}

# 🎨 Style avec ASCII art
function display_fancy() {
    local current_dir=$(basename "$PWD")
    local term_width=$(tput cols)
    local content
    
    if command -v tree >/dev/null 2>&1; then
        content=$(LS_COLORS="$CUSTOM_LS_COLORS" tree -L 1 --dirsfirst -C -F --charset=ascii)
    else
        content=$(LS_COLORS="$CUSTOM_LS_COLORS" ls -1F --color=auto)
    fi
    
    clear
    
    # ASCII Art Header centré
    local header_width=39
    local header_padding=$(( (term_width - header_width) / 2 ))
    
    printf "\n"
    printf "%*s${BRIGHT_YELLOW}╭─────────────────────────────────────╮${RESET}\n" $header_padding ""
    printf "%*s${BRIGHT_YELLOW}│${RESET}  🌟  ${BRIGHT_WHITE}${BOLD}%-28s${RESET}  ${BRIGHT_YELLOW}│${RESET}\n" $header_padding "" "$current_dir"
    printf "%*s${BRIGHT_YELLOW}╰─────────────────────────────────────╯${RESET}\n" $header_padding ""
    printf "\n"
    
    # Contenu avec alternance de couleurs
    local line_number=1
    while IFS= read -r line; do
        if [[ -n "$line" ]]; then
            local clean_line=$(echo "$line" | sed 's/\x1b\[[0-9;]*m//g')
            local line_len=${#clean_line}
            local padding=$(( (term_width - line_len) / 2 ))
            
            if (( line_number % 2 == 0 )); then
                printf "%*s${DIM}%s${RESET}\n" $padding "" "$line"
            else
                printf "%*s%s\n" $padding "" "$line"
            fi
            ((line_number++))
        fi
    done <<< "$content"
    
    printf "\n"
}

############################
# 🎛️  Fonctions de contrôle des styles
############################

# Fonction principale d'affichage
function display_centered() {
    case "$DISPLAY_STYLE" in
        "header")   display_with_header ;;
        "stats")    display_with_stats ;;
        "fancy")    display_fancy ;;
        "minimal"|*) display_minimal ;;
    esac
}

# Changer de style
function set_display_style() {
    case "$1" in
        "header"|"minimal"|"stats"|"fancy")
            export DISPLAY_STYLE="$1"
            echo "🎨 Style d'affichage changé vers: ${BRIGHT_CYAN}${BOLD}$1${RESET}"
            ;;
        *)
            echo "🎨 Styles disponibles:"
            echo "  ${BRIGHT_BLUE}minimal${RESET}  - Style épuré et centré"
            echo "  ${BRIGHT_CYAN}header${RESET}   - Avec bordure décorative"
            echo "  ${BRIGHT_MAGENTA}stats${RESET}    - Avec statistiques"
            echo "  ${BRIGHT_YELLOW}fancy${RESET}    - Avec ASCII art"
            echo ""
            echo "Style actuel: ${BRIGHT_GREEN}${BOLD}${DISPLAY_STYLE:-minimal}${RESET}"
            ;;
    esac
}

# Changer les couleurs des fichiers
function set_colors() {
    case "$1" in
        "bright")
            export CUSTOM_LS_COLORS="$BRIGHT_LS_COLORS"
            echo "🌈 Couleurs changées vers: ${BRIGHT_YELLOW}${BOLD}bright${RESET} (dossiers plus visibles)"
            ;;
        "normal"|"")
            export CUSTOM_LS_COLORS="di=1;96:fi=0;97:ln=1;93:ex=1;92:*.md=1;95:*.txt=0;94:*.json=1;91:*.py=1;92:*.js=1;93:*.sh=1;91:*.conf=1;95:*.log=0;37:*.zip=1;31:*.tar=1;31:*.gz=1;31"
            echo "🌈 Couleurs changées vers: ${BRIGHT_CYAN}${BOLD}normal${RESET}"
            ;;
        *)
            echo "🌈 Couleurs disponibles:"
            echo "  ${BRIGHT_CYAN}normal${RESET}  - Couleurs standards"
            echo "  ${BRIGHT_YELLOW}bright${RESET}  - Dossiers plus visibles"
            ;;
    esac
}

# Prévisualisation des styles
function preview_styles() {
    local original_style="$DISPLAY_STYLE"
    local styles=("minimal" "header" "stats" "fancy")
    
    for style in "${styles[@]}"; do
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        echo "🎨 Style: ${BRIGHT_CYAN}${BOLD}$style${RESET}"
        echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
        DISPLAY_STYLE="$style" display_centered
        echo ""
        read -k "?${DIM}Appuyez sur une touche pour continuer...${RESET}"
        clear
    done
    
    export DISPLAY_STYLE="$original_style"
    echo "🎨 Prévisualisation terminée. Style actuel: ${BRIGHT_GREEN}${BOLD}$DISPLAY_STYLE${RESET}"
}
