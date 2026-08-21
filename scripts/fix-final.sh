#!/bin/bash
# SCRIPT DEFINITIVO - rode no KONSOLE (sessao Plasma).
# Corrige: icones (Papirus, sem bug) + decoracao Breeze nativa + WhiteSur nas cores.
set -e
export DISPLAY=:0

echo "=== 1. Icones: PAPPIRUS (completo, sem quadrados vazios) ==="
kwriteconfig6 --file kdeglobals --group Icons --key Theme Papirus
kwriteconfig6 --file kdeglobals --group Icons --key ThemeName Papirus

echo "=== 2. Decoracao: BREEZE nativa (unica que funciona no Wayland sem distorcao) ==="
kwriteconfig6 --file kwinrc --group org.kde.kdecoration2 --key library org.kde.kwin.decoration
kwriteconfig6 --file kwinrc --group org.kde.kdecoration2 --key theme Breeze
kwriteconfig6 --file kwinrc --group org.kde.kdecoration2 --key BorderSize Normal

echo "=== 3. Colorscheme WhiteSur-dark (barra escura, botoes claros/redondos) ==="
kwriteconfig6 --file kdeglobals --group General --key ColorScheme WhiteSur-dark
kwriteconfig6 --file kdeglobals --group KDE --key ColorScheme WhiteSur-dark

echo "=== 4. GTK theme WhiteSur-Dark (apps GTK: Chrome/OnlyOffice) ==="
kwriteconfig6 --file gtk-3.0/settings.ini --group Settings --key gtk-theme-name WhiteSur-Dark 2>/dev/null || true
printf '[Settings]\ngtk-theme-name=WhiteSur-Dark\n' > ~/.config/gtk-3.0/settings.ini
printf 'gtk-theme-name="WhiteSur-Dark"\ngtk-icon-theme-name="Papirus"\n' > ~/.gtkrc-2.0

echo "=== 5. Cursor + Kvantum ==="
kwriteconfig6 --file kdeglobals --group Icons --key cursorTheme WhiteSur-cursors
kwriteconfig6 --file kvantum.kvconfig --group General --key theme WhiteSur

echo "=== 6. Reiniciar PLASMA (sem mexer no KWin) ==="
kquitapp6 plasmashell 2>/dev/null; sleep 2
plasmashell --replace &>/dev/null &

echo "PRONTO. Icones Papirus (sem bug). Botoes Breeze+WhiteSur (barra escura, redondos)."
echo "Decisao sobre traffic-lights coloridos: diga se quer que eu tente compilar o Sierra."
