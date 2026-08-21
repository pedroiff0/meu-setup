# ==============================================================================
# themes/devspace/install-devspace.ps1 — DevSpace Cosmic Theme for Windows
# ==============================================================================
param([switch]$DryRun)

Write-Host "🌌 Instalando Tema DevSpace no Windows (PowerShell & Windows Terminal)..." -ForegroundColor Magenta

# 1. Configurar perfil do PowerShell
$profileDir = Split-Path -Parent $PROFILE
if (-not (Test-Path $profileDir)) {
    New-Item -ItemType Directory -Path $profileDir -Force | Out-Null
}

$devspaceBlock = @"
# >>> DevSpace Cosmic Windows Terminal >>>
Write-Host "☕ Pedro DevSpace Windows Environment" -ForegroundColor Magenta
function prompt {
    `$hora = Get-Date -Format "HH:mm:ss"
    `$path = (Get-Location).Path
    Write-Host "`n☕ pedro " -NoNewline -ForegroundColor Magenta
    Write-Host "in " -NoNewline -ForegroundColor DarkGray
    Write-Host "`$path " -NoNewline -ForegroundColor Cyan
    Write-Host "[$hora]" -ForegroundColor Yellow
    return "❯ "
}

Set-Alias -Name lg -Value lazygit -ErrorAction SilentlyContinue
Set-Alias -Name ld -Value lazydocker -ErrorAction SilentlyContinue
Set-Alias -Name fetch -Value fastfetch -ErrorAction SilentlyContinue
# <<< DevSpace Cosmic Windows Terminal <<<
"@

if (Test-Path $PROFILE) {
    $currentProfile = Get-Content $PROFILE -Raw
    if ($currentProfile -notmatch "DevSpace Cosmic") {
        Add-Content -Path $PROFILE -Value "`n$devspaceBlock"
        Write-Host "  ✔ Perfil do PowerShell atualizado: $PROFILE" -ForegroundColor Green
    }
} else {
    Set-Content -Path $PROFILE -Value $devspaceBlock
    Write-Host "  ✔ Perfil do PowerShell criado: $PROFILE" -ForegroundColor Green
}

Write-Host "✔ DevSpace para Windows configurado com sucesso!" -ForegroundColor Green
