#!/usr/bin/env bash
# DevSpace — paleta do tema CLARO (fundo lilas degrade).
#
# Carregada em vez de palette.sh quando ~/.config/devspace/.modo == "claro".
#
# Cores medidas: contraste >= 4.6 (WCAG AA) contra #d9c8f7, que e o ponto MAIS
# saturado do gradiente de fundo. As versoes pastel do tema escuro davam
# 2.2-3.9 aqui (ilegiveis) — matiz preservado, luminosidade reduzida.

DS_ROXO='#6d28d9'
DS_ROXO_ESC='\033[38;2;109;40;217m'
DS_LILAS='#7c38a2'
DS_LILAS_ESC='\033[38;2;124;56;162m'
DS_MAGENTA='#812fac'
DS_MAGENTA_ESC='\033[38;2;129;47;172m'

DS_BG='#f5f0fe'
DS_FG='#2f2748'
DS_FG_ESC='\033[38;2;47;39;72m'
DS_PRETO='#3a3350'
DS_CINZA='#5c5478'
DS_CINZA_ESC='\033[38;2;92;84;120m'
DS_BRANCO='#1a1626'

DS_AZUL='#1f54ab'
DS_AZUL_ESC='\033[38;2;31;84;171m'
DS_CIANO='#175f69'
DS_CIANO_ESC='\033[38;2;23;95;105m'
DS_VERDE='#25633f'
DS_VERDE_ESC='\033[38;2;37;99;63m'
DS_AMARELO='#7a4e0e'
DS_AMARELO_ESC='\033[38;2;122;78;14m'
DS_LARANJA='#8a4a10'
DS_LARANJA_ESC='\033[38;2;138;74;16m'
DS_VERMELHO='#a32454'
DS_VERMELHO_ESC='\033[38;2;163;36;84m'
DS_ROSA='#a32353'

DS_RESET='\033[0m'
DS_BOLD='\033[1m'
DS_DIM='\033[2m'

DS_IC_CAFE='☕'
DS_IC_GALAXIA='🌌'
DS_IC_LAMPADA='💡'
DS_IC_FOGUETE='🚀'
DS_IC_ESTRELA='✦'
DS_IC_PLANETA='🪐'
DS_IC_SATELITE='🛰'
DS_IC_LUA='🌙'
DS_IC_COMETA='☄'
DS_IC_TELESCOPIO='🔭'

ds_regua() {
  local largura="${1:-58}" ch="${2:-━}" out='' i
  for ((i = 0; i < largura; i++)); do out+="$ch"; done
  printf '%b%s%b\n' "$DS_LILAS_ESC" "$out" "$DS_RESET"
}
