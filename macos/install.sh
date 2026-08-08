#!/usr/bin/env bash
# install.sh — GERADO por tools/gen.py, nao edite a mao.
# Repopula um macOS usando Homebrew.   Use DRY_RUN=1 para simular.
set -euo pipefail

DRY_RUN="${DRY_RUN:-0}"
run() { if [ "$DRY_RUN" = "1" ]; then echo "  [dry-run] $*"; else "$@"; fi; }

if ! command -v brew >/dev/null; then
  echo "==> Instalando Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

brew update

install_formula() {
  local pkg="$1" name="$2" desc="$3"
  echo "==> $name ($desc)"
  if brew list --formula "$pkg" >/dev/null 2>&1; then echo "    ja instalado"; return; fi
  run brew install "$pkg"
}

install_cask() {
  local pkg="$1" name="$2" desc="$3"
  echo "==> $name ($desc)"
  if brew list --cask "$pkg" >/dev/null 2>&1; then echo "    ja instalado"; return; fi
  run brew install --cask "$pkg"
}

# ---- formulas ----
install_formula "git" "git" "Controle de versão"
install_formula "git-lfs" "git-lfs" "Arquivos grandes no git"
install_formula "gh" "gh" "GitHub CLI"
install_formula "curl" "curl" "Transferência HTTP na linha de comando"
install_formula "wget" "wget" "Downloader"
install_formula "ripgrep" "ripgrep" "Busca em arquivos ultra-rápida (rg)"
install_formula "htop" "htop" "Monitor de processos"
install_formula "btop" "btop" "Monitor de recursos bonito"
install_formula "tmux" "tmux" "Multiplexador de terminal"
install_formula "python" "python3-pip" "Gerenciador de pacotes Python"
install_formula "node" "nodejs" "Runtime JavaScript (via nvm, versão LTS)"
install_formula "caddy" "caddy" "Servidor web / reverse proxy com HTTPS automático"
install_formula "syncthing" "syncthing" "Sincronização de arquivos P2P"
install_formula "ffmpeg" "ffmpeg" "Conversão de áudio e vídeo"
install_formula "poppler" "poppler-utils" "pdftotext, pdfimages e afins"
install_formula "pipx" "hermes-agent" "Agente Hermes (Nous Research)"
install_formula "node" "claude-code" "CLI de codificação da Anthropic"

# ---- casks ----
install_cask "docker" "docker" "Containers"
install_cask "tailscale" "tailscale" "VPN mesh"
install_cask "ollama" "ollama" "Rodar LLMs localmente"
install_cask "google-chrome" "google-chrome" "Navegador Chrome"
install_cask "firefox" "firefox" "Navegador Firefox"
install_cask "obsidian" "obsidian" "Notas em Markdown / vault"
install_cask "libreoffice" "libreoffice" "Suíte de escritório"
install_cask "onlyoffice" "onlyoffice" "Editor compatível com MS Office"
install_cask "mactex" "texlive-full" "Distribuição LaTeX completa (CV, artigos)"
install_cask "inkscape" "inkscape" "Editor de vetores SVG"
install_cask "gimp" "gimp" "Editor de imagens"

echo "Concluido."
