# 📦 Catálogo Completo de Pacotes & Ferramentas

Este documento cataloga todos os **117 programas e utilitários** do `meu-setup`.
Gerado automaticamente por `tools/gen.py` a partir de [`packages.yaml`](../packages.yaml).

## 📑 Índice por Categorias

- [ACADEMIC (6 apps)](#academic)
- [ARQUIVOS (7 apps)](#arquivos)
- [BASE (17 apps)](#base)
- [CLI (64 apps)](#cli)
- [COMPAT (3 apps)](#compat)
- [COMUNICACAO (3 apps)](#comunicacao)
- [CREATIVE (4 apps)](#creative)
- [DATABASE (5 apps)](#database)
- [DESIGN (2 apps)](#design)
- [DESKTOP (11 apps)](#desktop)
- [DEV (37 apps)](#dev)
- [DRIVER (1 apps)](#driver)
- [ENERGIA (3 apps)](#energia)
- [ESCRITORIO (9 apps)](#escritorio)
- [FONTES (2 apps)](#fontes)
- [GPU (3 apps)](#gpu)
- [IA (6 apps)](#ia)
- [INFRA (15 apps)](#infra)
- [JS (4 apps)](#js)
- [LATEX (4 apps)](#latex)
- [LINUX-ONLY (5 apps)](#linux-only)
- [MIDIA (6 apps)](#midia)
- [MONITORAMENTO (12 apps)](#monitoramento)
- [NAVEGADOR (4 apps)](#navegador)
- [NOTAS (2 apps)](#notas)
- [PDF (2 apps)](#pdf)
- [PRODUTIVIDADE (3 apps)](#produtividade)
- [PYTHON (5 apps)](#python)
- [REDE (15 apps)](#rede)
- [SECURITY (7 apps)](#security)
- [SYSADMIN (26 apps)](#sysadmin)
- [TEMA (6 apps)](#tema)
- [VIDEO (4 apps)](#video)
- [WEB (2 apps)](#web)

## ACADEMIC

| Pacote | Descrição | Linux | Windows | macOS |
|---|---|---|---|---|
| **latexmk** | Automação e compilação contínua de documentos LaTeX | `latexmk` | `—` | `—` |
| **pandoc** | Conversor universal de documentos Markdown, PDF, LaTeX e DOCX | `pandoc` | `JohnMacFarlane.Pandoc` | `pandoc` |
| **poppler-utils** | Utilitários para extração e manipulação de arquivos PDF (pdftotext) | `poppler-utils` | `—` | `poppler` |
| **texlive-full** | Distribuição completa do LaTeX para CVs, artigos e relatórios | `texlive-full` | `MiKTeX.MiKTeX` | `mactex` |
| **typst** | Novo sistema de diagramação moderno, rápido e poderoso | `script` | `Typst.Typst` | `typst` |
| **zotero** | Gerenciador de referências bibliográficas e pesquisa científica | `zotero` | `DigitalScholar.Zotero` | `zotero` |

## ARQUIVOS

| Pacote | Descrição | Linux | Windows | macOS |
|---|---|---|---|---|
| **filebrowser** | Gerenciador web leve de arquivos para servidores e estações | `script` | `FileBrowser.FileBrowser` | `filebrowser` |
| **rclone** | Sincronizador de arquivos para múltiplos provedores de nuvem (S3, Drive) | `rclone` | `Rclone.Rclone` | `rclone` |
| **rsync** | Transferência e sincronização incremental rápida de arquivos | `rsync` | `—` | `rsync` |
| **samba** | Servidor e cliente para compartilhamento de arquivos SMB/CIFS | `samba` | `—` | `—` |
| **syncthing** | Sincronização contínua de arquivos P2P criptografada | `syncthing` | `Syncthing.Syncthing` | `syncthing` |
| **yazi** | Gerenciador de arquivos rápido para terminal escrito em Rust | `script` | `sxyazi.yazi` | `yazi` |
| **zip** | Utilitário de compactação e descompactação zip/unzip | `zip unzip` | `7zip.7zip` | `zip` |

## BASE

| Pacote | Descrição | Linux | Windows | macOS |
|---|---|---|---|---|
| **build-essential** | Compiladores e headers de C/C++ (gcc, g++, make) | `build-essential` | `—` | `—` |
| **curl** | Transferência HTTP/HTTPS na linha de comando | `curl` | `cURL.cURL` | `curl` |
| **fd-find** | Alternativa simples, rápida e intuitiva ao find (fd) | `fd-find` | `sharkdp.fd` | `fd` |
| **fzf** | Fuzzy finder interativo para histórico, arquivos e comandos | `fzf` | `junegunn.fzf` | `fzf` |
| **gh** | GitHub CLI oficial para issues, PRs e repositórios | `gh` | `GitHub.cli` | `gh` |
| **git** | Controle de versão distribuído | `git` | `Git.Git` | `git` |
| **htop** | Monitor interativo de processos no terminal | `htop` | `—` | `htop` |
| **jq** | Processador de JSON flexível e leve para terminal | `jq` | `jqlang.jq` | `jq` |
| **nano** | Editor de texto simples e direto no terminal | `nano` | `GNU.Nano` | `nano` |
| **ripgrep** | Busca recursiva em arquivos ultra-rápida (rg) | `ripgrep` | `BurntSushi.ripgrep.MSVC` | `ripgrep` |
| **rsync** | Transferência e sincronização incremental rápida de arquivos | `rsync` | `—` | `rsync` |
| **tealdeer** | Implementação ultrarrápida do tldr com exemplos práticos de comandos | `tealdeer` | `dbrgn.tealdeer` | `tealdeer` |
| **tmux** | Multiplexador de terminal com sessões persistentes | `tmux` | `—` | `tmux` |
| **tree** | Visualizador de estrutura de diretórios em árvore | `tree` | `GnuWin32.Tree` | `tree` |
| **wget** | Downloader não-interativo de arquivos web | `wget` | `—` | `wget` |
| **xclip** | Integração da linha de comando com clipboard (X11) | `xclip` | `—` | `—` |
| **zip** | Utilitário de compactação e descompactação zip/unzip | `zip unzip` | `7zip.7zip` | `zip` |

## CLI

| Pacote | Descrição | Linux | Windows | macOS |
|---|---|---|---|---|
| **antigravity-cli** | Google Antigravity CLI oficial para agentes autônomos | `script` | `—` | `agy` |
| **bat** | Visualizador moderno de arquivos com sintaxe e integração Git | `bat` | `sharkdp.bat` | `bat` |
| **btop** | Monitor de recursos e hardware estético com gráficos | `btop` | `aristocratos.btop4win` | `btop` |
| **bun** | Runtime JavaScript & TypeScript tudo-em-um ultra-rápido | `script` | `Oven-sh.Bun` | `oven-sh/bun/bun` |
| **claude-code** | Ferramenta CLI de codificação agêntica da Anthropic no terminal | `script` | `—` | `node` |
| **ctop** | Monitor de métricas e recursos de contêineres Docker em tempo real | `script` | `—` | `ctop` |
| **curl** | Transferência HTTP/HTTPS na linha de comando | `curl` | `cURL.cURL` | `curl` |
| **dive** | Analisador de camadas e eficiência de tamanho de imagens Docker | `script` | `wagoodman.dive` | `dive` |
| **dnsutils** | Utilitários para diagnósticos e consultas DNS (dig, nslookup) | `dnsutils` | `—` | `bind` |
| **docker-compose** | Orquestração de múltiplos contêineres Docker via YAML | `docker-compose` | `—` | `—` |
| **duf** | Visualizador moderno e intuitivo de partições e espaço em disco | `duf` | `muesli.duf` | `duf` |
| **eza** | Substituto moderno para ls com ícones, cores, git e visão de árvore | `eza` | `eza-community.eza` | `eza` |
| **fastfetch** | Informações elegantes do sistema e hardware no terminal | `fastfetch` | `Fastfetch-cli.Fastfetch` | `fastfetch` |
| **fd-find** | Alternativa simples, rápida e intuitiva ao find (fd) | `fd-find` | `sharkdp.fd` | `fd` |
| **ffmpeg** | Conversão, streaming e processamento de áudio e vídeo | `ffmpeg` | `Gyan.FFmpeg` | `ffmpeg` |
| **fzf** | Fuzzy finder interativo para histórico, arquivos e comandos | `fzf` | `junegunn.fzf` | `fzf` |
| **gh** | GitHub CLI oficial para issues, PRs e repositórios | `gh` | `GitHub.cli` | `gh` |
| **ghostscript** | Interpretador para PostScript e motor de processamento PDF | `ghostscript` | `—` | `ghostscript` |
| **git** | Controle de versão distribuído | `git` | `Git.Git` | `git` |
| **git-delta** | Visualizador sintático e colorido para diffs do Git | `git-delta` | `dandavison.delta` | `git-delta` |
| **git-lfs** | Gerenciamento de arquivos grandes no Git | `git-lfs` | `GitHub.GitLFS` | `git-lfs` |
| **glances** | Monitor de hardware e métricas no terminal e navegador | `glances` | `NicolasHennion.Glances` | `glances` |
| **golang** | Linguagem de programação Go do Google | `golang` | `GoLang.Go` | `go` |
| **gping** | Ping com gráfico gráfico de latência em tempo real no terminal | `gping` | `orf.gping` | `gping` |
| **hermes-agent** | Agente de IA autônomo com suporte a skills canônicas (Nous Research) | `script` | `—` | `pipx` |
| **htop** | Monitor interativo de processos no terminal | `htop` | `—` | `htop` |
| **iproute2** | Coleção moderna de controle de rede no Linux (ip, ss, bridge) | `iproute2` | `—` | `—` |
| **jq** | Processador de JSON flexível e leve para terminal | `jq` | `jqlang.jq` | `jq` |
| **latexmk** | Automação e compilação contínua de documentos LaTeX | `latexmk` | `—` | `—` |
| **lazydocker** | Interface TUI interativa completa para Docker e Docker Compose | `script` | `JesseDuffield.lazydocker` | `lazydocker` |
| **lazygit** | Interface TUI interativa completa para operações Git no terminal | `lazygit` | `JesseDuffield.lazygit` | `lazygit` |
| **lm-sensors** | Utilitário para leitura de sensores de temperatura, fans e voltagens | `lm-sensors` | `—` | `—` |
| **mysql-client** | Utilitários e cliente de linha de comando para MySQL e MariaDB | `default-mysql-client` | `Oracle.MySQL` | `mysql-client` |
| **nano** | Editor de texto simples e direto no terminal | `nano` | `GNU.Nano` | `nano` |
| **ncdu** | Analisador visual de ocupação de disco no terminal com navegação | `ncdu` | `YoranGrumich.ncdu` | `ncdu` |
| **net-tools** | Utilitários clássicos de controle de rede (ifconfig, netstat, arp) | `net-tools` | `—` | `—` |
| **nmap** | Scanner de portas de rede e auditoria de segurança | `nmap` | `Insecure.Nmap` | `nmap` |
| **ntfy** | Envio e recebimento de notificações push via linha de comando | `script` | `—` | `ntfy` |
| **nvtop** | Monitor de processos e utilização de GPU no terminal (NVIDIA/AMD/Intel) | `nvtop` | `—` | `nvtop` |
| **ollama** | Execução local de modelos de IA e LLMs (Llama, DeepSeek, Qwen) | `script` | `Ollama.Ollama` | `ollama` |
| **pandoc** | Conversor universal de documentos Markdown, PDF, LaTeX e DOCX | `pandoc` | `JohnMacFarlane.Pandoc` | `pandoc` |
| **pnpm** | Gerenciador de pacotes JavaScript rápido e com economia de espaço | `script` | `pnpm.pnpm` | `pnpm` |
| **poppler-utils** | Utilitários para extração e manipulação de arquivos PDF (pdftotext) | `poppler-utils` | `—` | `poppler` |
| **postgresql-client** | Utilitários e cliente de linha de comando para PostgreSQL (psql, pg_dump) | `postgresql-client` | `PostgreSQL.PostgreSQL` | `libpq` |
| **python3-pip** | Gerenciador de pacotes padrão para bibliotecas Python | `python3-pip` | `Python.Python.3.12` | `python` |
| **rclone** | Sincronizador de arquivos para múltiplos provedores de nuvem (S3, Drive) | `rclone` | `Rclone.Rclone` | `rclone` |
| **redis-tools** | Utilitários de linha de comando para bancos de dados Redis (redis-cli) | `redis-tools` | `Redis.Redis` | `redis` |
| **ripgrep** | Busca recursiva em arquivos ultra-rápida (rg) | `ripgrep` | `BurntSushi.ripgrep.MSVC` | `ripgrep` |
| **rsync** | Transferência e sincronização incremental rápida de arquivos | `rsync` | `—` | `rsync` |
| **rustup** | Instalador e gerenciador da toolchain Rust e Cargo | `script` | `Rustlang.Rustup` | `rustup-init` |
| **smartmontools** | Ferramentas de diagnóstico e integridade S.M.A.R.T. de discos | `smartmontools` | `smartmontools.smartmontools` | `smartmontools` |
| **sqlite3** | Mecanismo de banco de dados SQL embutido e CLI interativo | `sqlite3` | `SQLite.SQLite` | `sqlite` |
| **starship** | Prompt customizável e rápido para qualquer shell (Bash, Zsh, PowerShell) | `script` | `Starship.Starship` | `starship` |
| **tealdeer** | Implementação ultrarrápida do tldr com exemplos práticos de comandos | `tealdeer` | `dbrgn.tealdeer` | `tealdeer` |
| **tmux** | Multiplexador de terminal com sessões persistentes | `tmux` | `—` | `tmux` |
| **traceroute** | Rastreamento de rota de pacotes na rede IP | `traceroute` | `—` | `traceroute` |
| **tree** | Visualizador de estrutura de diretórios em árvore | `tree` | `GnuWin32.Tree` | `tree` |
| **typst** | Novo sistema de diagramação moderno, rápido e poderoso | `script` | `Typst.Typst` | `typst` |
| **uv** | Gerenciador de pacotes e projetos Python ultra-rápido em Rust | `script` | `astral-sh.uv` | `uv` |
| **wget** | Downloader não-interativo de arquivos web | `wget` | `—` | `wget` |
| **xclip** | Integração da linha de comando com clipboard (X11) | `xclip` | `—` | `—` |
| **yazi** | Gerenciador de arquivos rápido para terminal escrito em Rust | `script` | `sxyazi.yazi` | `yazi` |
| **zip** | Utilitário de compactação e descompactação zip/unzip | `zip unzip` | `7zip.7zip` | `zip` |
| **zoxide** | Navegação rápida de diretórios aprendendo seus hábitos mais comuns (z) | `zoxide` | `ajeetdsouza.zoxide` | `zoxide` |

## COMPAT

| Pacote | Descrição | Linux | Windows | macOS |
|---|---|---|---|---|
| **playonlinux** | Interface gráfica para gerenciamento de ambientes e jogos Wine | `playonlinux` | `—` | `—` |
| **wine** | Camada de compatibilidade para executar aplicativos Windows no Linux | `wine wine32` | `—` | `—` |
| **winetricks** | Utilitário para instalar bibliotecas e componentes runtime do Windows | `winetricks` | `—` | `—` |

## COMUNICACAO

| Pacote | Descrição | Linux | Windows | macOS |
|---|---|---|---|---|
| **discord** | Plataforma de comunicação em equipe, voz e chat para comunidades | `discord` | `Discord.Discord` | `discord` |
| **slack** | Plataforma de produtividade e comunicação corporativa | `slack-desktop` | `SlackTechnologies.Slack` | `slack` |
| **telegram-desktop** | Mensageiro rápido, seguro e sincronizado na nuvem | `telegram-desktop` | `Telegram.TelegramDesktop` | `telegram` |

## CREATIVE

| Pacote | Descrição | Linux | Windows | macOS |
|---|---|---|---|---|
| **gimp** | Editor avançado de manipulação e retoque de imagens raster | `gimp` | `GIMP.GIMP` | `gimp` |
| **inkscape** | Editor profissional de ilustrações vetoriais SVG | `inkscape` | `Inkscape.Inkscape` | `inkscape` |
| **kdenlive** | Editor de vídeo não-linear poderoso e de código aberto | `kdenlive` | `KDE.Kdenlive` | `kdenlive` |
| **obs-studio** | Software de gravação de tela e transmissão ao vivo de alta performance | `obs-studio` | `OBSProject.OBSStudio` | `obs-studio` |

## DATABASE

| Pacote | Descrição | Linux | Windows | macOS |
|---|---|---|---|---|
| **dbeaver** | Ferramenta universal de administração de bancos de dados SQL/NoSQL | `dbeaver-ce` | `dbeaver.dbeaver` | `dbeaver-community` |
| **mysql-client** | Utilitários e cliente de linha de comando para MySQL e MariaDB | `default-mysql-client` | `Oracle.MySQL` | `mysql-client` |
| **postgresql-client** | Utilitários e cliente de linha de comando para PostgreSQL (psql, pg_dump) | `postgresql-client` | `PostgreSQL.PostgreSQL` | `libpq` |
| **redis-tools** | Utilitários de linha de comando para bancos de dados Redis (redis-cli) | `redis-tools` | `Redis.Redis` | `redis` |
| **sqlite3** | Mecanismo de banco de dados SQL embutido e CLI interativo | `sqlite3` | `SQLite.SQLite` | `sqlite` |

## DESIGN

| Pacote | Descrição | Linux | Windows | macOS |
|---|---|---|---|---|
| **gimp** | Editor avançado de manipulação e retoque de imagens raster | `gimp` | `GIMP.GIMP` | `gimp` |
| **inkscape** | Editor profissional de ilustrações vetoriais SVG | `inkscape` | `Inkscape.Inkscape` | `inkscape` |

## DESKTOP

| Pacote | Descrição | Linux | Windows | macOS |
|---|---|---|---|---|
| **alacritty** | Emulador de terminal acelerado por GPU com foco em performance | `alacritty` | `Alacritty.Alacritty` | `alacritty` |
| **fastfetch** | Informações elegantes do sistema e hardware no terminal | `fastfetch` | `Fastfetch-cli.Fastfetch` | `fastfetch` |
| **fonts** | Coleção de fontes essenciais (Inter, JetBrains Mono, Liberation, Noto Emoji) | `fonts-inter fonts-jetbrains-mono fonts-liberation fonts-noto-color-emoji fonts-freefont-ttf` | `—` | `—` |
| **kde-plasma-desktop** | Ambiente de desktop completo e personalizável KDE Plasma 6 | `kde-plasma-desktop` | `—` | `—` |
| **kitty** | Emulador de terminal rápido e extensível baseado em GPU | `kitty` | `kovidgoyal.kitty` | `kitty` |
| **nerd-fonts** | Fontes com glifos e ícones de desenvolvedor para terminal (JetBrains Mono NF) | `script` | `—` | `font-jetbrains-mono-nerd-font` |
| **papirus-icon-theme** | Pacote de ícones SVG elegante para desktops Linux | `papirus-icon-theme` | `—` | `—` |
| **plank** | Dock leve e elegante estilo macOS para desktops XFCE/GNOME | `plank` | `—` | `—` |
| **qt-style-kvantum** | Motor de temas baseado em SVG para aplicativos Qt/KDE | `qt-style-kvantum` | `—` | `—` |
| **sddm** | Gerenciador de display e login moderno para KDE | `sddm` | `—` | `—` |
| **starship** | Prompt customizável e rápido para qualquer shell (Bash, Zsh, PowerShell) | `script` | `Starship.Starship` | `starship` |

## DEV

| Pacote | Descrição | Linux | Windows | macOS |
|---|---|---|---|---|
| **antigravity-cli** | Google Antigravity CLI oficial para agentes autônomos | `script` | `—` | `agy` |
| **bat** | Visualizador moderno de arquivos com sintaxe e integração Git | `bat` | `sharkdp.bat` | `bat` |
| **build-essential** | Compiladores e headers de C/C++ (gcc, g++, make) | `build-essential` | `—` | `—` |
| **bun** | Runtime JavaScript & TypeScript tudo-em-um ultra-rápido | `script` | `Oven-sh.Bun` | `oven-sh/bun/bun` |
| **claude-code** | Ferramenta CLI de codificação agêntica da Anthropic no terminal | `script` | `—` | `node` |
| **cuda-keyring** | Repositório oficial CUDA da NVIDIA para Debian/Ubuntu | `cuda-keyring` | `—` | `—` |
| **dbeaver** | Ferramenta universal de administração de bancos de dados SQL/NoSQL | `dbeaver-ce` | `dbeaver.dbeaver` | `dbeaver-community` |
| **dive** | Analisador de camadas e eficiência de tamanho de imagens Docker | `script` | `wagoodman.dive` | `dive` |
| **docker** | Plataforma líder de contêineres e virtualização leve | `docker.io` | `Docker.DockerDesktop` | `docker` |
| **docker-compose** | Orquestração de múltiplos contêineres Docker via YAML | `docker-compose` | `—` | `—` |
| **eza** | Substituto moderno para ls com ícones, cores, git e visão de árvore | `eza` | `eza-community.eza` | `eza` |
| **fd-find** | Alternativa simples, rápida e intuitiva ao find (fd) | `fd-find` | `sharkdp.fd` | `fd` |
| **fzf** | Fuzzy finder interativo para histórico, arquivos e comandos | `fzf` | `junegunn.fzf` | `fzf` |
| **gh** | GitHub CLI oficial para issues, PRs e repositórios | `gh` | `GitHub.cli` | `gh` |
| **git** | Controle de versão distribuído | `git` | `Git.Git` | `git` |
| **git-delta** | Visualizador sintático e colorido para diffs do Git | `git-delta` | `dandavison.delta` | `git-delta` |
| **git-lfs** | Gerenciamento de arquivos grandes no Git | `git-lfs` | `GitHub.GitLFS` | `git-lfs` |
| **golang** | Linguagem de programação Go do Google | `golang` | `GoLang.Go` | `go` |
| **hermes-agent** | Agente de IA autônomo com suporte a skills canônicas (Nous Research) | `script` | `—` | `pipx` |
| **jq** | Processador de JSON flexível e leve para terminal | `jq` | `jqlang.jq` | `jq` |
| **lazydocker** | Interface TUI interativa completa para Docker e Docker Compose | `script` | `JesseDuffield.lazydocker` | `lazydocker` |
| **lazygit** | Interface TUI interativa completa para operações Git no terminal | `lazygit` | `JesseDuffield.lazygit` | `lazygit` |
| **mysql-client** | Utilitários e cliente de linha de comando para MySQL e MariaDB | `default-mysql-client` | `Oracle.MySQL` | `mysql-client` |
| **nodejs** | Runtime JavaScript via NVM (Node Version Manager LTS) | `script` | `OpenJS.NodeJS.LTS` | `node` |
| **ollama** | Execução local de modelos de IA e LLMs (Llama, DeepSeek, Qwen) | `script` | `Ollama.Ollama` | `ollama` |
| **pnpm** | Gerenciador de pacotes JavaScript rápido e com economia de espaço | `script` | `pnpm.pnpm` | `pnpm` |
| **postgresql-client** | Utilitários e cliente de linha de comando para PostgreSQL (psql, pg_dump) | `postgresql-client` | `PostgreSQL.PostgreSQL` | `libpq` |
| **python3-dev** | Headers do Python para compilar extensões em C/Rust | `python3-dev` | `—` | `—` |
| **python3-pip** | Gerenciador de pacotes padrão para bibliotecas Python | `python3-pip` | `Python.Python.3.12` | `python` |
| **python3-venv** | Ambientes virtuais isolados para desenvolvimento Python | `python3-venv` | `—` | `—` |
| **redis-tools** | Utilitários de linha de comando para bancos de dados Redis (redis-cli) | `redis-tools` | `Redis.Redis` | `redis` |
| **ripgrep** | Busca recursiva em arquivos ultra-rápida (rg) | `ripgrep` | `BurntSushi.ripgrep.MSVC` | `ripgrep` |
| **rustup** | Instalador e gerenciador da toolchain Rust e Cargo | `script` | `Rustlang.Rustup` | `rustup-init` |
| **sqlite3** | Mecanismo de banco de dados SQL embutido e CLI interativo | `sqlite3` | `SQLite.SQLite` | `sqlite` |
| **tmux** | Multiplexador de terminal com sessões persistentes | `tmux` | `—` | `tmux` |
| **uv** | Gerenciador de pacotes e projetos Python ultra-rápido em Rust | `script` | `astral-sh.uv` | `uv` |
| **zoxide** | Navegação rápida de diretórios aprendendo seus hábitos mais comuns (z) | `zoxide` | `ajeetdsouza.zoxide` | `zoxide` |

## DRIVER

| Pacote | Descrição | Linux | Windows | macOS |
|---|---|---|---|---|
| **nvidia-driver** | Driver proprietário NVIDIA com aceleração gráfica e CUDA | `nvidia-driver` | `—` | `—` |

## ENERGIA

| Pacote | Descrição | Linux | Windows | macOS |
|---|---|---|---|---|
| **auto-cpufreq** | Otimizador automático de frequência de CPU para economizar energia | `script` | `—` | `—` |
| **powertop** | Diagnóstico de consumo de energia e otimização de hardware | `powertop` | `—` | `—` |
| **tlp** | Otimizador avançado de gerenciamento de energia para notebooks | `tlp` | `—` | `—` |

## ESCRITORIO

| Pacote | Descrição | Linux | Windows | macOS |
|---|---|---|---|---|
| **dbeaver** | Ferramenta universal de administração de bancos de dados SQL/NoSQL | `dbeaver-ce` | `dbeaver.dbeaver` | `dbeaver-community` |
| **discord** | Plataforma de comunicação em equipe, voz e chat para comunidades | `discord` | `Discord.Discord` | `discord` |
| **libreoffice** | Suíte de produtividade para documentos, planilhas e apresentações | `libreoffice` | `TheDocumentFoundation.LibreOffice` | `libreoffice` |
| **onlyoffice** | Suíte de escritório compatível com formatos Microsoft Office | `onlyoffice-desktopeditors` | `ONLYOFFICE.DesktopEditors` | `onlyoffice` |
| **slack** | Plataforma de produtividade e comunicação corporativa | `slack-desktop` | `SlackTechnologies.Slack` | `slack` |
| **spotify** | Serviço de streaming de músicas, podcasts e áudio | `com.spotify.Client` | `Spotify.Spotify` | `spotify` |
| **telegram-desktop** | Mensageiro rápido, seguro e sincronizado na nuvem | `telegram-desktop` | `Telegram.TelegramDesktop` | `telegram` |
| **texlive-full** | Distribuição completa do LaTeX para CVs, artigos e relatórios | `texlive-full` | `MiKTeX.MiKTeX` | `mactex` |
| **zotero** | Gerenciador de referências bibliográficas e pesquisa científica | `zotero` | `DigitalScholar.Zotero` | `zotero` |

## FONTES

| Pacote | Descrição | Linux | Windows | macOS |
|---|---|---|---|---|
| **fonts** | Coleção de fontes essenciais (Inter, JetBrains Mono, Liberation, Noto Emoji) | `fonts-inter fonts-jetbrains-mono fonts-liberation fonts-noto-color-emoji fonts-freefont-ttf` | `—` | `—` |
| **nerd-fonts** | Fontes com glifos e ícones de desenvolvedor para terminal (JetBrains Mono NF) | `script` | `—` | `font-jetbrains-mono-nerd-font` |

## GPU

| Pacote | Descrição | Linux | Windows | macOS |
|---|---|---|---|---|
| **cuda-keyring** | Repositório oficial CUDA da NVIDIA para Debian/Ubuntu | `cuda-keyring` | `—` | `—` |
| **nvidia-driver** | Driver proprietário NVIDIA com aceleração gráfica e CUDA | `nvidia-driver` | `—` | `—` |
| **nvtop** | Monitor de processos e utilização de GPU no terminal (NVIDIA/AMD/Intel) | `nvtop` | `—` | `nvtop` |

## IA

| Pacote | Descrição | Linux | Windows | macOS |
|---|---|---|---|---|
| **antigravity-cli** | Google Antigravity CLI oficial para agentes autônomos | `script` | `—` | `agy` |
| **claude-code** | Ferramenta CLI de codificação agêntica da Anthropic no terminal | `script` | `—` | `node` |
| **cuda-keyring** | Repositório oficial CUDA da NVIDIA para Debian/Ubuntu | `cuda-keyring` | `—` | `—` |
| **hermes-agent** | Agente de IA autônomo com suporte a skills canônicas (Nous Research) | `script` | `—` | `pipx` |
| **ollama** | Execução local de modelos de IA e LLMs (Llama, DeepSeek, Qwen) | `script` | `Ollama.Ollama` | `ollama` |
| **open-webui** | Interface web interativa para Ollama e modelos locais de IA | `script` | `—` | `—` |

## INFRA

| Pacote | Descrição | Linux | Windows | macOS |
|---|---|---|---|---|
| **adguardhome** | DNS Sinkhole e bloqueador de anúncios para a rede local em Docker | `script` | `—` | `adguardhome` |
| **caddy** | Servidor web e proxy reverso moderno com HTTPS automático | `caddy` | `—` | `caddy` |
| **ctop** | Monitor de métricas e recursos de contêineres Docker em tempo real | `script` | `—` | `ctop` |
| **dive** | Analisador de camadas e eficiência de tamanho de imagens Docker | `script` | `wagoodman.dive` | `dive` |
| **docker** | Plataforma líder de contêineres e virtualização leve | `docker.io` | `Docker.DockerDesktop` | `docker` |
| **docker-compose** | Orquestração de múltiplos contêineres Docker via YAML | `docker-compose` | `—` | `—` |
| **filebrowser** | Gerenciador web leve de arquivos para servidores e estações | `script` | `FileBrowser.FileBrowser` | `filebrowser` |
| **lazydocker** | Interface TUI interativa completa para Docker e Docker Compose | `script` | `JesseDuffield.lazydocker` | `lazydocker` |
| **netdata** | Monitoramento de infraestrutura e hardware em tempo real | `script` | `—` | `—` |
| **ntfy** | Envio e recebimento de notificações push via linha de comando | `script` | `—` | `ntfy` |
| **open-webui** | Interface web interativa para Ollama e modelos locais de IA | `script` | `—` | `—` |
| **rclone** | Sincronizador de arquivos para múltiplos provedores de nuvem (S3, Drive) | `rclone` | `Rclone.Rclone` | `rclone` |
| **syncthing** | Sincronização contínua de arquivos P2P criptografada | `syncthing` | `Syncthing.Syncthing` | `syncthing` |
| **tailscale** | VPN Mesh privada segura baseada em WireGuard sem configuração | `script` | `tailscale.tailscale` | `tailscale` |
| **zerotier-one** | Rede privada virtual P2P para comunicação entre dispositivos | `script` | `ZeroTier.ZeroTierOne` | `zerotier-one` |

## JS

| Pacote | Descrição | Linux | Windows | macOS |
|---|---|---|---|---|
| **bun** | Runtime JavaScript & TypeScript tudo-em-um ultra-rápido | `script` | `Oven-sh.Bun` | `oven-sh/bun/bun` |
| **claude-code** | Ferramenta CLI de codificação agêntica da Anthropic no terminal | `script` | `—` | `node` |
| **nodejs** | Runtime JavaScript via NVM (Node Version Manager LTS) | `script` | `OpenJS.NodeJS.LTS` | `node` |
| **pnpm** | Gerenciador de pacotes JavaScript rápido e com economia de espaço | `script` | `pnpm.pnpm` | `pnpm` |

## LATEX

| Pacote | Descrição | Linux | Windows | macOS |
|---|---|---|---|---|
| **latexmk** | Automação e compilação contínua de documentos LaTeX | `latexmk` | `—` | `—` |
| **pandoc** | Conversor universal de documentos Markdown, PDF, LaTeX e DOCX | `pandoc` | `JohnMacFarlane.Pandoc` | `pandoc` |
| **texlive-full** | Distribuição completa do LaTeX para CVs, artigos e relatórios | `texlive-full` | `MiKTeX.MiKTeX` | `mactex` |
| **typst** | Novo sistema de diagramação moderno, rápido e poderoso | `script` | `Typst.Typst` | `typst` |

## LINUX-ONLY

| Pacote | Descrição | Linux | Windows | macOS |
|---|---|---|---|---|
| **kde-plasma-desktop** | Ambiente de desktop completo e personalizável KDE Plasma 6 | `kde-plasma-desktop` | `—` | `—` |
| **playonlinux** | Interface gráfica para gerenciamento de ambientes e jogos Wine | `playonlinux` | `—` | `—` |
| **sddm** | Gerenciador de display e login moderno para KDE | `sddm` | `—` | `—` |
| **wine** | Camada de compatibilidade para executar aplicativos Windows no Linux | `wine wine32` | `—` | `—` |
| **winetricks** | Utilitário para instalar bibliotecas e componentes runtime do Windows | `winetricks` | `—` | `—` |

## MIDIA

| Pacote | Descrição | Linux | Windows | macOS |
|---|---|---|---|---|
| **ffmpeg** | Conversão, streaming e processamento de áudio e vídeo | `ffmpeg` | `Gyan.FFmpeg` | `ffmpeg` |
| **ghostscript** | Interpretador para PostScript e motor de processamento PDF | `ghostscript` | `—` | `ghostscript` |
| **kdenlive** | Editor de vídeo não-linear poderoso e de código aberto | `kdenlive` | `KDE.Kdenlive` | `kdenlive` |
| **obs-studio** | Software de gravação de tela e transmissão ao vivo de alta performance | `obs-studio` | `OBSProject.OBSStudio` | `obs-studio` |
| **spotify** | Serviço de streaming de músicas, podcasts e áudio | `com.spotify.Client` | `Spotify.Spotify` | `spotify` |
| **vlc** | Reprodutor multimídia universal para todos os formatos de mídia | `vlc` | `VideoLAN.VLC` | `vlc` |

## MONITORAMENTO

| Pacote | Descrição | Linux | Windows | macOS |
|---|---|---|---|---|
| **btop** | Monitor de recursos e hardware estético com gráficos | `btop` | `aristocratos.btop4win` | `btop` |
| **ctop** | Monitor de métricas e recursos de contêineres Docker em tempo real | `script` | `—` | `ctop` |
| **duf** | Visualizador moderno e intuitivo de partições e espaço em disco | `duf` | `muesli.duf` | `duf` |
| **fastfetch** | Informações elegantes do sistema e hardware no terminal | `fastfetch` | `Fastfetch-cli.Fastfetch` | `fastfetch` |
| **glances** | Monitor de hardware e métricas no terminal e navegador | `glances` | `NicolasHennion.Glances` | `glances` |
| **htop** | Monitor interativo de processos no terminal | `htop` | `—` | `htop` |
| **lm-sensors** | Utilitário para leitura de sensores de temperatura, fans e voltagens | `lm-sensors` | `—` | `—` |
| **ncdu** | Analisador visual de ocupação de disco no terminal com navegação | `ncdu` | `YoranGrumich.ncdu` | `ncdu` |
| **netdata** | Monitoramento de infraestrutura e hardware em tempo real | `script` | `—` | `—` |
| **nvtop** | Monitor de processos e utilização de GPU no terminal (NVIDIA/AMD/Intel) | `nvtop` | `—` | `nvtop` |
| **powertop** | Diagnóstico de consumo de energia e otimização de hardware | `powertop` | `—` | `—` |
| **smartmontools** | Ferramentas de diagnóstico e integridade S.M.A.R.T. de discos | `smartmontools` | `smartmontools.smartmontools` | `smartmontools` |

## NAVEGADOR

| Pacote | Descrição | Linux | Windows | macOS |
|---|---|---|---|---|
| **brave-browser** | Navegador focado em privacidade com bloqueio nativo de rastreadores | `brave-browser` | `Brave.Brave` | `brave-browser` |
| **chromium** | Navegador web Chromium de código aberto | `chromium` | `Hibbiki.Chromium` | `eloston-chromium` |
| **firefox** | Navegador web Mozilla Firefox | `firefox-esr` | `Mozilla.Firefox` | `firefox` |
| **google-chrome** | Navegador web Google Chrome | `google-chrome-stable` | `Google.Chrome` | `google-chrome` |

## NOTAS

| Pacote | Descrição | Linux | Windows | macOS |
|---|---|---|---|---|
| **obsidian** | Aplicativo de notas e base de conhecimento em Markdown | `obsidian` | `Obsidian.Obsidian` | `obsidian` |
| **zotero** | Gerenciador de referências bibliográficas e pesquisa científica | `zotero` | `DigitalScholar.Zotero` | `zotero` |

## PDF

| Pacote | Descrição | Linux | Windows | macOS |
|---|---|---|---|---|
| **ghostscript** | Interpretador para PostScript e motor de processamento PDF | `ghostscript` | `—` | `ghostscript` |
| **poppler-utils** | Utilitários para extração e manipulação de arquivos PDF (pdftotext) | `poppler-utils` | `—` | `poppler` |

## PRODUTIVIDADE

| Pacote | Descrição | Linux | Windows | macOS |
|---|---|---|---|---|
| **libreoffice** | Suíte de produtividade para documentos, planilhas e apresentações | `libreoffice` | `TheDocumentFoundation.LibreOffice` | `libreoffice` |
| **obsidian** | Aplicativo de notas e base de conhecimento em Markdown | `obsidian` | `Obsidian.Obsidian` | `obsidian` |
| **onlyoffice** | Suíte de escritório compatível com formatos Microsoft Office | `onlyoffice-desktopeditors` | `ONLYOFFICE.DesktopEditors` | `onlyoffice` |

## PYTHON

| Pacote | Descrição | Linux | Windows | macOS |
|---|---|---|---|---|
| **hermes-agent** | Agente de IA autônomo com suporte a skills canônicas (Nous Research) | `script` | `—` | `pipx` |
| **python3-dev** | Headers do Python para compilar extensões em C/Rust | `python3-dev` | `—` | `—` |
| **python3-pip** | Gerenciador de pacotes padrão para bibliotecas Python | `python3-pip` | `Python.Python.3.12` | `python` |
| **python3-venv** | Ambientes virtuais isolados para desenvolvimento Python | `python3-venv` | `—` | `—` |
| **uv** | Gerenciador de pacotes e projetos Python ultra-rápido em Rust | `script` | `astral-sh.uv` | `uv` |

## REDE

| Pacote | Descrição | Linux | Windows | macOS |
|---|---|---|---|---|
| **adguardhome** | DNS Sinkhole e bloqueador de anúncios para a rede local em Docker | `script` | `—` | `adguardhome` |
| **dnsutils** | Utilitários para diagnósticos e consultas DNS (dig, nslookup) | `dnsutils` | `—` | `bind` |
| **gping** | Ping com gráfico gráfico de latência em tempo real no terminal | `gping` | `orf.gping` | `gping` |
| **iproute2** | Coleção moderna de controle de rede no Linux (ip, ss, bridge) | `iproute2` | `—` | `—` |
| **net-tools** | Utilitários clássicos de controle de rede (ifconfig, netstat, arp) | `net-tools` | `—` | `—` |
| **nftables** | Framework moderno de filtragem de pacotes do kernel Linux | `nftables` | `—` | `—` |
| **nmap** | Scanner de portas de rede e auditoria de segurança | `nmap` | `Insecure.Nmap` | `nmap` |
| **rclone** | Sincronizador de arquivos para múltiplos provedores de nuvem (S3, Drive) | `rclone` | `Rclone.Rclone` | `rclone` |
| **samba** | Servidor e cliente para compartilhamento de arquivos SMB/CIFS | `samba` | `—` | `—` |
| **syncthing** | Sincronização contínua de arquivos P2P criptografada | `syncthing` | `Syncthing.Syncthing` | `syncthing` |
| **tailscale** | VPN Mesh privada segura baseada em WireGuard sem configuração | `script` | `tailscale.tailscale` | `tailscale` |
| **traceroute** | Rastreamento de rota de pacotes na rede IP | `traceroute` | `—` | `traceroute` |
| **ufw** | Firewall descomplicado para gerenciamento de portas | `ufw` | `—` | `—` |
| **wireguard** | VPN de alta performance, moderna e extremamente segura | `wireguard wireguard-tools` | `WireGuard.WireGuard` | `wireguard-tools` |
| **zerotier-one** | Rede privada virtual P2P para comunicação entre dispositivos | `script` | `ZeroTier.ZeroTierOne` | `zerotier-one` |

## SECURITY

| Pacote | Descrição | Linux | Windows | macOS |
|---|---|---|---|---|
| **adguardhome** | DNS Sinkhole e bloqueador de anúncios para a rede local em Docker | `script` | `—` | `adguardhome` |
| **nftables** | Framework moderno de filtragem de pacotes do kernel Linux | `nftables` | `—` | `—` |
| **nmap** | Scanner de portas de rede e auditoria de segurança | `nmap` | `Insecure.Nmap` | `nmap` |
| **tailscale** | VPN Mesh privada segura baseada em WireGuard sem configuração | `script` | `tailscale.tailscale` | `tailscale` |
| **ufw** | Firewall descomplicado para gerenciamento de portas | `ufw` | `—` | `—` |
| **wireguard** | VPN de alta performance, moderna e extremamente segura | `wireguard wireguard-tools` | `WireGuard.WireGuard` | `wireguard-tools` |
| **zerotier-one** | Rede privada virtual P2P para comunicação entre dispositivos | `script` | `ZeroTier.ZeroTierOne` | `zerotier-one` |

## SYSADMIN

| Pacote | Descrição | Linux | Windows | macOS |
|---|---|---|---|---|
| **auto-cpufreq** | Otimizador automático de frequência de CPU para economizar energia | `script` | `—` | `—` |
| **btop** | Monitor de recursos e hardware estético com gráficos | `btop` | `aristocratos.btop4win` | `btop` |
| **caddy** | Servidor web e proxy reverso moderno com HTTPS automático | `caddy` | `—` | `caddy` |
| **ctop** | Monitor de métricas e recursos de contêineres Docker em tempo real | `script` | `—` | `ctop` |
| **dnsutils** | Utilitários para diagnósticos e consultas DNS (dig, nslookup) | `dnsutils` | `—` | `bind` |
| **docker** | Plataforma líder de contêineres e virtualização leve | `docker.io` | `Docker.DockerDesktop` | `docker` |
| **duf** | Visualizador moderno e intuitivo de partições e espaço em disco | `duf` | `muesli.duf` | `duf` |
| **filebrowser** | Gerenciador web leve de arquivos para servidores e estações | `script` | `FileBrowser.FileBrowser` | `filebrowser` |
| **glances** | Monitor de hardware e métricas no terminal e navegador | `glances` | `NicolasHennion.Glances` | `glances` |
| **gping** | Ping com gráfico gráfico de latência em tempo real no terminal | `gping` | `orf.gping` | `gping` |
| **htop** | Monitor interativo de processos no terminal | `htop` | `—` | `htop` |
| **iproute2** | Coleção moderna de controle de rede no Linux (ip, ss, bridge) | `iproute2` | `—` | `—` |
| **lm-sensors** | Utilitário para leitura de sensores de temperatura, fans e voltagens | `lm-sensors` | `—` | `—` |
| **ncdu** | Analisador visual de ocupação de disco no terminal com navegação | `ncdu` | `YoranGrumich.ncdu` | `ncdu` |
| **net-tools** | Utilitários clássicos de controle de rede (ifconfig, netstat, arp) | `net-tools` | `—` | `—` |
| **netdata** | Monitoramento de infraestrutura e hardware em tempo real | `script` | `—` | `—` |
| **nftables** | Framework moderno de filtragem de pacotes do kernel Linux | `nftables` | `—` | `—` |
| **nmap** | Scanner de portas de rede e auditoria de segurança | `nmap` | `Insecure.Nmap` | `nmap` |
| **powertop** | Diagnóstico de consumo de energia e otimização de hardware | `powertop` | `—` | `—` |
| **rsync** | Transferência e sincronização incremental rápida de arquivos | `rsync` | `—` | `rsync` |
| **samba** | Servidor e cliente para compartilhamento de arquivos SMB/CIFS | `samba` | `—` | `—` |
| **smartmontools** | Ferramentas de diagnóstico e integridade S.M.A.R.T. de discos | `smartmontools` | `smartmontools.smartmontools` | `smartmontools` |
| **tlp** | Otimizador avançado de gerenciamento de energia para notebooks | `tlp` | `—` | `—` |
| **traceroute** | Rastreamento de rota de pacotes na rede IP | `traceroute` | `—` | `traceroute` |
| **ufw** | Firewall descomplicado para gerenciamento de portas | `ufw` | `—` | `—` |
| **wireguard** | VPN de alta performance, moderna e extremamente segura | `wireguard wireguard-tools` | `WireGuard.WireGuard` | `wireguard-tools` |

## TEMA

| Pacote | Descrição | Linux | Windows | macOS |
|---|---|---|---|---|
| **alacritty** | Emulador de terminal acelerado por GPU com foco em performance | `alacritty` | `Alacritty.Alacritty` | `alacritty` |
| **kitty** | Emulador de terminal rápido e extensível baseado em GPU | `kitty` | `kovidgoyal.kitty` | `kitty` |
| **papirus-icon-theme** | Pacote de ícones SVG elegante para desktops Linux | `papirus-icon-theme` | `—` | `—` |
| **plank** | Dock leve e elegante estilo macOS para desktops XFCE/GNOME | `plank` | `—` | `—` |
| **qt-style-kvantum** | Motor de temas baseado em SVG para aplicativos Qt/KDE | `qt-style-kvantum` | `—` | `—` |
| **starship** | Prompt customizável e rápido para qualquer shell (Bash, Zsh, PowerShell) | `script` | `Starship.Starship` | `starship` |

## VIDEO

| Pacote | Descrição | Linux | Windows | macOS |
|---|---|---|---|---|
| **ffmpeg** | Conversão, streaming e processamento de áudio e vídeo | `ffmpeg` | `Gyan.FFmpeg` | `ffmpeg` |
| **kdenlive** | Editor de vídeo não-linear poderoso e de código aberto | `kdenlive` | `KDE.Kdenlive` | `kdenlive` |
| **obs-studio** | Software de gravação de tela e transmissão ao vivo de alta performance | `obs-studio` | `OBSProject.OBSStudio` | `obs-studio` |
| **vlc** | Reprodutor multimídia universal para todos os formatos de mídia | `vlc` | `VideoLAN.VLC` | `vlc` |

## WEB

| Pacote | Descrição | Linux | Windows | macOS |
|---|---|---|---|---|
| **caddy** | Servidor web e proxy reverso moderno com HTTPS automático | `caddy` | `—` | `caddy` |
| **open-webui** | Interface web interativa para Ollama e modelos locais de IA | `script` | `—` | `—` |
