#!/usr/bin/env bash
# ==============================================================================
# Pedro Shadow Monarch OS - Profile Configuration Engine
# Gojo (Hollow Purple) + Solo Leveling + Dev + Coffee + Astronomy + Full Native Apps
# ==============================================================================

echo "🚀 Aplicando o perfil Pedro Shadow Monarch OS..."

# 1. Ativar Extensões Estáveis (Dash-to-Dock, DING, Blur-My-Shell, System Monitor, Weather, GSConnect)
gsettings set org.gnome.shell disable-user-extensions false
gsettings set org.gnome.shell enabled-extensions "[
  'dash-to-dock@micxgx.gmail.com',
  'user-theme@gnome-shell-extensions.gcampax.github.com',
  'system-monitor@gnome-shell-extensions.gcampax.github.com',
  'workspace-indicator@gnome-shell-extensions.gcampax.github.com',
  'ding@rastersoft.com',
  'openweather-extension@penguin-teal.github.io',
  'gsconnect@andyholmes.github.io',
  'blur-my-shell@aunetx'
]"

# Configurar Blur na Barra Superior (Desfoque de Vidro Fosco em Tempo Real)
gsettings set org.gnome.shell.extensions.blur-my-shell.panel blur true
gsettings set org.gnome.shell.extensions.blur-my-shell.panel customize true
gsettings set org.gnome.shell.extensions.blur-my-shell.panel static-blur false
gsettings set org.gnome.shell.extensions.blur-my-shell.panel sigma 45
gsettings set org.gnome.shell.extensions.blur-my-shell.panel brightness 0.65
gsettings set org.gnome.shell.extensions.blur-my-shell.panel override-background true
gsettings set org.gnome.shell.extensions.blur-my-shell.panel style-panel 0

# 2. Configurar Dash to Dock (Fixo na parte inferior, centralizado macOS, Roxo)
gsettings set org.gnome.shell.extensions.dash-to-dock dock-position 'BOTTOM'
gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed true
gsettings set org.gnome.shell.extensions.dash-to-dock extend-height false
gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 48
gsettings set org.gnome.shell.extensions.dash-to-dock icon-size-fixed true
gsettings set org.gnome.shell.extensions.dash-to-dock custom-background-color true
gsettings set org.gnome.shell.extensions.dash-to-dock background-color '#1a0b2e'
gsettings set org.gnome.shell.extensions.dash-to-dock transparency-mode 'FIXED'
gsettings set org.gnome.shell.extensions.dash-to-dock background-opacity 0.8
gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize-or-previews'

# 3. Aplicativos Nativos Favoritos na Dock (Master PDF Editor & Firefox)
gsettings set org.gnome.shell favorite-apps "[
  'code.desktop',
  'discord.desktop',
  'steam.desktop',
  'com.teamspeak.TeamSpeak.desktop',
  'com.slack.Slack.desktop',
  'MasterPDFEditor.desktop',
  'firefox-esr.desktop',
  'libreoffice-writer.desktop',
  'libreoffice-calc.desktop',
  'org.stellarium.Stellarium.desktop',
  'org.gnome.Terminal.desktop',
  'org.gnome.Nautilus.desktop'
]"

# 4. Teclas de Atalho Nativas Estáveis (Alt+Tab para Janelas, Win+Tab para Apps)
gsettings set org.gnome.desktop.wm.keybindings switch-windows "['<Alt>Tab']"
gsettings set org.gnome.desktop.wm.keybindings switch-windows-backward "['<Shift><Alt>Tab']"
gsettings set org.gnome.desktop.wm.keybindings switch-applications "['<Super>Tab']"
gsettings set org.gnome.desktop.wm.keybindings switch-applications-backward "['<Shift><Super>Tab']"

# 5. Barra Superior, Tema de Janelas & Faróis na Esquerda
gsettings set org.gnome.desktop.wm.preferences theme 'WhiteSur-Dark-solid-purple'
gsettings set org.gnome.desktop.wm.preferences button-layout 'close,minimize,maximize:'
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'

# 6. Tema WhiteSur Dark Purple & GTK Settings
gsettings set org.gnome.shell.extensions.user-theme name 'WhiteSur-Dark-solid-purple'
gsettings set org.gnome.desktop.interface gtk-theme 'WhiteSur-Dark-solid-purple'
gsettings set org.gnome.desktop.interface icon-theme 'WhiteSur-purple-dark'
gsettings set org.gnome.desktop.interface cursor-theme 'WhiteSur-cursors'

# 7. Tipografia Dev & Relógio 24h
gsettings set org.gnome.desktop.interface font-name 'Inter 11'
gsettings set org.gnome.desktop.interface monospace-font-name 'JetBrains Mono 11'
gsettings set org.gnome.desktop.interface clock-format '24h'
gsettings set org.gnome.desktop.interface clock-show-date true
gsettings set org.gnome.desktop.interface clock-show-weekday true

# 8. Terminal macOS Style Profile & Tmux Live Update
PROFILE="org.gnome.Terminal.Legacy.Profile:/org/gnome/terminal/legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9/"
gsettings set org.gnome.Terminal.Legacy.Settings default-show-menubar false 2>/dev/null
gsettings set org.gnome.Terminal.Legacy.Settings headerbar true 2>/dev/null
gsettings set "$PROFILE" use-theme-colors false 2>/dev/null
gsettings set "$PROFILE" background-color 'rgb(18,13,34)' 2>/dev/null
gsettings set "$PROFILE" foreground-color 'rgb(241,245,249)' 2>/dev/null
gsettings set "$PROFILE" scrollbar-policy 'never' 2>/dev/null
gsettings set "$PROFILE" use-system-font false 2>/dev/null
gsettings set "$PROFILE" font 'JetBrains Mono 11' 2>/dev/null

tmux set -g window-style 'bg=#120d22,fg=#f1f5f9' 2>/dev/null
tmux set -g window-active-style 'bg=#120d22,fg=#f1f5f9' 2>/dev/null
tmux set -g status-style 'bg=#1e1b34,fg=#b9b3d6' 2>/dev/null

# 9. Wallpaper Shadow Purple 1080p Nativo
WALLPAPER_1080="file:///home/pedro/Imagens/shadow_purple_dev_cosmos_wallpaper_1080p.png"
gsettings set org.gnome.desktop.background picture-uri "$WALLPAPER_1080"
gsettings set org.gnome.desktop.background picture-uri-dark "$WALLPAPER_1080"
gsettings set org.gnome.desktop.background picture-options 'zoom'
gsettings set org.gnome.desktop.screensaver picture-uri "$WALLPAPER_1080"
gsettings set org.gnome.desktop.screensaver picture-options 'zoom'
gsettings set org.gnome.desktop.screensaver lock-enabled true

# 10. Limpar janelas fantasmas do autostart
rm -f ~/.config/autostart/plank.desktop ~/.config/autostart/conky.desktop 2>/dev/null
pkill -9 plank 2>/dev/null || true
pkill -9 conky 2>/dev/null || true

# 11. Ícones alinhados à esquerda (Top-Left)
gsettings set org.gnome.shell.extensions.ding start-corner 'top-left'
gsettings set org.gnome.shell.extensions.ding arrangeorder 'NAME'
pkill -f ding.js 2>/dev/null

echo "✅ Perfil Pedro Shadow Monarch OS aplicado com sucesso!"
