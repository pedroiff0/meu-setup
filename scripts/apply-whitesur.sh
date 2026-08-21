#!/usr/bin/env bash
# apply-whitesur.sh — aplica (ou reaplica) a aparência WhiteSur/macOS no XFCE
# RODE JÁ LOGADO NA SESSÃO XFCE (precisa do xfconfd / DBUS da sessão).
set -e

THEME="WhiteSur-Dark"
ICONS="WhiteSur-Dark"
CURSOR="WhiteSur-cursors"

echo "==> Aplicando tema WhiteSur (GTK/ícones/cursor)..."
xfconf-query -c xsettings -p /Net/ThemeName      -s "$THEME"  2>/dev/null || true
xfconf-query -c xsettings -p /Net/IconThemeName  -s "$ICONS"  2>/dev/null || true
xfconf-query -c xsettings -p /Gtk/CursorThemeName -s "$CURSOR" 2>/dev/null || true
xfconf-query -c xsettings -p /Gtk/CursorThemeSize -s 24        2>/dev/null || true
xfconf-query -c xsettings -p /Gtk/FontName       -s "Inter 10" 2>/dev/null || true
xfconf-query -c xsettings -p /Gtk/MonospaceFontName -s "JetBrains Mono 10" 2>/dev/null || true
xfconf-query -c xsettings -p /Xft/Antialias      -s 1         2>/dev/null || true
xfconf-query -c xsettings -p /Xft/Hinting        -s 1         2>/dev/null || true
xfconf-query -c xsettings -p /Xft/HintStyle      -s "hintslight" 2>/dev/null || true
xfconf-query -c xsettings -p /Xft/RGBA           -s "rgb"     2>/dev/null || true
xfconf-query -c xsettings -p /Gtk/DecorationLayout -s "close,minimize,maximize:menu" 2>/dev/null || true

echo "==> Tema de janela xfwm4 = $THEME (botões à esquerda, estilo Mac)..."
xfconf-query -c xfwm4 -p /general/theme         -s "$THEME"   2>/dev/null || true
xfconf-query -c xfwm4 -p /general/button_layout -s "CHM|"     2>/dev/null || true
xfconf-query -c xfwm4 -p /general/use_compositing -s true     2>/dev/null || true
xfconf-query -c xfwm4 -p /general/title_alignment -s "center" 2>/dev/null || true

echo "==> Dock (Plank)..."
# Garante autostart
mkdir -p ~/.config/autostart
cat > ~/.config/autostart/plank.desktop <<'EOF'
[Desktop Entry]
Version=1.0
Type=Application
Name=Plank (Dock macOS)
Exec=plank
Terminal=false
X-GNOME-Autostart-enabled=true
X-XFCE-Autostart-enabled=true
EOF
# Tema do dock
mkdir -p ~/.local/share/plank/themes
[ -d ~/.themes-src/WhiteSur-gtk-theme/other/plank/theme-Dark ] && \
  cp -r ~/.themes-src/WhiteSur-gtk-theme/other/plank/theme-Dark ~/.local/share/plank/themes/WhiteSur-Dark
# Config do dock
mkdir -p ~/.config/plank/dock1
cat > ~/.config/plank/dock1/settings <<'EOF'
[PlankDockPreferences]
DockItems=@@
Position=3
HorizonAlignment=center
ZoomEnabled=true
ZoomPercent=150
IconSize=48
Opacity=1
HideMode=1
UnhideDelay=100
ItemsAlignment=center
Theme=WhiteSur-Dark
Monitor=0
EOF
pgrep -x plank >/dev/null && ( plank >/dev/null 2>&1 & ) || true

echo "==> Wallpaper Big Sur..."
WP="$HOME/Pictures/WhiteSur-BigSur.png"
[ -f "$WP" ] || cp -f ~/.themes-src/WhiteSur-gtk-theme/src/assets/gnome-shell/backgrounds/background-default.png "$WP"
for p in $(xfconf-query -c xfce4-desktop -l 2>/dev/null | grep -i last-image); do
  xfconf-query -c xfce4-desktop -p "$p" -s "$WP" 2>/dev/null || true
done

echo
echo "PRONTO. Faca logout e login (ou reinicie o painel: xfce4-panel -r) para ver tudo."
echo "Dica: arraste apps pro dock com botao direito > 'Keep in Dock'."
