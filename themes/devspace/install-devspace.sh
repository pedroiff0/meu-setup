#!/usr/bin/env bash
# ==============================================================================
# themes/devspace/install-devspace.sh — Multi-OS DevSpace Cosmic Terminal Setup
# ==============================================================================
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
DOTFILES="$ROOT_DIR/dotfiles/devspace"

echo "🌌 Instalando Tema DevSpace (Terminal Cósmico, Prompt e Paletas)..."

mkdir -p "$HOME/.config/devspace" "$HOME/.local/bin" "$HOME/.config/fastfetch"

# 1. Copiar dotfiles do DevSpace
cp -f "$DOTFILES"/palette*.sh "$HOME/.config/devspace/" 2>/dev/null || true
cp -f "$DOTFILES"/prompt.sh "$DOTFILES"/keybinds.sh "$HOME/.config/devspace/" 2>/dev/null || true
cp -f "$DOTFILES"/agy-statusline.sh "$HOME/.config/devspace/" 2>/dev/null || true
chmod +x "$HOME/.config/devspace/agy-statusline.sh" 2>/dev/null || true

# 2. Copiar utilitários para ~/.local/bin
for script in devspace-welcome.sh devspace-stars.sh devspace-bg.sh devspace-desktop-hud.py devspace-telemetry-json.sh devspace-hud devspace-itermgradient.sh apply-cosmicmac-profile.sh; do
    if [ -f "$DOTFILES/$script" ]; then
        cp -f "$DOTFILES/$script" "$HOME/.local/bin/"
        chmod +x "$HOME/.local/bin/$script"
    fi
done

# 3. Fastfetch Preset
if [ -f "$ROOT_DIR/dotfiles/fastfetch/config.jsonc" ]; then
    cp -f "$ROOT_DIR/dotfiles/fastfetch/config.jsonc" "$HOME/.config/fastfetch/"
fi

# 4. Symlink bat -> batcat se necessário no Debian/Ubuntu
if [ -f /usr/bin/batcat ] && [ ! -f "$HOME/.local/bin/bat" ]; then
    ln -sf /usr/bin/batcat "$HOME/.local/bin/bat"
fi

# 5. Injeção no ~/.bashrc
if [ -f "$HOME/.bashrc" ]; then
    grep -q "devspace/palette.sh" "$HOME/.bashrc" 2>/dev/null || cat << 'EOF' >> "$HOME/.bashrc"

# >>> DevSpace Cosmic Terminal >>>
case ":$PATH:" in *":$HOME/.local/bin:"*) ;; *) PATH="$HOME/.local/bin:$PATH" ;; esac

if [ -n "${BASH_VERSION:-}" ] && [ -d "$HOME/.config/devspace" ]; then
  . "$HOME/.config/devspace/palette.sh"  2>/dev/null
  . "$HOME/.config/devspace/prompt.sh"   2>/dev/null
  . "$HOME/.config/devspace/keybinds.sh" 2>/dev/null
fi
# <<< DevSpace Cosmic Terminal <<<
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
fi

# 6. Injeção no ~/.zshrc para macOS / Zsh
if [ -f "$HOME/.zshrc" ]; then
    grep -q "devspace/prompt.sh" "$HOME/.zshrc" 2>/dev/null || cat << 'EOF' >> "$HOME/.zshrc"

# >>> DevSpace Cosmic Terminal (Zsh) >>>
case ":$PATH:" in *":$HOME/.local/bin:"*) ;; *) PATH="$HOME/.local/bin:$PATH" ;; esac
if command -v zoxide >/dev/null 2>&1; then eval "$(zoxide init zsh)"; fi

alias lg="lazygit"
alias ld="lazydocker"
alias ls="eza --icons"
alias ll="eza -la --icons --git"
alias tree="eza --tree --icons"
alias cat="bat -p"
alias du="duf"
alias fetch="fastfetch"
# <<< DevSpace Cosmic Terminal (Zsh) <<<
EOF
fi

echo "✔ Tema DevSpace Cosmic aplicado com sucesso!"
