#!/bin/bash
# Rode no KONSOLE (sessao Plasma).
# Testa aurorae WhiteSurLiquid com BORDA MINIMA (NoSideBorder) p/ corrigir
# o offset dos botoes no Wayland. Se os botoes ficarem em escala e dentro da
# janela, esse e o visual macOS desejado (traffic-lights coloridos).
set -e
export DISPLAY=:0

echo "=== Decoracao aurorae WhiteSurLiquid + borda minima ==="
kwriteconfig6 --file kwinrc --group org.kde.kdecoration2 --key library org.kde.kwin.aurorae
kwriteconfig6 --file kwinrc --group org.kde.kdecoration2 --key theme __aurorae__svg__WhiteSurLiquid-dark
kwriteconfig6 --file kwinrc --group org.kde.kdecoration2 --key BorderSize NoSideBorder

echo "=== Colorscheme WhiteSur-dark ==="
kwriteconfig6 --file kdeglobals --group General --key ColorScheme WhiteSur-dark
kwriteconfig6 --file kdeglobals --group KDE --key ColorScheme WhiteSur-dark

echo "=== Icones + cursor + kvantum ==="
kwriteconfig6 --file kdeglobals --group Icons --key Theme WhiteSur-Dark
kwriteconfig6 --file kdeglobals --group Icons --key cursorTheme WhiteSur-cursors
kwriteconfig6 --file kvantum.kvconfig --group General --key theme WhiteSur

echo "=== Reiniciar KWin + Plasma ==="
kwin --replace &>/dev/null &
sleep 2
kquitapp6 plasmashell 2>/dev/null; sleep 2
plasmashell --replace &>/dev/null &

echo "TESTE: abra uma janela. Os botoes (vermelho/amarelo/verde) estao DENTRO da"
echo "janela e em escala? Se SIM, pronto. Se NAO, rode: bash ~/apply-breeze.sh"
