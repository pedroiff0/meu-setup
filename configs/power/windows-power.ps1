# ==============================================================================
# configs/power/windows-power.ps1 — Power & Sleep Tweaks for Windows
# ==============================================================================
param([switch]$ServerMode, [switch]$LaptopMode)

Write-Host "⚡ Configurando Gerenciamento de Energia no Windows..." -ForegroundColor Cyan

if ($ServerMode -or (-not $LaptopMode)) {
    Write-Host "  Ativando modo Servidor 24/7 (Desativa suspensão na tomada)..." -ForegroundColor Yellow
    powercfg /change standby-timeout-ac 0
    powercfg /change monitor-timeout-ac 30
    powercfg /change hibernate-timeout-ac 0
} else {
    Write-Host "  Ativando modo Laptop Econômico..." -ForegroundColor Green
    powercfg /change standby-timeout-dc 15
    powercfg /change monitor-timeout-dc 5
    powercfg /change hibernate-timeout-dc 60
}

Write-Host "✔ Configuração de energia do Windows concluída!" -ForegroundColor Green
