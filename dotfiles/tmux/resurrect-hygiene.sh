#!/usr/bin/env bash
# Higiene dos saves do tmux-resurrect.
#
# PROBLEMA REAL: o resurrect NAO escreve o save de forma atomica. Se o server
# morrer no meio da escrita (queda de energia, kill), o save mais RECENTE fica
# com 0 bytes — e o symlink `last` aponta pra ele. Na hora do restore voce fica
# sem nada, justamente quando mais precisa.
# (Constatado: saves de 0 byte de 03/08, 07/08, 16/08 e 17/08.)
#
# Este script:
#   1. apaga saves de 0 byte
#   2. se `last` estiver quebrado/vazio, reaponta pro save valido mais recente
#   3. mantem no maximo os N saves mais novos (default 200)
#
# Rodar via hook session-created no .tmux.conf.
set -u

DIR="${1:-$HOME/.local/share/tmux/resurrect}"
KEEP="${2:-200}"
[ -d "$DIR" ] || exit 0

# 1. saves corrompidos (0 byte) nunca servem
find "$DIR" -maxdepth 1 -name 'tmux_resurrect_*.txt' -size 0 -delete 2>/dev/null

# 2. last precisa apontar pra um save com conteudo
target=$(readlink -f "$DIR/last" 2>/dev/null || true)
if [ ! -s "$target" ]; then
  newest=$(ls -1t "$DIR"/tmux_resurrect_*.txt 2>/dev/null | head -1)
  if [ -s "$newest" ]; then
    ln -sfn "$(basename "$newest")" "$DIR/last"
  fi
fi

# 3. rotacao: so os KEEP mais novos
count=$(ls -1 "$DIR"/tmux_resurrect_*.txt 2>/dev/null | wc -l)
if [ "$count" -gt "$KEEP" ]; then
  keep_target=$(readlink -f "$DIR/last" 2>/dev/null || true)
  ls -1t "$DIR"/tmux_resurrect_*.txt 2>/dev/null | tail -n +$((KEEP + 1)) | while read -r f; do
    [ "$f" = "$keep_target" ] && continue   # nunca apagar o save apontado por last
    rm -f "$f"
  done
fi
exit 0
