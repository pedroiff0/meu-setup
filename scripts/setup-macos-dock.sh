#!/bin/bash
# Rode DENTRO de uma sessao Plasma (apos logar no KDE).
# Transforma o painel inferior em dock estilo macOS (so icones, blur, centro).
set -e
export DISPLAY=:0.0

echo "=== Aplicar global theme WhiteSur-dark ==="
lookandfeeltool -a com.github.vinceliuice.WhiteSur-dark 2>&1 | tail -3 || true

echo "=== Aplicar window decoration (aurorae WhiteSur-dark) ==="
kwriteconfig6 --file kwinrc --group org.kde.kdecoration2 --key DecoratioTheme WhiteSur-dark 2>/dev/null || true
kwriteconfig6 --file kwinrc --group org.kde.kdecoration2 --key library org.kde.kwin.aurorae 2>/dev/null || true
kwriteconfig6 --file kwinrc --group org.kde.kdecoration2 --key theme __aurorae__svg__WhiteSur-dark 2>/dev/null || true

echo "=== Ativar blur no KWin ==="
kwriteconfig6 --file kwinrc --group Plugins --key blurEnabled true 2>/dev/null || true
kwriteconfig6 --file kwinrc --group Effect-Blur --key enabled true 2>/dev/null || true

echo "=== Kvantum WhiteSur ==="
kwriteconfig6 --file kvantum.kvconfig --group General --key theme WhiteSur 2>/dev/null || true

echo "=== Reiniciar KWin p/ aplicar blur/decoration ==="
kwin --replace &>/dev/null &

echo "PRONTO. Faca logout/login ou rode 'plasmashell --replace' para o dock."
echo "Para o dock: botao direito no painel > 'Editar painel' > 'Mostrar so icones' + posicao inferior + ativar desfoque."
