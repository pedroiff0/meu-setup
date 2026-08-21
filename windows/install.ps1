# ==============================================================================
# install.ps1 — GERADO por tools/gen.py, nao edite a mao.
# Repopula um ambiente Windows usando winget (Microsoft App Installer).
# Uso:
#   powershell -ExecutionPolicy Bypass -File .\windows\install.ps1
#   powershell -ExecutionPolicy Bypass -File .\windows\install.ps1 -DryRun
# ==============================================================================

param([switch]$DryRun)

if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {
    Write-Error 'winget nao encontrado. Instale o App Installer da Microsoft Store.'
    exit 1
}

function Install-App($Id, $Name, $Desc) {
    Write-Host "==> $Name  ($Desc)" -ForegroundColor Cyan
    $installed = winget list --id $Id --exact 2>$null | Select-String $Id
    if ($installed) { Write-Host '    ja instalado' -ForegroundColor DarkGray; return }
    if ($DryRun) { Write-Host "    [dry-run] winget install --id $Id" -ForegroundColor DarkGray; return }
    winget install --id $Id --exact --silent --accept-package-agreements --accept-source-agreements
}

Install-App 'Git.Git' 'git' 'Controle de versão distribuído'
Install-App 'GitHub.GitLFS' 'git-lfs' 'Gerenciamento de arquivos grandes no Git'
Install-App 'GitHub.cli' 'gh' 'GitHub CLI oficial para issues, PRs e repositórios'
Install-App 'cURL.cURL' 'curl' 'Transferência HTTP/HTTPS na linha de comando'
Install-App 'jqlang.jq' 'jq' 'Processador de JSON flexível e leve para terminal'
Install-App 'GnuWin32.Tree' 'tree' 'Visualizador de estrutura de diretórios em árvore'
Install-App 'BurntSushi.ripgrep.MSVC' 'ripgrep' 'Busca recursiva em arquivos ultra-rápida (rg)'
Install-App 'sharkdp.fd' 'fd-find' 'Alternativa simples, rápida e intuitiva ao find (fd)'
Install-App 'aristocratos.btop4win' 'btop' 'Monitor de recursos e hardware estético com gráficos'
Install-App 'GNU.Nano' 'nano' 'Editor de texto simples e direto no terminal'
Install-App '7zip.7zip' 'zip' 'Utilitário de compactação e descompactação zip/unzip'
Install-App 'Python.Python.3.12' 'python3-pip' 'Gerenciador de pacotes padrão para bibliotecas Python'
Install-App 'astral-sh.uv' 'uv' 'Gerenciador de pacotes e projetos Python ultra-rápido em Rust'
Install-App 'OpenJS.NodeJS.LTS' 'nodejs' 'Runtime JavaScript via NVM (Node Version Manager LTS)'
Install-App 'pnpm.pnpm' 'pnpm' 'Gerenciador de pacotes JavaScript rápido e com economia de espaço'
Install-App 'Oven-sh.Bun' 'bun' 'Runtime JavaScript & TypeScript tudo-em-um ultra-rápido'
Install-App 'Rustlang.Rustup' 'rustup' 'Instalador e gerenciador da toolchain Rust e Cargo'
Install-App 'GoLang.Go' 'golang' 'Linguagem de programação Go do Google'
Install-App 'Docker.DockerDesktop' 'docker' 'Plataforma líder de contêineres e virtualização leve'
Install-App 'tailscale.tailscale' 'tailscale' 'VPN Mesh privada segura baseada em WireGuard sem configuração'
Install-App 'Syncthing.Syncthing' 'syncthing' 'Sincronização contínua de arquivos P2P criptografada'
Install-App 'Ollama.Ollama' 'ollama' 'Execução local de modelos de IA e LLMs (Llama, DeepSeek, Qwen)'
Install-App 'smartmontools.smartmontools' 'smartmontools' 'Ferramentas de diagnóstico e integridade S.M.A.R.T. de discos'
Install-App 'Google.Chrome' 'google-chrome' 'Navegador web Google Chrome'
Install-App 'Mozilla.Firefox' 'firefox' 'Navegador web Mozilla Firefox'
Install-App 'Brave.Brave' 'brave-browser' 'Navegador focado em privacidade com bloqueio nativo de rastreadores'
Install-App 'Hibbiki.Chromium' 'chromium' 'Navegador web Chromium de código aberto'
Install-App 'Obsidian.Obsidian' 'obsidian' 'Aplicativo de notas e base de conhecimento em Markdown'
Install-App 'TheDocumentFoundation.LibreOffice' 'libreoffice' 'Suíte de produtividade para documentos, planilhas e apresentações'
Install-App 'ONLYOFFICE.DesktopEditors' 'onlyoffice' 'Suíte de escritório compatível com formatos Microsoft Office'
Install-App 'MiKTeX.MiKTeX' 'texlive-full' 'Distribuição completa do LaTeX para CVs, artigos e relatórios'
Install-App 'Typst.Typst' 'typst' 'Novo sistema de diagramação moderno, rápido e poderoso'
Install-App 'JohnMacFarlane.Pandoc' 'pandoc' 'Conversor universal de documentos Markdown, PDF, LaTeX e DOCX'
Install-App 'DigitalScholar.Zotero' 'zotero' 'Gerenciador de referências bibliográficas e pesquisa científica'
Install-App 'Gyan.FFmpeg' 'ffmpeg' 'Conversão, streaming e processamento de áudio e vídeo'
Install-App 'Inkscape.Inkscape' 'inkscape' 'Editor profissional de ilustrações vetoriais SVG'
Install-App 'GIMP.GIMP' 'gimp' 'Editor avançado de manipulação e retoque de imagens raster'
Install-App 'VideoLAN.VLC' 'vlc' 'Reprodutor multimídia universal para todos os formatos de mídia'
Install-App 'OBSProject.OBSStudio' 'obs-studio' 'Software de gravação de tela e transmissão ao vivo de alta performance'
Install-App 'KDE.Kdenlive' 'kdenlive' 'Editor de vídeo não-linear poderoso e de código aberto'
Install-App 'Discord.Discord' 'discord' 'Plataforma de comunicação em equipe, voz e chat para comunidades'
Install-App 'Telegram.TelegramDesktop' 'telegram-desktop' 'Mensageiro rápido, seguro e sincronizado na nuvem'
Install-App 'SlackTechnologies.Slack' 'slack' 'Plataforma de produtividade e comunicação corporativa'
Install-App 'Spotify.Spotify' 'spotify' 'Serviço de streaming de músicas, podcasts e áudio'
Install-App 'SQLite.SQLite' 'sqlite3' 'Mecanismo de banco de dados SQL embutido e CLI interativo'
Install-App 'PostgreSQL.PostgreSQL' 'postgresql-client' 'Utilitários e cliente de linha de comando para PostgreSQL (psql, pg_dump)'
Install-App 'Oracle.MySQL' 'mysql-client' 'Utilitários e cliente de linha de comando para MySQL e MariaDB'
Install-App 'Redis.Redis' 'redis-tools' 'Utilitários de linha de comando para bancos de dados Redis (redis-cli)'
Install-App 'dbeaver.dbeaver' 'dbeaver' 'Ferramenta universal de administração de bancos de dados SQL/NoSQL'
Install-App 'WireGuard.WireGuard' 'wireguard' 'VPN de alta performance, moderna e extremamente segura'
Install-App 'Insecure.Nmap' 'nmap' 'Scanner de portas de rede e auditoria de segurança'
Install-App 'Rclone.Rclone' 'rclone' 'Sincronizador de arquivos para múltiplos provedores de nuvem (S3, Drive)'
Install-App 'Alacritty.Alacritty' 'alacritty' 'Emulador de terminal acelerado por GPU com foco em performance'
Install-App 'kovidgoyal.kitty' 'kitty' 'Emulador de terminal rápido e extensível baseado em GPU'
Install-App 'Starship.Starship' 'starship' 'Prompt customizável e rápido para qualquer shell (Bash, Zsh, PowerShell)'
Install-App 'junegunn.fzf' 'fzf' 'Fuzzy finder interativo para histórico, arquivos e comandos'
Install-App 'sharkdp.bat' 'bat' 'Visualizador moderno de arquivos com sintaxe e integração Git'
Install-App 'eza-community.eza' 'eza' 'Substituto moderno para ls com ícones, cores, git e visão de árvore'
Install-App 'ajeetdsouza.zoxide' 'zoxide' 'Navegação rápida de diretórios aprendendo seus hábitos mais comuns (z)'
Install-App 'dandavison.delta' 'git-delta' 'Visualizador sintático e colorido para diffs do Git'
Install-App 'JesseDuffield.lazygit' 'lazygit' 'Interface TUI interativa completa para operações Git no terminal'
Install-App 'JesseDuffield.lazydocker' 'lazydocker' 'Interface TUI interativa completa para Docker e Docker Compose'
Install-App 'sxyazi.yazi' 'yazi' 'Gerenciador de arquivos rápido para terminal escrito em Rust'
Install-App 'NicolasHennion.Glances' 'glances' 'Monitor de hardware e métricas no terminal e navegador'
Install-App 'wagoodman.dive' 'dive' 'Analisador de camadas e eficiência de tamanho de imagens Docker'
Install-App 'YoranGrumich.ncdu' 'ncdu' 'Analisador visual de ocupação de disco no terminal com navegação'
Install-App 'orf.gping' 'gping' 'Ping com gráfico gráfico de latência em tempo real no terminal'
Install-App 'dbrgn.tealdeer' 'tealdeer' 'Implementação ultrarrápida do tldr com exemplos práticos de comandos'
Install-App 'muesli.duf' 'duf' 'Visualizador moderno e intuitivo de partições e espaço em disco'
Install-App 'Fastfetch-cli.Fastfetch' 'fastfetch' 'Informações elegantes do sistema e hardware no terminal'
Install-App 'FileBrowser.FileBrowser' 'filebrowser' 'Gerenciador web leve de arquivos para servidores e estações'
Install-App 'ZeroTier.ZeroTierOne' 'zerotier-one' 'Rede privada virtual P2P para comunicação entre dispositivos'

Write-Host 'Concluido com sucesso!' -ForegroundColor Green
