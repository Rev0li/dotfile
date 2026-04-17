#!/usr/bin/env bash
# Aide WezTerm — affiché dans le pane bas-gauche
# Fermer avec : q

BOLD='\033[1m'
DIM='\033[2m'
CYAN='\033[36m'
PURPLE='\033[35m'
GREEN='\033[32m'
YELLOW='\033[33m'
BLUE='\033[34m'
NC='\033[0m'

line() { printf "${DIM}%s${NC}\n" "────────────────────────────────────────"; }

printf "\n"
printf "${BOLD}${PURPLE}  VISUAL MODE  ${NC}${DIM}(ESC pour entrer)${NC}\n"
line

printf "${BOLD}  Mouvement${NC}\n"
printf "  ${CYAN}h / l${NC}         ← / →  (caractère)\n"
printf "  ${CYAN}j / k${NC}         ↓ / ↑  (ligne)\n"
printf "  ${CYAN}w / b${NC}         mot suivant / précédent\n"
printf "  ${CYAN}0 / \$${NC}         début / fin de ligne\n"
printf "  ${CYAN}gg / G${NC}        haut / bas du buffer\n"
printf "  ${CYAN}CTRL+u/d${NC}      demi-page haut / bas\n"
printf "\n"
printf "${BOLD}  Sélection & actions${NC}\n"
printf "  ${CYAN}v${NC}             sélection par caractère\n"
printf "  ${CYAN}V${NC}             sélection par ligne\n"
printf "  ${CYAN}y${NC}             copier la sélection\n"
printf "  ${CYAN}x${NC}             couper la sélection\n"
printf "  ${CYAN}i${NC}             mode insert\n"

printf "\n"
printf "${BOLD}${BLUE}  SHELL CUSTOM${NC}\n"
line

printf "${BOLD}  Thème${NC}\n"
printf "  ${GREEN}dark${NC}          Tokyo Night + Rose Pine Moon\n"
printf "  ${GREEN}light${NC}         Tokyo Night Day + Rose Pine Dawn\n"
printf "  ${GREEN}theme${NC}         toggle automatique\n"
printf "\n"
printf "${BOLD}  Navigation${NC}\n"
printf "  ${GREEN}dots${NC}          cd ~/dotfiles\n"
printf "  ${GREEN}..  ...${NC}       remonter 1 / 2 niveaux\n"
printf "  ${GREEN}mkcd${NC} <dir>    créer + entrer dans un dossier\n"
printf "  ${GREEN}up${NC} <n>        remonter de n niveaux\n"
printf "\n"
printf "${BOLD}  Configs${NC}\n"
printf "  ${GREEN}helix-conf${NC}    éditer config Helix\n"
printf "  ${GREEN}wezterm-conf${NC}  éditer config WezTerm\n"
printf "  ${GREEN}starship-conf${NC} éditer config Starship\n"
printf "  ${GREEN}zsh-conf${NC}      éditer ~/.zshrc\n"
printf "  ${GREEN}src${NC}           recharger .zshrc\n"
printf "\n"
printf "${BOLD}  WezTerm panes${NC}\n"
printf "  ${YELLOW}ALT+c${NC}         split vertical (haut/bas)\n"
printf "  ${YELLOW}ALT+v${NC}         split horizontal (gauche/droite)\n"
printf "  ${YELLOW}CTRL+←↑↓→${NC}    naviguer entre panes\n"
printf "  ${YELLOW}SHIFT+ALT+←↑↓→${NC} redimensionner\n"
printf "  ${YELLOW}SUPER+e${NC}       nouvel onglet\n"
printf "  ${YELLOW}SUPER+w${NC}       fermer pane\n"
printf "  ${YELLOW}SUPER+r${NC}       renommer onglet\n"

printf "\n${DIM}  q pour fermer${NC}\n\n"
