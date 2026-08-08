# install.ps1 — GERADO por tools/gen.py, nao edite a mao.
# Repopula um Windows usando winget.
#   powershell -ExecutionPolicy Bypass -File .\windows\install.ps1
#   powershell -ExecutionPolicy Bypass -File .\windows\install.ps1 -DryRun

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

Install-App 'Git.Git' 'git' 'Controle de versão'
Install-App 'GitHub.GitLFS' 'git-lfs' 'Arquivos grandes no git'
Install-App 'GitHub.cli' 'gh' 'GitHub CLI'
Install-App 'cURL.cURL' 'curl' 'Transferência HTTP na linha de comando'
Install-App 'BurntSushi.ripgrep.MSVC' 'ripgrep' 'Busca em arquivos ultra-rápida (rg)'
Install-App 'Python.Python.3.12' 'python3-pip' 'Gerenciador de pacotes Python'
Install-App 'OpenJS.NodeJS.LTS' 'nodejs' 'Runtime JavaScript (via nvm, versão LTS)'
Install-App 'Docker.DockerDesktop' 'docker' 'Containers'
Install-App 'tailscale.tailscale' 'tailscale' 'VPN mesh'
Install-App 'Syncthing.Syncthing' 'syncthing' 'Sincronização de arquivos P2P'
Install-App 'Ollama.Ollama' 'ollama' 'Rodar LLMs localmente'
Install-App 'Google.Chrome' 'google-chrome' 'Navegador Chrome'
Install-App 'Mozilla.Firefox' 'firefox' 'Navegador Firefox'
Install-App 'Obsidian.Obsidian' 'obsidian' 'Notas em Markdown / vault'
Install-App 'TheDocumentFoundation.LibreOffice' 'libreoffice' 'Suíte de escritório'
Install-App 'ONLYOFFICE.DesktopEditors' 'onlyoffice' 'Editor compatível com MS Office'
Install-App 'MiKTeX.MiKTeX' 'texlive-full' 'Distribuição LaTeX completa (CV, artigos)'
Install-App 'Gyan.FFmpeg' 'ffmpeg' 'Conversão de áudio e vídeo'
Install-App 'Inkscape.Inkscape' 'inkscape' 'Editor de vetores SVG'
Install-App 'GIMP.GIMP' 'gimp' 'Editor de imagens'

Write-Host 'Concluido.' -ForegroundColor Green
