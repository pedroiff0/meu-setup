#!/usr/bin/env bash
# ==============================================================================
# Instala e aplica o tema de terminal DevSpace (Paleta Cósmica, Prompt e Statusline)
# ==============================================================================
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DOTFILES="$ROOT_DIR/dotfiles/devspace"

echo "==> Instalando configurações do DevSpace..."
mkdir -p "$HOME/.config/devspace" "$HOME/.local/bin"

cp -f "$DOTFILES"/palette*.sh "$HOME/.config/devspace/" 2>/dev/null || true
cp -f "$DOTFILES"/prompt.sh "$DOTFILES"/keybinds.sh "$HOME/.config/devspace/" 2>/dev/null || true
cp -f "$DOTFILES"/agy-statusline.sh "$HOME/.config/devspace/" 2>/dev/null || true
chmod +x "$HOME/.config/devspace/agy-statusline.sh"

cp -f "$DOTFILES"/devspace-welcome.sh "$DOTFILES"/apply-cosmicmac-profile.sh "$HOME/.local/bin/" 2>/dev/null || true
chmod +x "$HOME/.local/bin/"* 2>/dev/null || true

# Symlink bat -> batcat se necessário
if [ -f /usr/bin/batcat ] && [ ! -f "$HOME/.local/bin/bat" ]; then
    ln -sf /usr/bin/batcat "$HOME/.local/bin/bat"
fi

echo "==> Atualizando ~/.bashrc com integrações modernas..."
grep -q "devspace/palette.sh" "$HOME/.bashrc" 2>/dev/null || cat << 'EOF' >> "$HOME/.bashrc"

# >>> DevSpace >>>
case ":$PATH:" in *":$HOME/.local/bin:"*) ;; *) PATH="$HOME/.local/bin:$PATH" ;; esac

if [ -n "${BASH_VERSION:-}" ] && [ -d "$HOME/.config/devspace" ]; then
  . "$HOME/.config/devspace/palette.sh"  2>/dev/null
  . "$HOME/.config/devspace/prompt.sh"   2>/dev/null
  . "$HOME/.config/devspace/keybinds.sh" 2>/dev/null
fi
# <<< DevSpace <<<
EOF

grep -q "Modern CLI Tools & Integrations" "$HOME/.bashrc" 2>/dev/null || cat << 'EOF' >> "$HOME/.bashrc"

# --- Modern CLI Tools & Integrations ---
if command -v zoxide >/dev/null 2>&1; then eval "$(zoxide init bash)"; fi
if command -v fzf >/dev/null 2>&1; then eval "$(fzf --bash 2>/dev/null)" || true; fi

alias lg="lazygit"
alias ld="lazydocker"
alias ls="eza --icons"
alias ll="eza -la --icons --git"
alias tree="eza --tree --icons"
alias cat="bat -p"
alias du="duf"
alias fetch="fastfetch"
EOF

echo "[OK] Tema DevSpace aplicado ao terminal com sucesso!"
