#!/usr/bin/env bash
# ==============================================================================
# Pedro Shadow Monarch OS - Instalador para macOS (Terminal.app & iTerm2)
# ==============================================================================

echo "🚀 Configurando Pedro Shadow Monarch OS no Mac..."

CONFIG_DIR="$HOME/.config/devspace"
mkdir -p "$CONFIG_DIR"

# Copiar configuracoes de prompt
cat << 'PROMPT_EOF' > "$CONFIG_DIR/prompt-mac.sh"
# Prompt para ZSH (padrao do macOS)
if [ -n "$ZSH_VERSION" ]; then
  autoload -Uz vcs_info
  precmd_vcs_info() { vcs_info }
  precmd_functions+=( precmd_vcs_info )
  setopt prompt_subst
  zstyle ':vcs_info:git:*' formats ' %%F{242}|%%f %%F{120}🌿 %%b%%f'

  mac_prompt() {
    local hora="$(date +%H:%M:%S)"
    print -P "\n%F{177}[Shadow Monarch OS]%f %F{51}📁 %~%f${vcs_info_msg_0_} %F{242}|%f %F{220}⏱ ${hora}%f"
    print -P "%F{177}☕ %B%F{213}%n%f%b at %F{75}%m%f %F{177}❯%f "
  }
  PROMPT='$(mac_prompt)'
elif [ -n "$BASH_VERSION" ]; then
  _mac_prompt() {
    local hora="$(date +%H:%M:%S)"
    local ramo=""
    git rev-parse --is-inside-work-tree >/dev/null 2>&1 && ramo=" | 🌿 $(git branch --show-current 2>/dev/null)"
    PS1="\n\033[38;2;168;85;247m[Shadow Monarch OS]\033[0m \033[38;2;0;243;255m📁 \w\033[0m\033[38;2;16;185;129m${ramo}\033[0m \033[38;2;100;116;139m|\033[0m \033[38;2;251;191;36m⏱ ${hora}\033[0m\n\033[38;2;168;85;247m☕ \033[1m\033[38;2;192;132;252m\u\033[0m\033[38;2;168;85;247m ❯\033[0m "
  }
  PROMPT_COMMAND=_mac_prompt
fi
PROMPT_EOF

# Injetar no ~/.zshrc se for ZSH
if [ -f "$HOME/.zshrc" ]; then
  grep -q "prompt-mac.sh" "$HOME/.zshrc" || echo 'source "$HOME/.config/devspace/prompt-mac.sh"' >> "$HOME/.zshrc"
else
  echo 'source "$HOME/.config/devspace/prompt-mac.sh"' >> "$HOME/.zprofile"
fi

echo "✅ Prompt configurado no seu ~/.zshrc / ~/.zprofile!"
