#!/usr/bin/env bash
# DevSpace — paleta extraida do plist do iTerm2 do Pedro (paste_1).
# Fonte unica de cor: bashrc, tmux, welcome e SSH motd leem daqui.
#
# Convertido de componentes RGB float (0..1) do plist para hex.

# --- cor de destaque (Bold/Cursor do plist): roxo-magenta ---
DS_ROXO='#d384d3'
DS_ROXO_ESC='\033[38;2;211;132;211m'
DS_LILAS='#bd72c1'      # Ansi 5
DS_LILAS_ESC='\033[38;2;189;114;193m'
DS_MAGENTA='#d384d8'    # Ansi 13
DS_MAGENTA_ESC='\033[38;2;211;132;216m'

# --- base ---
DS_BG='#1e2028'         # Background
DS_FG='#d3c8d3'         # Foreground
DS_FG_ESC='\033[38;2;211;200;211m'
DS_PRETO='#1a1b20'      # Ansi 0
DS_CINZA='#46484f'      # Ansi 8
DS_CINZA_ESC='\033[38;2;70;72;79m'
DS_BRANCO='#f2f2f2'     # Ansi 15

# --- acentos ---
DS_AZUL='#84bae9'       # Ansi 12 / Link
DS_AZUL_ESC='\033[38;2;132;186;233m'
DS_CIANO='#75c8d3'      # Ansi 14
DS_CIANO_ESC='\033[38;2;117;200;211m'
DS_VERDE='#9ed788'      # Ansi 10
DS_VERDE_ESC='\033[38;2;158;215;136m'
DS_AMARELO='#fdbb68'    # Ansi 11
DS_AMARELO_ESC='\033[38;2;253;187;104m'
DS_LARANJA='#fe9539'    # Ansi 3
DS_LARANJA_ESC='\033[38;2;254;149;57m'
DS_VERMELHO='#ec6e9f'   # Ansi 9
DS_VERMELHO_ESC='\033[38;2;236;110;159m'
DS_ROSA='#cd4f71'       # Ansi 1 / Selection

DS_RESET='\033[0m'
DS_BOLD='\033[1m'
DS_DIM='\033[2m'

# Icones roxos do tema (Nerd Font ja instalada — 36 famílias detectadas).
# Fallback em Unicode puro para terminais sem Nerd Font.
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

# Linha divisoria no estilo do paste (largura adaptavel)
ds_regua() {
  local largura="${1:-58}" ch="${2:-━}" out=''
  local i
  for ((i = 0; i < largura; i++)); do out+="$ch"; done
  printf '%b%s%b\n' "$DS_LILAS_ESC" "$out" "$DS_RESET"
}
