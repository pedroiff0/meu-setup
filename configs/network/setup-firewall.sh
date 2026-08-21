#!/usr/bin/env bash
# ==============================================================================
# configs/network/setup-firewall.sh — Configuração de Firewall UFW
# ==============================================================================
set -euo pipefail

echo "🔒 Configurando Firewall do Sistema (UFW)..."

if command -v ufw >/dev/null 2>&1; then
    echo "  Configurando políticas padrão do UFW..."
    sudo ufw default deny incoming
    sudo ufw default allow outgoing
    sudo ufw allow 22/tcp comment 'SSH'
    sudo ufw allow 80/tcp comment 'HTTP'
    sudo ufw allow 443/tcp comment 'HTTPS'
    sudo ufw allow 53 comment 'DNS (AdGuard)'
    sudo ufw allow 8085/tcp comment 'AdGuard Web'
    sudo ufw --force enable
    echo "✔ Firewall UFW configurado e ativo!"
else
    echo "⚠️  UFW não instalado. Instale o pacote 'ufw' para gerenciar o firewall."
fi
