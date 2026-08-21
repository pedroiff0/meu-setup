#!/usr/bin/env bash
# DevSpace — animacao de campo estelar em ANSI puro.
#
# Sem dependencias (sem lolcat/cmatrix). Usa truecolor + cursor invisivel.
# Encerra com qualquer tecla, Ctrl+C, ou apos DS_DUR segundos (default 4).
#
# Uso:
#   devspace-stars.sh            -> 4 segundos
#   DS_DUR=10 devspace-stars.sh  -> 10 segundos
#   devspace-stars.sh --boot     -> 1.2s, para tela de inicializacao
set -u

[ -t 1 ] || exit 0
. "$HOME/.config/devspace/palette.sh" 2>/dev/null || exit 0

DUR="${DS_DUR:-4}"
[ "${1:-}" = "--boot" ] && DUR=1.2

L=$(tput cols 2>/dev/null || echo 80)
A=$(tput lines 2>/dev/null || echo 24)
[ "$A" -gt 18 ] && A=18

# Sempre restaura o cursor e limpa, mesmo em Ctrl+C ou kill.
_ds_fim() { printf '\033[?25h\033[0m\n'; stty echo 2>/dev/null; exit 0; }
trap _ds_fim INT TERM EXIT

printf '\033[?25l'   # esconde cursor
stty -echo 2>/dev/null

GLIFOS=('·' '.' '✦' '✧' '★' '*' '˙')
CORES=('211;132;211' '189;114;193' '211;132;216' '132;186;233' '117;200;211' '242;242;242' '70;72;79')

ini=$(date +%s%N)
lim=$(awk -v d="$DUR" 'BEGIN{printf "%.0f", d*1000000000}')

while :; do
  agora=$(date +%s%N)
  (( agora - ini > lim )) && break
  # tecla pressionada encerra
  read -rsn1 -t 0.001 _tecla 2>/dev/null && break

  linha=$((RANDOM % A + 1))
  col=$((RANDOM % L + 1))
  g="${GLIFOS[RANDOM % ${#GLIFOS[@]}]}"
  c="${CORES[RANDOM % ${#CORES[@]}]}"
  printf '\033[%d;%dH\033[38;2;%sm%s\033[0m' "$linha" "$col" "$c" "$g"

  # apaga uma estrela antiga de vez em quando (efeito de cintilar)
  if (( RANDOM % 4 == 0 )); then
    printf '\033[%d;%dH ' $((RANDOM % A + 1)) $((RANDOM % L + 1))
  fi
  sleep 0.012
done

_ds_fim
