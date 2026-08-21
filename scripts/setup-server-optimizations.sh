#!/usr/bin/env bash
# ==============================================================================
# Aplica otimizações de Servidor 24/7 (TCP BBR, Anti-Sleep e Docker Data-Root)
# ==============================================================================
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DOTFILES="$ROOT_DIR/dotfiles/sysctl"

echo "==> 1. Desativando suspensão automática (24/7 Server Mode)..."
sudo systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target 2>/dev/null || true
if command -v gsettings >/dev/null 2>&1; then
    gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-type 'nothing' 2>/dev/null || true
    gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-timeout 0 2>/dev/null || true
    gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type 'nothing' 2>/dev/null || true
    gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-timeout 0 2>/dev/null || true
fi

echo "==> 2. Habilitando TCP BBR e Fair Queuing (FQ)..."
sudo modprobe tcp_bbr 2>/dev/null || true
sudo cp -f "$DOTFILES/99-bbr.conf" /etc/sysctl.d/99-bbr.conf 2>/dev/null || true
sudo /sbin/sysctl --system 2>/dev/null || true

echo "==> 3. Configurando Docker Data-Root para /home/docker-data..."
if [ -d /etc/docker ]; then
    sudo mkdir -p /home/docker-data
    if [ ! -f /etc/docker/daemon.json ]; then
        echo '{"data-root": "/home/docker-data"}' | sudo tee /etc/docker/daemon.json >/dev/null
    fi
fi

echo "[OK] Otimizações de servidor 24/7 aplicadas!"
