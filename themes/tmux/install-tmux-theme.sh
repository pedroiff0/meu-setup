#!/usr/bin/env bash
# ==============================================================================
# themes/tmux/install-tmux-theme.sh — DevSpace Cosmic Tmux & Persistence Setup
# ==============================================================================
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
DOTFILES="$ROOT_DIR/dotfiles/tmux"

echo "📟 Configurando Tmux Cósmico, TPM e Persistência..."

mkdir -p "$HOME/.tmux/logs" "$HOME/.local/share/tmux/resurrect" "$HOME/.tmux/plugins"

# 1. Copiar .tmux.conf e scripts auxiliares
cp -f "$DOTFILES/.tmux.conf" "$HOME/.tmux.conf"
cp -f "$DOTFILES/status-right.sh" "$HOME/.tmux/status-right.sh" 2>/dev/null || true
cp -f "$DOTFILES/redraw-pane.sh" "$HOME/.tmux/redraw-pane.sh" 2>/dev/null || true
cp -f "$DOTFILES/resurrect-hygiene.sh" "$HOME/.tmux/resurrect-hygiene.sh" 2>/dev/null || true
chmod +x "$HOME/.tmux"/*.sh 2>/dev/null || true

# 2. Instalar TPM (Tmux Plugin Manager) se não existir
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    echo "  Clonando Tmux Plugin Manager (TPM)..."
    git clone --depth=1 https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
fi

# 3. Recarregar tmux se estiver rodando
if [ -n "${TMUX:-}" ]; then
    tmux source-file "$HOME/.tmux.conf" 2>/dev/null || true
    echo "  Configuração recarregada na sessão ativa."
fi

echo "✔ Tmux configurado com sucesso! (Pressione Ctrl+a I no tmux para baixar plugins)"
