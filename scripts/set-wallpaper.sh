#!/bin/bash
# Define o wallpaper WhiteSur (Big Sur) no XFCE via xfconf-query
# Uso: bash ~/set-wallpaper.sh  (ou rode já logado)
WP="$HOME/Pictures/WhiteSur-BigSur.png"
mkdir -p "$(dirname "$WP")"
cp -f ~/.themes-src/WhiteSur-gtk-theme/src/assets/gnome-shell/backgrounds/background-default.png "$WP"
if command -v xfconf-query >/dev/null 2>&1 && [ -n "$DBUS_SESSION_BUS_ADDRESS" ]; then
  for prop in $(xfconf-query -c xfce4-desktop -l 2>/dev/null | grep -i 'last-image'); do
    xfconf-query -c xfce4-desktop -p "$prop" -s "$WP" 2>/dev/null
  done
  for prop in $(xfconf-query -c xfce4-desktop -l 2>/dev/null | grep -i 'color-style'); do
    xfconf-query -c xfce4-desktop -p "$prop" -s 0 2>/dev/null
  done
  echo "Wallpaper aplicado via xfconf: $WP"
else
  echo "DBUS/xfconf indisponível agora. O wallpaper sera aplicado no proximo login pelo apply-whitesur.sh."
fi
