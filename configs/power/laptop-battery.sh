#!/usr/bin/env bash
# ==============================================================================
# configs/power/laptop-battery.sh — Otimização de Bateria para Laptops (TLP / Powertop)
# ==============================================================================
set -euo pipefail

echo "🔋 Configurando Otimização de Bateria para Laptop..."

# 1. Habilitar TLP se instalado
if command -v tlp >/dev/null 2>&1; then
    echo "  Ativando serviço TLP..."
    sudo systemctl enable --now tlp 2>/dev/null || true
fi

# 2. Habilitar auto-cpufreq se instalado
if command -v auto-cpufreq >/dev/null 2>&1; then
    echo "  Ativando serviço auto-cpufreq..."
    sudo systemctl enable --now auto-cpufreq 2>/dev/null || true
fi

# 3. Desmascarar suspensão no systemd caso estivesse em modo server
if command -v systemctl >/dev/null 2>&1; then
    sudo systemctl unmask sleep.target suspend.target hibernate.target hybrid-sleep.target 2>/dev/null || true
fi

# 4. Configurar GNOME para suspender em inatividade na bateria
if command -v gsettings >/dev/null 2>&1; then
    gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-type 'suspend' 2>/dev/null || true
    gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-timeout 900 2>/dev/null || true
fi

echo "✔ Otimização de bateria configurada com sucesso!"
