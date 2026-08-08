# Inventário de programas

Gerado por `tools/gen.py` a partir de `packages.yaml`.

| Programa | Descrição | Grupos | Linux | Windows | macOS |
|---|---|---|---|---|---|
| **build-essential** | Compiladores e headers de C/C++ | base, dev | `build-essential` | `—` | `—` |
| **git** | Controle de versão | base, dev | `git` | `Git.Git` | `git` |
| **git-lfs** | Arquivos grandes no git | dev | `git-lfs` | `GitHub.GitLFS` | `git-lfs` |
| **gh** | GitHub CLI | base, dev | `gh` | `GitHub.cli` | `gh` |
| **curl** | Transferência HTTP na linha de comando | base | `curl` | `cURL.cURL` | `curl` |
| **wget** | Downloader | base | `wget` | `—` | `wget` |
| **ripgrep** | Busca em arquivos ultra-rápida (rg) | base, dev | `ripgrep` | `BurntSushi.ripgrep.MSVC` | `ripgrep` |
| **htop** | Monitor de processos | base, sysadmin | `htop` | `—` | `htop` |
| **btop** | Monitor de recursos bonito | sysadmin | `btop` | `—` | `btop` |
| **tmux** | Multiplexador de terminal | base, dev | `tmux` | `—` | `tmux` |
| **nano** | Editor de texto simples | base | `nano` | `—` | `—` |
| **zip** | Compactação zip/unzip | base | `zip` | `—` | `—` |
| **xclip** | Clipboard pela CLI (X11) | base | `xclip` | `—` | `—` |
| **ufw** | Firewall simples | sysadmin, security | `ufw` | `—` | `—` |
| **samba** | Compartilhamento de arquivos SMB | sysadmin, rede | `samba` | `—` | `—` |
| **nftables** | Firewall do kernel | sysadmin, rede | `nftables` | `—` | `—` |
| **python3-dev** | Headers do Python para compilar extensões | dev, python | `python3-dev` | `—` | `—` |
| **python3-pip** | Gerenciador de pacotes Python | dev, python | `python3-pip` | `Python.Python.3.12` | `python` |
| **python3-venv** | Ambientes virtuais (Debian PEP 668) | dev, python | `python3-venv` | `—` | `—` |
| **nodejs** | Runtime JavaScript (via nvm, versão LTS) | dev, js | `script` | `OpenJS.NodeJS.LTS` | `node` |
| **docker** | Containers | dev, infra | `docker.io` | `Docker.DockerDesktop` | `docker` |
| **docker-compose** | Orquestração local de containers | dev, infra | `docker-compose` | `—` | `—` |
| **caddy** | Servidor web / reverse proxy com HTTPS automático | infra, web | `caddy` | `—` | `caddy` |
| **tailscale** | VPN mesh | rede, infra | `script` | `tailscale.tailscale` | `tailscale` |
| **syncthing** | Sincronização de arquivos P2P | infra, arquivos | `syncthing` | `Syncthing.Syncthing` | `syncthing` |
| **netdata** | Monitoramento em tempo real | sysadmin | `script` | `—` | `—` |
| **ollama** | Rodar LLMs localmente | ia | `script` | `Ollama.Ollama` | `ollama` |
| **nvidia-driver** | Driver proprietário NVIDIA (GTX 1660) | gpu, driver | `nvidia-driver` | `—` | `—` |
| **cuda-keyring** | Repositório CUDA da NVIDIA | gpu, ia | `cuda-keyring` | `—` | `—` |
| **google-chrome** | Navegador Chrome | navegador | `google-chrome-stable` | `Google.Chrome` | `google-chrome` |
| **firefox** | Navegador Firefox | navegador | `firefox-esr` | `Mozilla.Firefox` | `firefox` |
| **obsidian** | Notas em Markdown / vault | notas, produtividade | `obsidian` | `Obsidian.Obsidian` | `obsidian` |
| **libreoffice** | Suíte de escritório | escritorio | `libreoffice` | `TheDocumentFoundation.LibreOffice` | `libreoffice` |
| **onlyoffice** | Editor compatível com MS Office | escritorio | `onlyoffice-desktopeditors` | `ONLYOFFICE.DesktopEditors` | `onlyoffice` |
| **texlive-full** | Distribuição LaTeX completa (CV, artigos) | latex, escritorio | `texlive-full` | `MiKTeX.MiKTeX` | `mactex` |
| **latexmk** | Build automático de LaTeX | latex | `latexmk` | `—` | `—` |
| **ffmpeg** | Conversão de áudio e vídeo | midia | `ffmpeg` | `Gyan.FFmpeg` | `ffmpeg` |
| **inkscape** | Editor de vetores SVG | design | `inkscape` | `Inkscape.Inkscape` | `inkscape` |
| **gimp** | Editor de imagens | design | `gimp` | `GIMP.GIMP` | `gimp` |
| **ghostscript** | Processamento de PostScript/PDF | midia, pdf | `ghostscript` | `—` | `—` |
| **poppler-utils** | pdftotext, pdfimages e afins | pdf | `poppler-utils` | `—` | `poppler` |
| **kde-plasma-desktop** | Ambiente de desktop KDE Plasma 6 | desktop, linux-only | `kde-plasma-desktop` | `—` | `—` |
| **sddm** | Gerenciador de login do KDE | desktop, linux-only | `sddm` | `—` | `—` |
| **papirus-icon-theme** | Tema de ícones Papirus | desktop, tema | `papirus-icon-theme` | `—` | `—` |
| **qt-style-kvantum** | Motor de temas Qt (Kvantum) | desktop, tema | `qt-style-kvantum` | `—` | `—` |
| **plank** | Dock estilo macOS | desktop, tema | `plank` | `—` | `—` |
| **fonts** | Fontes (Inter, JetBrains Mono, Liberation, Noto Emoji) | desktop, fontes | `fonts-inter fonts-jetbrains-mono fonts-liberation fonts-noto-color-emoji fonts-freefont-ttf` | `—` | `—` |
| **wine** | Rodar programas Windows no Linux | compat, linux-only | `wine wine32` | `—` | `—` |
| **winetricks** | Utilitário de configuração do Wine | compat, linux-only | `winetricks` | `—` | `—` |
| **playonlinux** | Frontend para o Wine | compat, linux-only | `playonlinux` | `—` | `—` |
| **hermes-agent** | Agente Hermes (Nous Research) | ia, cli | `script` | `—` | `pipx` |
| **claude-code** | CLI de codificação da Anthropic | ia, cli, dev | `script` | `—` | `node` |
