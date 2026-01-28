#!/bin/bash

OPCIONES="⏻  Apagar\n󰑐  Reiniciar\n󰤄  Suspender\n󰗼  Cerrar Sesión"

SELECCION=$(printf "%b" "$OPCIONES" | \
    fuzzel --dmenu -p "Menú de Energía: " --width 20 --lines 4 --anchor center) || exit 0

[ -z "$SELECCION" ] && exit 0

case "$SELECCION" in
    *Apagar)
        systemctl poweroff
        ;;
    *Reiniciar)
        systemctl reboot
        ;;
    *Suspender)
        if command -v swaylock >/dev/null; then
            swaylock & systemctl suspend
        else
            systemctl suspend
        fi
        ;;
    *Cerrar*)
        if ! niri msg action quit 2>/dev/null; then
            loginctl terminate-session "$XDG_SESSION_ID"
        fi
        ;;
esac
