# 🚀 Changelog — `meu-setup`

Todas as mudanças notáveis deste projeto serão documentadas neste arquivo.

O formato é baseado no [Keep a Changelog](https://keepachangelog.com/pt-BR/1.0.0/),
e este projeto adere ao [Semantic Versioning](https://semver.org/lang/pt-BR/).

---

## [v2.0.0] — 2026-08-21 (Universal Multi-System & Cosmic Dev Edition)

### 🌌 Destaques
- **Reformulação Completa Inspirada no `awesome-skills`**: Lançamento do novo motor interativo TUI em Python (`tools/installer.py`) com tema cósmico de astronomia, café ☕ e desenvolvedor.
- **Controle Granular Item por Item (1-a-1)**: Wizard passo a passo interativo (`--wizard`) permitindo selecionar individualmente cada tema, cada tweak de sistema/energia e cada aplicação.
- **Suporte Multi-Sistema Robusto**: Compatibilidade integrada e adaptada para **Linux** (Debian, Ubuntu, Fedora, Arch Linux, openSUSE), **macOS** (Darwin / Homebrew) e **Windows** (Winget / PowerShell).

### 🎨 Temas & Estilização
- **DevSpace Cosmic Terminal**: Prompt Planck dinâmico com café ☕, Git `🌿`, relógio em tempo real, paletas de cores escuro/lilás claro e statusline nativa do Antigravity CLI.
- **WhiteSur macOS Look**: Instalador automatizado para GTK Dark Purple, ícones, cursores e Plank dock com botões macOS.
- **Firefox DevSpace Cósmico**: Injeção de `userChrome.css`, abas compactas e `userContent.css`.
- **Tmux Cósmico 24/7**: Barra inferior com frases dev em português, bolinha roxa separadora (`●`), script anti-ghosting `redraw-pane.sh` e persistência via `resurrect-hygiene.sh`.
- **Presets de Terminais Modernos**: Dotfiles calibrados para Starship, Alacritty, Kitty e Windows Terminal.

### ⚙️ Otimizações de Sistema, Energia & Kernel
- **Modo Servidor 24/7**: Mascaramento no systemd de `sleep.target`, `suspend.target`, `hibernate.target` e `hybrid-sleep.target`, desativação de timeouts no GNOME e fechamento de tampa do notebook (`HandleLidSwitch=ignore`).
- **Modo Notebook**: Otimizador TLP, Powertop autotune e Auto-CPUfreq.
- **Rede & Kernel**: TCP BBR v2 + Fair Queuing (FQ), aumento de inotify max_user_watches para 524.288, fs.file-max para 2.097.152 e swappiness=10.
- **Armazenamento & Docker**: Docker data-root configurado em `/home/docker-data`, rotação de logs (max 50MB) e SSD TRIM periódico (`fstrim.timer`).
- **Infraestrutura**: Container AdGuard Home (DNS sinkhole na porta 53 + painel web) e regras de Firewall UFW.

### 📦 Catálogo de Aplicações
- Expansão de [`packages.yaml`](packages.yaml) para **117+ ferramentas catalogadas**.
- Adicionados utilitários de banco de dados (`postgresql-client`, `mysql-client`, `redis-tools`, `sqlite3`, `dbeaver`).
- Adicionadas ferramentas de rede (`wireguard`, `nmap`, `rclone`, `rsync`, `dnsutils`, `net-tools`, `iproute2`, `traceroute`).
- Adicionados mensageiros e mídia (`telegram-desktop`, `slack`, `vlc`, `kdenlive`, `spotify`, `obs-studio`).
- Adicionados terminais e fontes (`alacritty`, `kitty`, `nerd-fonts`).

### 🧪 Testes & Geradores
- **`tools/gen.py`**: Geração automática e determinística de `windows/install.ps1`, `macos/install.sh`, `INVENTARIO.md` e `docs/PACKAGES_CATALOG.md`.
- **`tools/verify.sh`**: Suíte de testes com 24 verificações automatizadas de integridade, determinismo, segurança e conformidade.
