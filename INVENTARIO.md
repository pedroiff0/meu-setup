# Inventário de programas

Gerado por `tools/gen.py` a partir de `packages.yaml`.

| Programa | Descrição | Grupos | Linux | Windows | macOS |
|---|---|---|---|---|---|
| **build-essential** | Compiladores e headers de C/C++ (gcc, g++, make) | base, dev | `build-essential` | `—` | `—` |
| **git** | Controle de versão distribuído | base, dev, cli | `git` | `Git.Git` | `git` |
| **git-lfs** | Gerenciamento de arquivos grandes no Git | dev, cli | `git-lfs` | `GitHub.GitLFS` | `git-lfs` |
| **gh** | GitHub CLI oficial para issues, PRs e repositórios | base, dev, cli | `gh` | `GitHub.cli` | `gh` |
| **curl** | Transferência HTTP/HTTPS na linha de comando | base, cli | `curl` | `cURL.cURL` | `curl` |
| **wget** | Downloader não-interativo de arquivos web | base, cli | `wget` | `—` | `wget` |
| **jq** | Processador de JSON flexível e leve para terminal | base, cli, dev | `jq` | `jqlang.jq` | `jq` |
| **tree** | Visualizador de estrutura de diretórios em árvore | base, cli | `tree` | `GnuWin32.Tree` | `tree` |
| **ripgrep** | Busca recursiva em arquivos ultra-rápida (rg) | base, dev, cli | `ripgrep` | `BurntSushi.ripgrep.MSVC` | `ripgrep` |
| **fd-find** | Alternativa simples, rápida e intuitiva ao find (fd) | base, dev, cli | `fd-find` | `sharkdp.fd` | `fd` |
| **htop** | Monitor interativo de processos no terminal | base, sysadmin, monitoramento, cli | `htop` | `—` | `htop` |
| **btop** | Monitor de recursos e hardware estético com gráficos | sysadmin, monitoramento, cli | `btop` | `aristocratos.btop4win` | `btop` |
| **tmux** | Multiplexador de terminal com sessões persistentes | base, dev, cli | `tmux` | `—` | `tmux` |
| **nano** | Editor de texto simples e direto no terminal | base, cli | `nano` | `GNU.Nano` | `nano` |
| **zip** | Utilitário de compactação e descompactação zip/unzip | base, arquivos, cli | `zip unzip` | `7zip.7zip` | `zip` |
| **xclip** | Integração da linha de comando com clipboard (X11) | base, cli | `xclip` | `—` | `—` |
| **ufw** | Firewall descomplicado para gerenciamento de portas | sysadmin, security, rede | `ufw` | `—` | `—` |
| **samba** | Servidor e cliente para compartilhamento de arquivos SMB/CIFS | sysadmin, rede, arquivos | `samba` | `—` | `—` |
| **nftables** | Framework moderno de filtragem de pacotes do kernel Linux | sysadmin, rede, security | `nftables` | `—` | `—` |
| **python3-dev** | Headers do Python para compilar extensões em C/Rust | dev, python | `python3-dev` | `—` | `—` |
| **python3-pip** | Gerenciador de pacotes padrão para bibliotecas Python | dev, python, cli | `python3-pip` | `Python.Python.3.12` | `python` |
| **python3-venv** | Ambientes virtuais isolados para desenvolvimento Python | dev, python | `python3-venv` | `—` | `—` |
| **uv** | Gerenciador de pacotes e projetos Python ultra-rápido em Rust | dev, python, cli | `script` | `astral-sh.uv` | `uv` |
| **nodejs** | Runtime JavaScript via NVM (Node Version Manager LTS) | dev, js | `script` | `OpenJS.NodeJS.LTS` | `node` |
| **pnpm** | Gerenciador de pacotes JavaScript rápido e com economia de espaço | dev, js, cli | `script` | `pnpm.pnpm` | `pnpm` |
| **bun** | Runtime JavaScript & TypeScript tudo-em-um ultra-rápido | dev, js, cli | `script` | `Oven-sh.Bun` | `oven-sh/bun/bun` |
| **rustup** | Instalador e gerenciador da toolchain Rust e Cargo | dev, cli | `script` | `Rustlang.Rustup` | `rustup-init` |
| **golang** | Linguagem de programação Go do Google | dev, cli | `golang` | `GoLang.Go` | `go` |
| **docker** | Plataforma líder de contêineres e virtualização leve | dev, infra, sysadmin | `docker.io` | `Docker.DockerDesktop` | `docker` |
| **docker-compose** | Orquestração de múltiplos contêineres Docker via YAML | dev, infra, cli | `docker-compose` | `—` | `—` |
| **caddy** | Servidor web e proxy reverso moderno com HTTPS automático | infra, web, sysadmin | `caddy` | `—` | `caddy` |
| **tailscale** | VPN Mesh privada segura baseada em WireGuard sem configuração | rede, infra, security | `script` | `tailscale.tailscale` | `tailscale` |
| **syncthing** | Sincronização contínua de arquivos P2P criptografada | infra, arquivos, rede | `syncthing` | `Syncthing.Syncthing` | `syncthing` |
| **netdata** | Monitoramento de infraestrutura e hardware em tempo real | sysadmin, monitoramento, infra | `script` | `—` | `—` |
| **ollama** | Execução local de modelos de IA e LLMs (Llama, DeepSeek, Qwen) | ia, dev, cli | `script` | `Ollama.Ollama` | `ollama` |
| **open-webui** | Interface web interativa para Ollama e modelos locais de IA | ia, web, infra | `script` | `—` | `—` |
| **nvidia-driver** | Driver proprietário NVIDIA com aceleração gráfica e CUDA | gpu, driver | `nvidia-driver` | `—` | `—` |
| **cuda-keyring** | Repositório oficial CUDA da NVIDIA para Debian/Ubuntu | gpu, ia, dev | `cuda-keyring` | `—` | `—` |
| **nvtop** | Monitor de processos e utilização de GPU no terminal (NVIDIA/AMD/Intel) | gpu, monitoramento, cli | `nvtop` | `—` | `nvtop` |
| **lm-sensors** | Utilitário para leitura de sensores de temperatura, fans e voltagens | sysadmin, monitoramento, cli | `lm-sensors` | `—` | `—` |
| **smartmontools** | Ferramentas de diagnóstico e integridade S.M.A.R.T. de discos | sysadmin, monitoramento, cli | `smartmontools` | `smartmontools.smartmontools` | `smartmontools` |
| **tlp** | Otimizador avançado de gerenciamento de energia para notebooks | energia, sysadmin | `tlp` | `—` | `—` |
| **powertop** | Diagnóstico de consumo de energia e otimização de hardware | energia, monitoramento, sysadmin | `powertop` | `—` | `—` |
| **auto-cpufreq** | Otimizador automático de frequência de CPU para economizar energia | energia, sysadmin | `script` | `—` | `—` |
| **google-chrome** | Navegador web Google Chrome | navegador | `google-chrome-stable` | `Google.Chrome` | `google-chrome` |
| **firefox** | Navegador web Mozilla Firefox | navegador | `firefox-esr` | `Mozilla.Firefox` | `firefox` |
| **brave-browser** | Navegador focado em privacidade com bloqueio nativo de rastreadores | navegador | `brave-browser` | `Brave.Brave` | `brave-browser` |
| **chromium** | Navegador web Chromium de código aberto | navegador | `chromium` | `Hibbiki.Chromium` | `eloston-chromium` |
| **obsidian** | Aplicativo de notas e base de conhecimento em Markdown | notas, produtividade | `obsidian` | `Obsidian.Obsidian` | `obsidian` |
| **libreoffice** | Suíte de produtividade para documentos, planilhas e apresentações | escritorio, produtividade | `libreoffice` | `TheDocumentFoundation.LibreOffice` | `libreoffice` |
| **onlyoffice** | Suíte de escritório compatível com formatos Microsoft Office | escritorio, produtividade | `onlyoffice-desktopeditors` | `ONLYOFFICE.DesktopEditors` | `onlyoffice` |
| **texlive-full** | Distribuição completa do LaTeX para CVs, artigos e relatórios | latex, academic, escritorio | `texlive-full` | `MiKTeX.MiKTeX` | `mactex` |
| **latexmk** | Automação e compilação contínua de documentos LaTeX | latex, academic, cli | `latexmk` | `—` | `—` |
| **typst** | Novo sistema de diagramação moderno, rápido e poderoso | latex, academic, cli | `script` | `Typst.Typst` | `typst` |
| **pandoc** | Conversor universal de documentos Markdown, PDF, LaTeX e DOCX | latex, academic, cli | `pandoc` | `JohnMacFarlane.Pandoc` | `pandoc` |
| **zotero** | Gerenciador de referências bibliográficas e pesquisa científica | academic, escritorio, notas | `zotero` | `DigitalScholar.Zotero` | `zotero` |
| **ffmpeg** | Conversão, streaming e processamento de áudio e vídeo | midia, video, cli | `ffmpeg` | `Gyan.FFmpeg` | `ffmpeg` |
| **inkscape** | Editor profissional de ilustrações vetoriais SVG | design, creative | `inkscape` | `Inkscape.Inkscape` | `inkscape` |
| **gimp** | Editor avançado de manipulação e retoque de imagens raster | design, creative | `gimp` | `GIMP.GIMP` | `gimp` |
| **vlc** | Reprodutor multimídia universal para todos os formatos de mídia | midia, video | `vlc` | `VideoLAN.VLC` | `vlc` |
| **obs-studio** | Software de gravação de tela e transmissão ao vivo de alta performance | midia, video, creative | `obs-studio` | `OBSProject.OBSStudio` | `obs-studio` |
| **kdenlive** | Editor de vídeo não-linear poderoso e de código aberto | midia, video, creative | `kdenlive` | `KDE.Kdenlive` | `kdenlive` |
| **discord** | Plataforma de comunicação em equipe, voz e chat para comunidades | escritorio, comunicacao | `discord` | `Discord.Discord` | `discord` |
| **telegram-desktop** | Mensageiro rápido, seguro e sincronizado na nuvem | escritorio, comunicacao | `telegram-desktop` | `Telegram.TelegramDesktop` | `telegram` |
| **slack** | Plataforma de produtividade e comunicação corporativa | escritorio, comunicacao | `slack-desktop` | `SlackTechnologies.Slack` | `slack` |
| **spotify** | Serviço de streaming de músicas, podcasts e áudio | midia, escritorio | `com.spotify.Client` | `Spotify.Spotify` | `spotify` |
| **ghostscript** | Interpretador para PostScript e motor de processamento PDF | midia, pdf, cli | `ghostscript` | `—` | `ghostscript` |
| **poppler-utils** | Utilitários para extração e manipulação de arquivos PDF (pdftotext) | pdf, cli, academic | `poppler-utils` | `—` | `poppler` |
| **sqlite3** | Mecanismo de banco de dados SQL embutido e CLI interativo | dev, database, cli | `sqlite3` | `SQLite.SQLite` | `sqlite` |
| **postgresql-client** | Utilitários e cliente de linha de comando para PostgreSQL (psql, pg_dump) | dev, database, cli | `postgresql-client` | `PostgreSQL.PostgreSQL` | `libpq` |
| **mysql-client** | Utilitários e cliente de linha de comando para MySQL e MariaDB | dev, database, cli | `default-mysql-client` | `Oracle.MySQL` | `mysql-client` |
| **redis-tools** | Utilitários de linha de comando para bancos de dados Redis (redis-cli) | dev, database, cli | `redis-tools` | `Redis.Redis` | `redis` |
| **dbeaver** | Ferramenta universal de administração de bancos de dados SQL/NoSQL | dev, database, escritorio | `dbeaver-ce` | `dbeaver.dbeaver` | `dbeaver-community` |
| **wireguard** | VPN de alta performance, moderna e extremamente segura | rede, security, sysadmin | `wireguard wireguard-tools` | `WireGuard.WireGuard` | `wireguard-tools` |
| **nmap** | Scanner de portas de rede e auditoria de segurança | rede, security, sysadmin, cli | `nmap` | `Insecure.Nmap` | `nmap` |
| **rclone** | Sincronizador de arquivos para múltiplos provedores de nuvem (S3, Drive) | infra, arquivos, rede, cli | `rclone` | `Rclone.Rclone` | `rclone` |
| **rsync** | Transferência e sincronização incremental rápida de arquivos | base, sysadmin, arquivos, cli | `rsync` | `—` | `rsync` |
| **dnsutils** | Utilitários para diagnósticos e consultas DNS (dig, nslookup) | rede, sysadmin, cli | `dnsutils` | `—` | `bind` |
| **net-tools** | Utilitários clássicos de controle de rede (ifconfig, netstat, arp) | rede, sysadmin, cli | `net-tools` | `—` | `—` |
| **iproute2** | Coleção moderna de controle de rede no Linux (ip, ss, bridge) | rede, sysadmin, cli | `iproute2` | `—` | `—` |
| **traceroute** | Rastreamento de rota de pacotes na rede IP | rede, sysadmin, cli | `traceroute` | `—` | `traceroute` |
| **alacritty** | Emulador de terminal acelerado por GPU com foco em performance | desktop, tema | `alacritty` | `Alacritty.Alacritty` | `alacritty` |
| **kitty** | Emulador de terminal rápido e extensível baseado em GPU | desktop, tema | `kitty` | `kovidgoyal.kitty` | `kitty` |
| **kde-plasma-desktop** | Ambiente de desktop completo e personalizável KDE Plasma 6 | desktop, linux-only | `kde-plasma-desktop` | `—` | `—` |
| **sddm** | Gerenciador de display e login moderno para KDE | desktop, linux-only | `sddm` | `—` | `—` |
| **papirus-icon-theme** | Pacote de ícones SVG elegante para desktops Linux | desktop, tema | `papirus-icon-theme` | `—` | `—` |
| **qt-style-kvantum** | Motor de temas baseado em SVG para aplicativos Qt/KDE | desktop, tema | `qt-style-kvantum` | `—` | `—` |
| **plank** | Dock leve e elegante estilo macOS para desktops XFCE/GNOME | desktop, tema | `plank` | `—` | `—` |
| **fonts** | Coleção de fontes essenciais (Inter, JetBrains Mono, Liberation, Noto Emoji) | desktop, fontes | `fonts-inter fonts-jetbrains-mono fonts-liberation fonts-noto-color-emoji fonts-freefont-ttf` | `—` | `—` |
| **nerd-fonts** | Fontes com glifos e ícones de desenvolvedor para terminal (JetBrains Mono NF) | desktop, fontes | `script` | `—` | `font-jetbrains-mono-nerd-font` |
| **starship** | Prompt customizável e rápido para qualquer shell (Bash, Zsh, PowerShell) | cli, tema, desktop | `script` | `Starship.Starship` | `starship` |
| **wine** | Camada de compatibilidade para executar aplicativos Windows no Linux | compat, linux-only | `wine wine32` | `—` | `—` |
| **winetricks** | Utilitário para instalar bibliotecas e componentes runtime do Windows | compat, linux-only | `winetricks` | `—` | `—` |
| **playonlinux** | Interface gráfica para gerenciamento de ambientes e jogos Wine | compat, linux-only | `playonlinux` | `—` | `—` |
| **hermes-agent** | Agente de IA autônomo com suporte a skills canônicas (Nous Research) | ia, python, cli, dev | `script` | `—` | `pipx` |
| **claude-code** | Ferramenta CLI de codificação agêntica da Anthropic no terminal | ia, js, cli, dev | `script` | `—` | `node` |
| **antigravity-cli** | Google Antigravity CLI oficial para agentes autônomos | ia, cli, dev | `script` | `—` | `agy` |
| **fzf** | Fuzzy finder interativo para histórico, arquivos e comandos | cli, base, dev | `fzf` | `junegunn.fzf` | `fzf` |
| **bat** | Visualizador moderno de arquivos com sintaxe e integração Git | cli, dev | `bat` | `sharkdp.bat` | `bat` |
| **eza** | Substituto moderno para ls com ícones, cores, git e visão de árvore | cli, dev | `eza` | `eza-community.eza` | `eza` |
| **zoxide** | Navegação rápida de diretórios aprendendo seus hábitos mais comuns (z) | cli, dev | `zoxide` | `ajeetdsouza.zoxide` | `zoxide` |
| **git-delta** | Visualizador sintático e colorido para diffs do Git | dev, cli | `git-delta` | `dandavison.delta` | `git-delta` |
| **lazygit** | Interface TUI interativa completa para operações Git no terminal | dev, cli | `lazygit` | `JesseDuffield.lazygit` | `lazygit` |
| **lazydocker** | Interface TUI interativa completa para Docker e Docker Compose | dev, infra, cli | `script` | `JesseDuffield.lazydocker` | `lazydocker` |
| **yazi** | Gerenciador de arquivos rápido para terminal escrito em Rust | cli, arquivos | `script` | `sxyazi.yazi` | `yazi` |
| **glances** | Monitor de hardware e métricas no terminal e navegador | sysadmin, monitoramento, cli | `glances` | `NicolasHennion.Glances` | `glances` |
| **ctop** | Monitor de métricas e recursos de contêineres Docker em tempo real | sysadmin, infra, monitoramento, cli | `script` | `—` | `ctop` |
| **dive** | Analisador de camadas e eficiência de tamanho de imagens Docker | dev, infra, cli | `script` | `wagoodman.dive` | `dive` |
| **ncdu** | Analisador visual de ocupação de disco no terminal com navegação | sysadmin, monitoramento, cli | `ncdu` | `YoranGrumich.ncdu` | `ncdu` |
| **gping** | Ping com gráfico gráfico de latência em tempo real no terminal | rede, sysadmin, cli | `gping` | `orf.gping` | `gping` |
| **tealdeer** | Implementação ultrarrápida do tldr com exemplos práticos de comandos | cli, base | `tealdeer` | `dbrgn.tealdeer` | `tealdeer` |
| **duf** | Visualizador moderno e intuitivo de partições e espaço em disco | sysadmin, monitoramento, cli | `duf` | `muesli.duf` | `duf` |
| **fastfetch** | Informações elegantes do sistema e hardware no terminal | cli, desktop, monitoramento | `fastfetch` | `Fastfetch-cli.Fastfetch` | `fastfetch` |
| **filebrowser** | Gerenciador web leve de arquivos para servidores e estações | infra, arquivos, sysadmin | `script` | `FileBrowser.FileBrowser` | `filebrowser` |
| **ntfy** | Envio e recebimento de notificações push via linha de comando | infra, cli | `script` | `—` | `ntfy` |
| **zerotier-one** | Rede privada virtual P2P para comunicação entre dispositivos | rede, infra, security | `script` | `ZeroTier.ZeroTierOne` | `zerotier-one` |
| **adguardhome** | DNS Sinkhole e bloqueador de anúncios para a rede local em Docker | rede, security, infra | `script` | `—` | `adguardhome` |
