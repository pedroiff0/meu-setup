#!/usr/bin/env bash
# DevSpace — Prompt Dinâmico Planck (Dev, Café & Astronomia)

[ -z "${BASH_VERSION:-}" ] && return 0
. "$HOME/.config/devspace/palette.sh" 2>/dev/null || return 0

_ds_c() { printf '\[\033[38;2;%sm\]' "$1"; }
_ds_rgb() { printf '%s' "${1#*38;2;}" | sed 's/m$//'; }

_DS_P=$(_ds_c "$(_ds_rgb "$DS_ROXO_ESC")")      # roxo
_DS_M=$(_ds_c "$(_ds_rgb "$DS_MAGENTA_ESC")")   # magenta
_DS_A=$(_ds_c "$(_ds_rgb "$DS_AZUL_ESC")")      # azul
_DS_C=$(_ds_c "$(_ds_rgb "$DS_CIANO_ESC")")     # ciano
_DS_V=$(_ds_c "$(_ds_rgb "$DS_VERDE_ESC")")     # verde
_DS_Y=$(_ds_c "$(_ds_rgb "$DS_AMARELO_ESC")")   # amarelo
_DS_R=$(_ds_c "$(_ds_rgb "$DS_VERMELHO_ESC")")  # vermelho
_DS_G=$(_ds_c "$(_ds_rgb "$DS_CINZA_ESC")")     # cinza
_DS_0='\[\033[0m\]'
_DS_B='\[\033[1m\]'

_ds_git_ramo() {
  git rev-parse --is-inside-work-tree >/dev/null 2>&1 || return
  local ramo sujo=''
  ramo=$(git branch --show-current 2>/dev/null)
  [ -z "$ramo" ] && ramo=$(git rev-parse --short HEAD 2>/dev/null)
  [ -z "$ramo" ] && return
  git diff --quiet --ignore-submodules HEAD >/dev/null 2>&1 || sujo='✚'
  printf ' %son%s %s🌿 %s%s%s' "$_DS_G" "$_DS_0" "$_DS_V" "$ramo" "$sujo" "$_DS_0"
}

_ds_prompt() {
  local st=$?
  local seta_cor="$_DS_P"
  local marca=''
  if [ "$st" -ne 0 ]; then
    seta_cor="$_DS_R"
    marca=" ${_DS_R}✗ ${st}${_DS_0}"
  fi

  local host_part=""
  if [ -z "${TMUX:-}" ]; then
    host_part=" ${_DS_G}at${_DS_0} ${_DS_A}\h${_DS_0}"
  fi

  # Prompt Planck Clássico e Limpo com Café, Dev e Timestamp Dinâmico
  PS1="\n${_DS_P}☕ ${_DS_B}${_DS_M}\u${_DS_0}${host_part} ${_DS_G}in${_DS_0} ${_DS_C}\w${_DS_0}$(_ds_git_ramo) ${_DS_G}[${_DS_Y}\D{%H:%M:%S}${_DS_G}]${_DS_0}${marca}\n${seta_cor}❯${_DS_0} "
  PS2="${_DS_G}·${_DS_0} "
}

PROMPT_COMMAND=_ds_prompt
