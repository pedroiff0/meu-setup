#!/usr/bin/env bash
# ==============================================================================
# configs/power/macos-power.sh — Power & Sleep Configuration for macOS (pmset)
# ==============================================================================
set -euo pipefail

echo "🍎 Configurando Gerenciamento de Energia no macOS (pmset)..."

MODE="${1:-server}"

if [ "$MODE" = "server" ]; then
    echo "  Configurando modo Servidor 24/7 (Desativa sleep)..."
    sudo pmset -a disablesleep 1 2>/dev/null || true
    sudo pmset -a sleep 0 2>/dev/null || true
    sudo pmset -a displaysleep 15 2>/dev/null || true
    sudo pmset -a disksleep 0 2>/dev/null || true
else
    echo "  Configurando modo Normal/Laptop..."
    sudo pmset -a disablesleep 0 2>/dev/null || true
    sudo pmset -b sleep 15 2>/dev/null || true
    sudo pmset -b displaysleep 5 2>/dev/null || true
fi

echo "✔ Configurações de energia do macOS aplicadas!"
