#!/usr/bin/env bash
# ==============================================================================
# themes/whitesur/install-whitesur.sh — WhiteSur macOS Desktop Theme Installer
# ==============================================================================
set -euo pipefail

SRC_DIR="$HOME/.themes-src"
mkdir -p "$SRC_DIR"

echo "🍎 Instalando WhiteSur macOS GTK, Ícones, Cursores e Dock..."

# 1. WhiteSur GTK Theme
if [ ! -d "$SRC_DIR/WhiteSur-gtk-theme" ]; then
    echo "  Clonando WhiteSur-gtk-theme..."
    git clone --depth=1 https://github.com/vinceliuice/WhiteSur-gtk-theme.git "$SRC_DIR/WhiteSur-gtk-theme"
else
    echo "  Atualizando WhiteSur-gtk-theme..."
    git -C "$SRC_DIR/WhiteSur-gtk-theme" pull --ff-only 2>/dev/null || true
fi

# Instalar tema GTK
bash "$SRC_DIR/WhiteSur-gtk-theme/install.sh" -t purple -c Dark -N glassy --round 2>/dev/null || \
bash "$SRC_DIR/WhiteSur-gtk-theme/install.sh" -c Dark 2>/dev/null || true

# 2. WhiteSur Icon Theme
if [ ! -d "$SRC_DIR/WhiteSur-icon-theme" ]; then
    echo "  Clonando WhiteSur-icon-theme..."
    git clone --depth=1 https://github.com/vinceliuice/WhiteSur-icon-theme.git "$SRC_DIR/WhiteSur-icon-theme"
else
    echo "  Atualizando WhiteSur-icon-theme..."
    git -C "$SRC_DIR/WhiteSur-icon-theme" pull --ff-only 2>/dev/null || true
fi

bash "$SRC_DIR/WhiteSur-icon-theme/install.sh" -t purple -a 2>/dev/null || \
bash "$SRC_DIR/WhiteSur-icon-theme/install.sh" 2>/dev/null || true

# 3. WhiteSur Cursors
if [ ! -d "$SRC_DIR/WhiteSur-cursors" ]; then
    echo "  Clonando WhiteSur-cursors..."
    git clone --depth=1 https://github.com/vinceliuice/WhiteSur-cursors.git "$SRC_DIR/WhiteSur-cursors"
else
    echo "  Atualizando WhiteSur-cursors..."
    git -C "$SRC_DIR/WhiteSur-cursors" pull --ff-only 2>/dev/null || true
fi

bash "$SRC_DIR/WhiteSur-cursors/install.sh" 2>/dev/null || true

# 4. WhiteSur Wallpapers
if [ -f "$SRC_DIR/WhiteSur-gtk-theme/src/assets/gnome-shell/backgrounds/background-default.png" ]; then
    mkdir -p "$HOME/Pictures"
    cp -f "$SRC_DIR/WhiteSur-gtk-theme/src/assets/gnome-shell/backgrounds/background-default.png" "$HOME/Pictures/WhiteSur-BigSur.png"
fi

# 5. Aplicar no XFCE se presente
if command -v xfconf-query >/dev/null 2>&1; then
    echo "  Aplicando no ambiente XFCE..."
    xfconf-query -c xsettings -p /Net/ThemeName -s "WhiteSur-Dark" 2>/dev/null || true
    xfconf-query -c xsettings -p /Net/IconThemeName -s "WhiteSur-Dark" 2>/dev/null || true
    xfconf-query -c xsettings -p /Gtk/CursorThemeName -s "WhiteSur-cursors" 2>/dev/null || true
    xfconf-query -c xfwm4 -p /general/theme -s "WhiteSur-Dark" 2>/dev/null || true
    xfconf-query -c xfwm4 -p /general/button_layout -s "CHM|" 2>/dev/null || true
fi

# 6. Aplicar no GNOME se presente
if command -v gsettings >/dev/null 2>&1; then
    echo "  Aplicando no ambiente GNOME..."
    gsettings set org.gnome.desktop.interface gtk-theme "WhiteSur-Dark" 2>/dev/null || true
    gsettings set org.gnome.desktop.interface icon-theme "WhiteSur-Dark" 2>/dev/null || true
    gsettings set org.gnome.desktop.interface cursor-theme "WhiteSur-cursors" 2>/dev/null || true
    gsettings set org.gnome.desktop.wm.preferences button-layout "close,minimize,maximize:" 2>/dev/null || true
fi

echo "✔ Tema WhiteSur instalado e aplicado!"
