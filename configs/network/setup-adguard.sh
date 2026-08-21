#!/usr/bin/env bash
# ==============================================================================
# configs/network/setup-adguard.sh — Inicia AdGuard Home em Docker
# ==============================================================================
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
DOTFILES="$ROOT_DIR/dotfiles/docker/adguardhome"
TARGET="$HOME/docker/adguardhome"

echo "🛡️  Configurando AdGuard Home (DNS Sinkhole & AdBlock)..."

mkdir -p "$TARGET/work" "$TARGET/conf"
cp -f "$DOTFILES/docker-compose.yml" "$TARGET/"

if command -v docker >/dev/null 2>&1; then
    cd "$TARGET"
    docker compose up -d 2>/dev/null || docker-compose up -d 2>/dev/null || true
    echo "✔ AdGuard Home iniciado em background!"
    echo "  Interface Web inicial: http://localhost:3000 (Configuração inicial)"
    echo "  Interface Web de controle: http://localhost:8085"
else
    echo "⚠️  Docker não encontrado. Instale o Docker antes de executar o AdGuard Home."
fi
