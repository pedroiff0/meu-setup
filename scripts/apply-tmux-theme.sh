#!/usr/bin/env bash
# ==============================================================================
# Aplica a configuração do Tmux com tema DevSpace e statusline com separador ●
# ==============================================================================
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DOTFILES="$ROOT_DIR/dotfiles/tmux"

echo "==> Instalando configurações do Tmux..."
mkdir -p "$HOME/.tmux"
cp -f "$DOTFILES/.tmux.conf" "$HOME/.tmux.conf" 2>/dev/null || true
cp -f "$DOTFILES/status-right.sh" "$HOME/.tmux/status-right.sh" 2>/dev/null || true
chmod +x "$HOME/.tmux/status-right.sh" 2>/dev/null || true

if command -v tmux >/dev/null 2>&1 && tmux ls >/dev/null 2>&1; then
    tmux source-file "$HOME/.tmux.conf" 2>/dev/null || true
fi

echo "[OK] Configuração do Tmux aplicada!"
