#!/usr/bin/env bash
# ==============================================================================
# themes/firefox/install-firefox-theme.sh — DevSpace Cosmic Firefox Theme
# ==============================================================================
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
DOTFILES="$ROOT_DIR/dotfiles/firefox"

echo "🦊 Aplicando Tema DevSpace Cósmico no Firefox..."

# Detectar diretório do Firefox conforme SO
if [ "$(uname -s)" = "Darwin" ]; then
    FF_DIR="$HOME/Library/Application Support/Firefox"
elif [ -d "$APPDATA/Mozilla/Firefox" ]; then
    FF_DIR="$APPDATA/Mozilla/Firefox"
else
    FF_DIR="$HOME/.mozilla/firefox"
fi

if [ ! -d "$FF_DIR" ]; then
    echo "  ⚠️ Firefox não encontrado em $FF_DIR. Abra o Firefox uma vez para criar o perfil."
    exit 0
fi

# Aplicar em todos os perfis existentes
count=0
for profile in "$FF_DIR"/*.default* "$FF_DIR"/*.default-esr "$FF_DIR"/Profiles/*; do
    if [ -d "$profile" ]; then
        echo "  Configurando perfil: $(basename "$profile")"
        mkdir -p "$profile/chrome"
        cp -f "$DOTFILES/userChrome.css" "$profile/chrome/"
        cp -f "$DOTFILES/userContent.css" "$profile/chrome/"
        cp -f "$DOTFILES/user.js" "$profile/"
        count=$((count + 1))
    fi
done

# Limpar caches de startup
rm -rf "$HOME/.cache/mozilla/firefox/"*/startupCache 2>/dev/null || true

echo "✔ Tema do Firefox aplicado a $count perfil(is)! Reinicie o Firefox para carregar."
