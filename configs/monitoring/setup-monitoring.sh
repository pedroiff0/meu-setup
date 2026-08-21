#!/usr/bin/env bash
# ==============================================================================
# configs/monitoring/setup-monitoring.sh — Configuração de Monitoramento & Telemetria
# ==============================================================================
set -euo pipefail

echo "📊 Configurando ferramentas de monitoramento e telemetria..."

# 1. Configurar fastfetch se instalado
mkdir -p "$HOME/.config/fastfetch"
if [ -f "$(dirname "${BASH_SOURCE[0]}")/../../dotfiles/fastfetch/config.jsonc" ]; then
    cp -f "$(dirname "${BASH_SOURCE[0]}")/../../dotfiles/fastfetch/config.jsonc" "$HOME/.config/fastfetch/"
fi

# 2. Configurar lm-sensors se instalado
if command -v sensors-detect >/dev/null 2>&1; then
    echo "  Executando detecção de sensores não interativa..."
    sudo sensors-detect --auto >/dev/null 2>&1 || true
fi

echo "✔ Utilitários de monitoramento (btop, htop, fastfetch, duf, ctop, glances) prontos!"
