#!/usr/bin/env bash
# ==============================================================================
# configs/storage/setup-docker-storage.sh — Configura Docker Data-Root e Logs
# ==============================================================================
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
DOTFILES="$ROOT_DIR/dotfiles/docker"

echo "🐳 Configurando armazenamento do Docker (/home/docker-data e logs)..."

sudo mkdir -p /home/docker-data /etc/docker

if [ -f "$DOTFILES/daemon.json" ]; then
    sudo cp -f "$DOTFILES/daemon.json" /etc/docker/daemon.json
    echo "  /etc/docker/daemon.json configurado."
fi

if command -v systemctl >/dev/null 2>&1 && systemctl is-active --quiet docker; then
    echo "  Reiniciando serviço Docker..."
    sudo systemctl restart docker 2>/dev/null || true
fi

echo "✔ Armazenamento do Docker configurado com sucesso!"
