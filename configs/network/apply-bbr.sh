#!/usr/bin/env bash
# ==============================================================================
# configs/network/apply-bbr.sh — Habilita TCP BBR + Fair Queuing (FQ)
# ==============================================================================
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
DOTFILES="$ROOT_DIR/dotfiles/sysctl"

echo "🌐 Habilitando TCP BBR + Fair Queuing (FQ)..."

# 1. Carregar módulo do kernel
sudo modprobe tcp_bbr 2>/dev/null || true

# 2. Copiar arquivo sysctl
if [ -d /etc/sysctl.d ]; then
    sudo cp -f "$DOTFILES/99-bbr.conf" /etc/sysctl.d/99-bbr.conf 2>/dev/null || true
    sudo /sbin/sysctl --system 2>/dev/null || sudo sysctl -p /etc/sysctl.d/99-bbr.conf 2>/dev/null || true
fi

# 3. Validar
CURRENT_CC="$(sysctl -n net.ipv4.tcp_congestion_control 2>/dev/null || echo 'desconhecido')"
CURRENT_QD="$(sysctl -n net.core.default_qdisc 2>/dev/null || echo 'desconhecido')"

echo "  TCP Congestion Control atual: $CURRENT_CC"
echo "  Default Queueing Discipline : $CURRENT_QD"

if [ "$CURRENT_CC" = "bbr" ]; then
    echo "✔ TCP BBR ativado com sucesso!"
else
    echo "⚠️  Aviso: BBR não pôde ser ativado imediatamente (pode necessitar de reinicialização ou suporte de kernel)."
fi
