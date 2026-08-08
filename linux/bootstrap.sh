#!/usr/bin/env bash
# bootstrap.sh — ponto de entrada pós-formatação.
# Instala as dependências mínimas (git, python3, pyyaml) e chama o install.py.
#
#   bash <(curl -fsSL https://raw.githubusercontent.com/pedroiff0/meu-setup/main/linux/bootstrap.sh)
#
set -euo pipefail

REPO_URL="https://github.com/pedroiff0/meu-setup.git"
DEST="${MEU_SETUP_DIR:-$HOME/meu-setup}"

log() { printf '\033[36m==>\033[0m %s\n' "$*"; }

if command -v apt-get >/dev/null; then
  SUDO=""; [ "$(id -u)" -ne 0 ] && SUDO="sudo"
  log "Instalando dependências (apt)"
  $SUDO apt-get update -y
  $SUDO apt-get install -y git python3 python3-yaml curl
elif command -v dnf >/dev/null; then
  SUDO=""; [ "$(id -u)" -ne 0 ] && SUDO="sudo"
  log "Instalando dependências (dnf)"
  $SUDO dnf install -y git python3 python3-pyyaml curl
elif command -v pacman >/dev/null; then
  SUDO=""; [ "$(id -u)" -ne 0 ] && SUDO="sudo"
  log "Instalando dependências (pacman)"
  $SUDO pacman -Sy --noconfirm --needed git python python-yaml curl
elif command -v zypper >/dev/null; then
  SUDO=""; [ "$(id -u)" -ne 0 ] && SUDO="sudo"
  log "Instalando dependências (zypper)"
  $SUDO zypper --non-interactive install git python3 python3-PyYAML curl
else
  echo "Gerenciador de pacotes não suportado." >&2
  exit 1
fi

if [ -d "$DEST/.git" ]; then
  log "Atualizando $DEST"
  git -C "$DEST" pull --ff-only
else
  log "Clonando em $DEST"
  git clone "$REPO_URL" "$DEST"
fi

log "Rodando o instalador (dry-run primeiro)"
python3 "$DEST/linux/install.py" --dry-run | tail -30

echo
log "Para instalar de verdade:  python3 $DEST/linux/install.py"
log "Ou por grupo:              python3 $DEST/linux/install.py --group base --group dev"
