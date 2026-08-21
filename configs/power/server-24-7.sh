#!/usr/bin/env bash
# ==============================================================================
# configs/power/server-24-7.sh — Configurações de Energia para Servidor 24/7
# ==============================================================================
set -euo pipefail

echo "⚡ Aplicando modo Servidor 24/7 (Anti-Sleep, Sem Suspensão ou Hibernação)..."

# 1. Desativar targets de suspensão e hibernação no systemd
if command -v systemctl >/dev/null 2>&1; then
    echo "  Mascarando targets de suspensão/hibernação no systemd..."
    sudo systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target 2>/dev/null || true
fi

# 2. Desativar timeouts de suspensão no GNOME
if command -v gsettings >/dev/null 2>&1; then
    echo "  Desativando timeouts de suspensão no GNOME..."
    gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'nothing' 2>/dev/null || true
    gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-timeout 0 2>/dev/null || true
    gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type 'nothing' 2>/dev/null || true
    gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-timeout 0 2>/dev/null || true
fi

# 3. Configurar logind para ignorar fechamento da tampa (Lid Switch)
if [ -d /etc/systemd ]; then
    echo "  Configurando /etc/systemd/logind.conf.d/24-7-server.conf..."
    sudo mkdir -p /etc/systemd/logind.conf.d
    cat << 'EOF' | sudo tee /etc/systemd/logind.conf.d/24-7-server.conf >/dev/null
[Login]
HandleLidSwitch=ignore
HandleLidSwitchExternalPower=ignore
HandleLidSwitchDocked=ignore
HandleSuspendKey=ignore
HandleHibernateKey=ignore
EOF
    sudo systemctl restart systemd-logind 2>/dev/null || true
fi

echo "✔ Modo Servidor 24/7 ativo! A máquina permanecerá ligada ininterruptamente."
