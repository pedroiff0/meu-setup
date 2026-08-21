#!/usr/bin/env bash
# Forca TUIs (hermes, claude, agy, vim) a REPINTAR a tela inteira.
#
# Porque isso e necessario:
#   - `refresh-client` faz o TMUX redesenhar o cache que ele tem do pane.
#     Se o app nunca reenviou nada, o tmux repinta a MESMA tela velha. Inutil.
#   - `refresh-client -S` redesenha SO a status bar. Pior ainda.
#   - SIGWINCH sozinho da repaint PARCIAL: muitos apps (Ink/React do Claude,
#     Textual, etc) so repintam de verdade quando as DIMENSOES MUDAM.
#
# Solucao testada: resize da janela -1 coluna e volta. O app ve dois WINCH com
# tamanhos diferentes e reconstroi o frame inteiro. Visualmente imperceptivel.
#
# Uso: redraw-pane.sh <window_id>
set -u
win="${1:-}"
[ -z "$win" ] && exit 0

w=$(tmux display -pt "$win" '#{window_width}' 2>/dev/null) || exit 0
case "$w" in ''|*[!0-9]*) exit 0 ;; esac
[ "$w" -lt 20 ] && exit 0

# Janela com layout manual/zoom: nao mexer no tamanho, so sinaliza.
zoom=$(tmux display -pt "$win" '#{window_zoomed_flag}' 2>/dev/null || echo 0)
if [ "$zoom" = "1" ]; then
  pid=$(tmux display -pt "$win" '#{pane_pid}' 2>/dev/null)
  tpgid=$(ps -o tpgid= -p "$pid" 2>/dev/null | tr -d ' ')
  [ -n "$tpgid" ] && [ "$tpgid" -gt 0 ] 2>/dev/null && kill -WINCH "-$tpgid" 2>/dev/null
  exit 0
fi

tmux resize-window -t "$win" -x $((w - 1)) 2>/dev/null
tmux resize-window -t "$win" -x "$w"       2>/dev/null
# volta ao tamanho do cliente (desfaz o resize-window manual)
tmux resize-window -t "$win" -A 2>/dev/null
exit 0
