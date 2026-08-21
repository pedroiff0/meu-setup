#!/usr/bin/env bash
# ==============================================================================
# Executa toda a estilização, personalização e otimizações do meu-setup
# ==============================================================================
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "=================================================="
echo "  Executando personalização completa do meu-setup  "
echo "=================================================="

bash "$SCRIPT_DIR/apply-devspace-terminal.sh"
bash "$SCRIPT_DIR/apply-firefox-theme.sh"
bash "$SCRIPT_DIR/apply-tmux-theme.sh"
bash "$SCRIPT_DIR/setup-server-optimizations.sh"

echo ""
echo "=================================================="
echo "  Toda a personalização foi concluída com sucesso! "
echo "=================================================="
