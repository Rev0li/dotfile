#!/usr/bin/env bash


read -p "Nouveau nom d’onglet ? " TABNAME
[ -n "$TABNAME" ] && kitty @ set-tab-title "$TABNAME"
exec $SHELL
