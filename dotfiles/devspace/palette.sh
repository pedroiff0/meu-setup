#!/usr/bin/env bash
# DevSpace — dispatcher de paleta.
#
# Escolhe a paleta conforme ~/.config/devspace/.modo (escrito por devspace-bg.sh):
#   claro  -> palette-claro.sh   (cores escuras p/ fundo lilas degrade)
#   escuro -> palette-escuro.sh  (cores pastel p/ fundo roxo escuro)
#
# Por que dois arquivos: as cores pastel do tema escuro dao contraste 2.2-3.9
# sobre fundo claro (medido) — ilegiveis. Cada tema tem sua paleta calibrada.

_ds_dir="$HOME/.config/devspace"
_ds_modo='escuro'
[ -r "$_ds_dir/.modo" ] && _ds_modo=$(tr -d '[:space:]' < "$_ds_dir/.modo" 2>/dev/null)

case "$_ds_modo" in
  claro) . "$_ds_dir/palette-claro.sh"  2>/dev/null ;;
  *)     . "$_ds_dir/palette-escuro.sh" 2>/dev/null ;;
esac
unset _ds_dir _ds_modo
