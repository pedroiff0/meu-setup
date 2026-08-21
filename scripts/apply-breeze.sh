#!/bin/bash
# Rode no KONSOLE (sessao Plasma) se o aurorae continuar bugado.
# Volta para BREEZE nativa (100% em escala no Wayland, sem bug) + WhiteSur.
set -e
export DISPLAY=:0
echo "=== Breeze nativa + WhiteSur ==="
kwriteconfig6 --file kwinrc --group org.kde.kdecoration2 --key library org.kde.kwin.decoration
kwriteconfig6 --file kwinrc --group org.kde.kdecoration2 --key theme Breeze
kwriteconfig6 --file kwinrc --group org.kde.kdecoration2 --key BorderSize Normal
kwriteconfig6 --file kdeglobals --group General --key ColorScheme WhiteSur-dark
kwriteconfig6 --file kdeglobals --group KDE --key ColorScheme WhiteSur-dark
kwriteconfig6 --file kdeglobals --group Icons --key Theme WhiteSur-Dark
kwriteconfig6 --file kdeglobals --group Icons --key cursorTheme WhiteSur-cursors
kwriteconfig6 --file kvantum.kvconfig --group General --key theme WhiteSur
kwin --replace &>/dev/null & sleep 2
kquitapp6 plasmashell 2>/dev/null; sleep 2
plasmashell --replace &>/dev/null &
echo "Breeze aplicado (botoes redondos claros, estilo macOS clean, sem cores)."
