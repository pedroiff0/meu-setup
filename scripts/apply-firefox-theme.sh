#!/usr/bin/env bash
# ==============================================================================
# Aplica o tema DevSpace Cósmico no Mozilla Firefox (userChrome.css / user.js)
# ==============================================================================
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DOTFILES="$ROOT_DIR/dotfiles/firefox"
FF_DIR="$HOME/.mozilla/firefox"

if [ ! -d "$FF_DIR" ]; then
    echo "Firefox não encontrado em $FF_DIR. Pulando..."
    exit 0
fi

echo "==> Aplicando tema do Firefox em todos os perfis..."
for profile in "$FF_DIR"/*.default* "$FF_DIR"/*.default-esr; do
    if [ -d "$profile" ]; then
        echo "    Configurando perfil: $(basename "$profile")"
        mkdir -p "$profile/chrome"
        cp -f "$DOTFILES/userChrome.css" "$profile/chrome/"
        cp -f "$DOTFILES/userContent.css" "$profile/chrome/"
        cp -f "$DOTFILES/user.js" "$profile/"
    fi
done

# Limpar startupCache
rm -rf "$HOME/.cache/mozilla/firefox/"*/startupCache 2>/dev/null || true
echo "[OK] Tema do Firefox aplicado! Reinicie o navegador para carregar."
