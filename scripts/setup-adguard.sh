#!/usr/bin/env bash
# ==============================================================================
# Inicializa o container do AdGuard Home (DNS Sinkhole & Adblocker)
# ==============================================================================
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DOTFILES="$ROOT_DIR/dotfiles/docker/adguardhome"
TARGET="$HOME/docker/adguardhome"

echo "==> Configurando AdGuard Home em $TARGET..."
mkdir -p "$TARGET/work" "$TARGET/conf"
cp -f "$DOTFILES/docker-compose.yml" "$TARGET/"

if command -v docker >/dev/null 2>&1; then
    echo "==> Subindo container do AdGuard Home..."
    cd "$TARGET" && docker compose up -d
    echo "[OK] AdGuard Home iniciado! Acesse http://localhost:3000 para o setup inicial."
else
    echo "Docker não encontrado. Instale o Docker antes de iniciar o AdGuard."
fi
