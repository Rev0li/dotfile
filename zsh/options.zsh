#!/usr/bin/env zsh
# Options et comportements Zsh

# ── Navigation ───────────────────────────────────────────────

setopt AUTO_CD            # taper un dossier suffit pour y aller
setopt AUTO_PUSHD         # cd alimente automatiquement la pile de dirs
setopt PUSHD_IGNORE_DUPS  # pas de doublons dans la pile
setopt CDABLE_VARS        # cd vers une variable

# ── Historique ───────────────────────────────────────────────

setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS
setopt SHARE_HISTORY
setopt EXTENDED_HISTORY

# ── Complétion ───────────────────────────────────────────────

setopt AUTO_MENU
setopt COMPLETE_IN_WORD
setopt ALWAYS_TO_END
setopt MENU_COMPLETE

# Note : le hook `chpwd` (arborescence à chaque cd) est défini dans functions.zsh.

# ── Touches spéciales (Home/End/Del/Ins/PgUp/PgDn) ──────────

typeset -A key
key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Delete]="${terminfo[kdch1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"

[[ -n "${key[Home]}"     ]] && bindkey "${key[Home]}"     beginning-of-line
[[ -n "${key[End]}"      ]] && bindkey "${key[End]}"      end-of-line
bindkey "\e[H" beginning-of-line
bindkey "\e[F" end-of-line
[[ -n "${key[Insert]}"   ]] && bindkey "${key[Insert]}"   quoted-insert
[[ -n "${key[Delete]}"   ]] && bindkey "${key[Delete]}"   delete-char
[[ -n "${key[PageUp]}"   ]] && bindkey "${key[PageUp]}"   beginning-of-buffer-or-history
[[ -n "${key[PageDown]}" ]] && bindkey "${key[PageDown]}" end-of-buffer-or-history
