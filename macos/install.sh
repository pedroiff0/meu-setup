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
install_formula "fzf" "fzf" "Fuzzy finder interativo para linha de comando"
install_formula "bat" "bat" "Substituto moderno do cat com realce de sintaxe e git"
install_formula "eza" "eza" "Substituto moderno do ls com ícones, cores e árvore"
install_formula "zoxide" "zoxide" "Substituto inteligente do comando cd com memória de diretórios"
install_formula "git-delta" "git-delta" "Visualizador moderno de diffs do git com sintaxe e cores"
install_formula "lazygit" "lazygit" "Interface TUI interativa para gerenciamento do Git"
install_formula "lazydocker" "lazydocker" "Interface TUI interativa para Docker e Docker Compose"
install_formula "yazi" "yazi" "Gerenciador de arquivos para terminal rápido em Rust"
install_formula "glances" "glances" "Monitor de recursos do sistema e hardware no terminal e web"
install_formula "ctop" "ctop" "Monitor de métricas em tempo real para contêineres Docker"
install_formula "dive" "dive" "Analisador visual de camadas e tamanho de imagens Docker"
install_formula "ncdu" "ncdu" "Analisador interativo de uso de espaço em disco no terminal"
install_formula "gping" "gping" "Ping com gráfico de latência em tempo real no terminal"
install_formula "tealdeer" "tealdeer" "Implementação rápida em Rust do tldr com exemplos de comandos"
install_formula "duf" "duf" "Visualizador amigável de partições e uso de disco"
install_formula "fastfetch" "fastfetch" "Exibição elegante de informações do sistema no terminal"
install_formula "filebrowser" "filebrowser" "Gerenciador de arquivos web leve para servidores e desktops"
install_formula "ntfy" "ntfy" "Cliente e servidor de notificações push para scripts e alertas"
install_formula "adguardhome" "adguardhome" "DNS Sinkhole e bloqueador de anúncios para rede inteira em Docker"

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
install_cask "zerotier-one" "zerotier-one" "Rede VPN mesh privada para comunicação ponto a ponto"

echo "Concluido."
