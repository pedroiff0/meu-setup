#!/usr/bin/env bash
# ==============================================================================
# configs/network/apply-sysctl-tuning.sh — Otimizações Avançadas de Kernel e Rede
# ==============================================================================
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
DOTFILES="$ROOT_DIR/dotfiles/sysctl"

echo "⚙️  Aplicando sysctl tuning avançado (BBR, inotify, fs.file-max, swappiness)..."

sudo modprobe tcp_bbr 2>/dev/null || true

if [ -f "$DOTFILES/99-sysctl-tuning.conf" ] && [ -d /etc/sysctl.d ]; then
    sudo cp -f "$DOTFILES/99-sysctl-tuning.conf" /etc/sysctl.d/99-sysctl-tuning.conf
    sudo /sbin/sysctl --system 2>/dev/null || sudo sysctl -p /etc/sysctl.d/99-sysctl-tuning.conf 2>/dev/null || true
fi

echo "✔ Parâmetros de kernel aplicados!"
