#!/usr/bin/env bash
# ==============================================================================
# install.sh — GERADO por tools/gen.py, nao edite a mao.
# Repopula um ambiente macOS usando Homebrew.
# Uso:
#   ./macos/install.sh
#   DRY_RUN=1 ./macos/install.sh
# ==============================================================================
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
install_formula "git" "git" "Controle de versão distribuído"
install_formula "git-lfs" "git-lfs" "Gerenciamento de arquivos grandes no Git"
install_formula "gh" "gh" "GitHub CLI oficial para issues, PRs e repositórios"
install_formula "curl" "curl" "Transferência HTTP/HTTPS na linha de comando"
install_formula "wget" "wget" "Downloader não-interativo de arquivos web"
install_formula "jq" "jq" "Processador de JSON flexível e leve para terminal"
install_formula "tree" "tree" "Visualizador de estrutura de diretórios em árvore"
install_formula "ripgrep" "ripgrep" "Busca recursiva em arquivos ultra-rápida (rg)"
install_formula "fd" "fd-find" "Alternativa simples, rápida e intuitiva ao find (fd)"
install_formula "htop" "htop" "Monitor interativo de processos no terminal"
install_formula "btop" "btop" "Monitor de recursos e hardware estético com gráficos"
install_formula "tmux" "tmux" "Multiplexador de terminal com sessões persistentes"
install_formula "nano" "nano" "Editor de texto simples e direto no terminal"
install_formula "zip" "zip" "Utilitário de compactação e descompactação zip/unzip"
install_formula "python" "python3-pip" "Gerenciador de pacotes padrão para bibliotecas Python"
install_formula "uv" "uv" "Gerenciador de pacotes e projetos Python ultra-rápido em Rust"
install_formula "node" "nodejs" "Runtime JavaScript via NVM (Node Version Manager LTS)"
install_formula "pnpm" "pnpm" "Gerenciador de pacotes JavaScript rápido e com economia de espaço"
install_formula "oven-sh/bun/bun" "bun" "Runtime JavaScript & TypeScript tudo-em-um ultra-rápido"
install_formula "rustup-init" "rustup" "Instalador e gerenciador da toolchain Rust e Cargo"
install_formula "go" "golang" "Linguagem de programação Go do Google"
install_formula "caddy" "caddy" "Servidor web e proxy reverso moderno com HTTPS automático"
install_formula "syncthing" "syncthing" "Sincronização contínua de arquivos P2P criptografada"
install_formula "nvtop" "nvtop" "Monitor de processos e utilização de GPU no terminal (NVIDIA/AMD/Intel)"
install_formula "smartmontools" "smartmontools" "Ferramentas de diagnóstico e integridade S.M.A.R.T. de discos"
install_formula "typst" "typst" "Novo sistema de diagramação moderno, rápido e poderoso"
install_formula "pandoc" "pandoc" "Conversor universal de documentos Markdown, PDF, LaTeX e DOCX"
install_formula "ffmpeg" "ffmpeg" "Conversão, streaming e processamento de áudio e vídeo"
install_formula "ghostscript" "ghostscript" "Interpretador para PostScript e motor de processamento PDF"
install_formula "poppler" "poppler-utils" "Utilitários para extração e manipulação de arquivos PDF (pdftotext)"
install_formula "sqlite" "sqlite3" "Mecanismo de banco de dados SQL embutido e CLI interativo"
install_formula "libpq" "postgresql-client" "Utilitários e cliente de linha de comando para PostgreSQL (psql, pg_dump)"
install_formula "mysql-client" "mysql-client" "Utilitários e cliente de linha de comando para MySQL e MariaDB"
install_formula "redis" "redis-tools" "Utilitários de linha de comando para bancos de dados Redis (redis-cli)"
install_formula "wireguard-tools" "wireguard" "VPN de alta performance, moderna e extremamente segura"
install_formula "nmap" "nmap" "Scanner de portas de rede e auditoria de segurança"
install_formula "rclone" "rclone" "Sincronizador de arquivos para múltiplos provedores de nuvem (S3, Drive)"
install_formula "rsync" "rsync" "Transferência e sincronização incremental rápida de arquivos"
install_formula "bind" "dnsutils" "Utilitários para diagnósticos e consultas DNS (dig, nslookup)"
install_formula "traceroute" "traceroute" "Rastreamento de rota de pacotes na rede IP"
install_formula "starship" "starship" "Prompt customizável e rápido para qualquer shell (Bash, Zsh, PowerShell)"
install_formula "pipx" "hermes-agent" "Agente de IA autônomo com suporte a skills canônicas (Nous Research)"
install_formula "node" "claude-code" "Ferramenta CLI de codificação agêntica da Anthropic no terminal"
install_formula "agy" "antigravity-cli" "Google Antigravity CLI oficial para agentes autônomos"
install_formula "node" "codex-cli" "CLI oficial do OpenAI Codex para agentes autônomos e execução de código no terminal"
install_formula "fzf" "fzf" "Fuzzy finder interativo para histórico, arquivos e comandos"
install_formula "bat" "bat" "Visualizador moderno de arquivos com sintaxe e integração Git"
install_formula "eza" "eza" "Substituto moderno para ls com ícones, cores, git e visão de árvore"
install_formula "zoxide" "zoxide" "Navegação rápida de diretórios aprendendo seus hábitos mais comuns (z)"
install_formula "git-delta" "git-delta" "Visualizador sintático e colorido para diffs do Git"
install_formula "lazygit" "lazygit" "Interface TUI interativa completa para operações Git no terminal"
install_formula "lazydocker" "lazydocker" "Interface TUI interativa completa para Docker e Docker Compose"
install_formula "yazi" "yazi" "Gerenciador de arquivos rápido para terminal escrito em Rust"
install_formula "glances" "glances" "Monitor de hardware e métricas no terminal e navegador"
install_formula "ctop" "ctop" "Monitor de métricas e recursos de contêineres Docker em tempo real"
install_formula "dive" "dive" "Analisador de camadas e eficiência de tamanho de imagens Docker"
install_formula "ncdu" "ncdu" "Analisador visual de ocupação de disco no terminal com navegação"
install_formula "gping" "gping" "Ping com gráfico gráfico de latência em tempo real no terminal"
install_formula "tealdeer" "tealdeer" "Implementação ultrarrápida do tldr com exemplos práticos de comandos"
install_formula "duf" "duf" "Visualizador moderno e intuitivo de partições e espaço em disco"
install_formula "fastfetch" "fastfetch" "Informações elegantes do sistema e hardware no terminal"
install_formula "filebrowser" "filebrowser" "Gerenciador web leve de arquivos para servidores e estações"
install_formula "ntfy" "ntfy" "Envio e recebimento de notificações push via linha de comando"
install_formula "adguardhome" "adguardhome" "DNS Sinkhole e bloqueador de anúncios para a rede local em Docker"

# ---- casks ----
install_cask "docker" "docker" "Plataforma líder de contêineres e virtualização leve"
install_cask "tailscale" "tailscale" "VPN Mesh privada segura baseada em WireGuard sem configuração"
install_cask "ollama" "ollama" "Execução local de modelos de IA e LLMs (Llama, DeepSeek, Qwen)"
install_cask "google-chrome" "google-chrome" "Navegador web Google Chrome"
install_cask "firefox" "firefox" "Navegador web Mozilla Firefox"
install_cask "brave-browser" "brave-browser" "Navegador focado em privacidade com bloqueio nativo de rastreadores"
install_cask "eloston-chromium" "chromium" "Navegador web Chromium de código aberto"
install_cask "obsidian" "obsidian" "Aplicativo de notas e base de conhecimento em Markdown"
install_cask "libreoffice" "libreoffice" "Suíte de produtividade para documentos, planilhas e apresentações"
install_cask "onlyoffice" "onlyoffice" "Suíte de escritório compatível com formatos Microsoft Office"
install_cask "mactex" "texlive-full" "Distribuição completa do LaTeX para CVs, artigos e relatórios"
install_cask "zotero" "zotero" "Gerenciador de referências bibliográficas e pesquisa científica"
install_cask "inkscape" "inkscape" "Editor profissional de ilustrações vetoriais SVG"
install_cask "gimp" "gimp" "Editor avançado de manipulação e retoque de imagens raster"
install_cask "vlc" "vlc" "Reprodutor multimídia universal para todos os formatos de mídia"
install_cask "obs-studio" "obs-studio" "Software de gravação de tela e transmissão ao vivo de alta performance"
install_cask "kdenlive" "kdenlive" "Editor de vídeo não-linear poderoso e de código aberto"
install_cask "discord" "discord" "Plataforma de comunicação em equipe, voz e chat para comunidades"
install_cask "telegram" "telegram-desktop" "Mensageiro rápido, seguro e sincronizado na nuvem"
install_cask "slack" "slack" "Plataforma de produtividade e comunicação corporativa"
install_cask "spotify" "spotify" "Serviço de streaming de músicas, podcasts e áudio"
install_cask "dbeaver-community" "dbeaver" "Ferramenta universal de administração de bancos de dados SQL/NoSQL"
install_cask "alacritty" "alacritty" "Emulador de terminal acelerado por GPU com foco em performance"
install_cask "kitty" "kitty" "Emulador de terminal rápido e extensível baseado em GPU"
install_cask "font-jetbrains-mono-nerd-font" "nerd-fonts" "Fontes com glifos e ícones de desenvolvedor para terminal (JetBrains Mono NF)"
install_cask "chatgpt" "chatgpt" "Aplicativo desktop nativo oficial do ChatGPT (OpenAI)"
install_cask "visual-studio-code" "vscode" "Editor de código fonte leve, extensível e poderoso da Microsoft"
install_cask "cursor" "cursor" "Editor de código avançado baseado em IA com Composer e modelos de ponta"
install_cask "windsurf" "windsurf" "IDE de IA agêntica da Codeium com arquitetura de fluxos Cascade"
install_cask "zerotier-one" "zerotier-one" "Rede privada virtual P2P para comunicação entre dispositivos"

echo "Concluido com sucesso!"
