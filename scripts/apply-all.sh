#!/usr/bin/env bash
# ==============================================================================
# scripts/apply-all.sh — Executa toda a estilização, personalização e otimizações
# ==============================================================================
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$SCRIPT_DIR/.."

echo "=================================================="
echo "  🌌 Executando personalização completa do meu-setup  "
echo "=================================================="

echo ""
echo "==> 1/5 Aplicando Terminal e Prompt DevSpace Cósmico..."
bash "$ROOT_DIR/themes/devspace/install-devspace.sh"

echo ""
echo "==> 2/5 Aplicando Tema DevSpace Cósmico no Firefox..."
bash "$ROOT_DIR/themes/firefox/install-firefox-theme.sh"

echo ""
echo "==> 3/5 Aplicando Tema e Persistência no Tmux..."
bash "$ROOT_DIR/themes/tmux/install-tmux-theme.sh"

echo ""
echo "==> 4/5 Aplicando Otimizações de Servidor 24/7 (TCP BBR + Sysctl + Anti-Sleep)..."
bash "$ROOT_DIR/configs/power/server-24-7.sh"
bash "$ROOT_DIR/configs/network/apply-sysctl-tuning.sh"
bash "$ROOT_DIR/configs/storage/setup-docker-storage.sh"
bash "$ROOT_DIR/configs/storage/setup-fstrim.sh"

echo ""
echo "==> 5/5 Configurando Monitoramento e Telemetria..."
bash "$ROOT_DIR/configs/monitoring/setup-monitoring.sh"

echo ""
echo "=================================================="
echo "  🎉 Toda a personalização foi concluída com sucesso! "
echo "=================================================="
