#!/bin/bash
# RESET LIMPO - rode no KONSOLE (sessao Plasma).
# Volta a decoracao para BREEZE NATIVA (padrao KDE, 100% funcional no Wayland,
# botoes normais DENTRO da janela, sem distorcao). Mantem o visual WhiteSur
# nos icones/cores/fundo, mas a barra de titulo fica na Breeze (redonda, limpa).
set -e
export DISPLAY=:0

echo "=== Decoracao: BREEZE nativa (padrao, sem aurorae) ==="
kwriteconfig6 --file kwinrc --group org.kde.kdecoration2 --key library org.kde.kwin.decoration
kwriteconfig6 --file kwinrc --group org.kde.kdecoration2 --key theme Breeze
kwriteconfig6 --file kwinrc --group org.kde.kdecoration2 --key BorderSize Normal

echo "=== Colorscheme WhiteSur-dark (barra escura, botoes claros) ==="
kwriteconfig6 --file kdeglobals --group General --key ColorScheme WhiteSur-dark
kwriteconfig6 --file kdeglobals --group KDE --key ColorScheme WhiteSur-dark

echo "=== Icones + cursor WhiteSur ==="
kwriteconfig6 --file kdeglobals --group Icons --key Theme WhiteSur-Dark
kwriteconfig6 --file kdeglobals --group Icons --key cursorTheme WhiteSur-cursors

echo "=== Kvantum WhiteSur ==="
kwriteconfig6 --file kvantum.kvconfig --group General --key theme WhiteSur

echo "=== Reiniciar KWin + Plasma ==="
kwin --replace &>/dev/null &
sleep 2
kquitapp6 plasmashell 2>/dev/null; sleep 2
plasmashell --replace &>/dev/null &

echo "RESET FEITO. Botoes normais (redondos, dentro da janela), sem distorcao."
echo "Visual WhiteSur mantido em icones/cores/fundo."
