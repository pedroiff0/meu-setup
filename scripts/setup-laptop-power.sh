#!/usr/bin/env bash
# ==============================================================================
# scripts/setup-laptop-power.sh — Otimizações de Bateria para Laptops
# ==============================================================================
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
bash "$ROOT_DIR/configs/power/laptop-battery.sh"
