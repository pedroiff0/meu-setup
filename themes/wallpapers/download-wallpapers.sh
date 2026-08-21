#!/usr/bin/env bash
# ==============================================================================
# themes/wallpapers/download-wallpapers.sh — Wallpapers Cósmicos e WhiteSur
# ==============================================================================
set -euo pipefail

DEST_DIR="$HOME/Pictures/Wallpapers"
mkdir -p "$DEST_DIR"

echo "🖼️  Baixando wallpapers de alta resolução para $DEST_DIR..."

# Big Sur 5K Wallpaper
if [ ! -f "$DEST_DIR/BigSur-5K.jpg" ]; then
    curl -fsSL "https://raw.githubusercontent.com/vinceliuice/WhiteSur-wallpapers/main/4k/WhiteSur-light.png" -o "$DEST_DIR/BigSur-5K.png" 2>/dev/null || true
fi

# DevSpace Gradient Wallpaper
if [ -f "$(dirname "${BASH_SOURCE[0]}")/../../macos/devspace/devspace-gradiente.png" ]; then
    cp -f "$(dirname "${BASH_SOURCE[0]}")/../../macos/devspace/devspace-gradiente.png" "$DEST_DIR/DevSpace-Gradient.png"
fi

echo "✔ Wallpapers prontos em $DEST_DIR!"
