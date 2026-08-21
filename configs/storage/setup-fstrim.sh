#!/usr/bin/env bash
# ==============================================================================
# configs/storage/setup-fstrim.sh — Ativa Periodic SSD TRIM
# ==============================================================================
set -euo pipefail

echo "💾 Ativando Timer de SSD TRIM (fstrim.timer)..."

if command -v systemctl >/dev/null 2>&1; then
    sudo systemctl enable --now fstrim.timer 2>/dev/null || true
    echo "✔ fstrim.timer ativado para manutenção contínua de SSDs!"
else
    echo "⚠️  systemctl não disponível."
fi
