#!/usr/bin/env bash
# DevSpace — degrade roxo claro.
#
# LIMITE TECNICO (leia antes de esperar magica):
#   Nao existe sequencia ANSI para gradiente de fundo. O terminal so aceita cor
#   de fundo SOLIDA. O fundo da JANELA e desenhado pelo emulador que roda na
#   maquina do usuario (aqui: iTerm2 no MacBook, via SSH/Tailscale) — nenhum
#   script nesta maquina Linux alcanca aquele fundo.
#
# O que ESTE script faz (o que e possivel deste lado):
#   1. window-style do tmux -> fundo solido lilas claro na area de conteudo
#   2. status bar / bordas / prompt recalibrados para tema CLARO
#   3. degrade REAL desenhado como conteudo (barras/paineis do welcome)
#
# O gradiente de verdade da janela sai do arquivo gerado por
# `devspace-itermgradient.sh`, que se aplica no iTerm2 do Mac.
#
# Uso:
#   devspace-bg.sh claro     -> tema claro lilas degrade (padrao)
#   devspace-bg.sh escuro    -> volta ao roxo escuro
#   devspace-bg.sh off       -> remove qualquer window-style
set -u

MODO="${1:-claro}"
command -v tmux >/dev/null 2>&1 || { echo "tmux nao encontrado"; exit 1; }
tmux info >/dev/null 2>&1 || { echo "nenhum servidor tmux rodando"; exit 1; }

case "$MODO" in
  claro)
    # Paleta lilas clara. Os tons vao do mais claro (topo/inativo) ao
    # mais saturado (ativo), o que da SENSACAO de degrade entre paineis.
    BG_INATIVO='#efe9fb'   # lilas quase branco
    BG_ATIVO='#f7f3fe'     # painel em foco: mais claro = "iluminado"
    FG='#2f2748'           # texto roxo-escuro (contraste AA sobre lilas)
    ST_BG='#ddd2f5'        # status bar: um passo mais escuro
    ST_FG='#4a3f6b'
    SEL_BG='#c9b8ec'
    BORDA='#c9bce8'
    BORDA_ATIVA='#7c3aed'
    ACENTO='#7c3aed'
    ACENTO_FG='#ffffff'
    INATIVO_FG='#7c7196'
    ;;
  escuro)
    BG_INATIVO='#1a1730'
    BG_ATIVO='#221d3d'
    FG='#d3c8d3'
    ST_BG='#1e1b34'
    ST_FG='#b9b3d6'
    SEL_BG='#5b4b8a'
    BORDA='#332f52'
    BORDA_ATIVA='#7c3aed'
    ACENTO='#7c3aed'
    ACENTO_FG='#ffffff'
    INATIVO_FG='#6f6a92'
    ;;
  off)
    tmux set -gu window-style
    tmux set -gu window-active-style
    echo "window-style removido (fundo volta ao do emulador)"
    exit 0
    ;;
  *)
    echo "uso: devspace-bg.sh [claro|escuro|off]"; exit 2 ;;
esac

# --- fundo da area de conteudo (o "degrade" entre painel ativo/inativo) ---
tmux set -g window-style        "bg=$BG_INATIVO,fg=$FG"
tmux set -g window-active-style "bg=$BG_ATIVO,fg=$FG"

# --- status bar recalibrada para o tema ---
tmux set -g status-style "bg=$ST_BG,fg=$ST_FG"
tmux set -g status-left  "#[bg=$ACENTO,fg=$ACENTO_FG,bold] #S #[bg=$ST_BG,fg=$ACENTO]#[default] "
tmux set -g status-right "#{?client_prefix,#[bg=$ACENTO]#[fg=$ACENTO_FG,bold] PREFIX #[default] ,}#(bash ~/.tmux/status-right.sh)"
tmux set -g status-right-length 150
tmux set -g window-status-separator " #[fg=$ACENTO]●#[default] "
tmux setw -g window-status-style          "fg=$INATIVO_FG,bg=$ST_BG"
tmux setw -g window-status-activity-style "fg=$ACENTO,bg=$ST_BG,bold"
tmux setw -g window-status-current-format "#[bg=$ACENTO,fg=$ACENTO_FG,bold] #I:#W #[default]"

# --- bordas e mensagens ---
tmux set -g pane-border-style        "fg=$BORDA"
tmux set -g pane-active-border-style "fg=$BORDA_ATIVA"
tmux set -g message-style            "bg=$ACENTO,fg=$ACENTO_FG,bold"
tmux set -g mode-style               "bg=$SEL_BG,fg=$FG,bold"

# Guarda o modo para o prompt/welcome saberem qual contraste usar
printf '%s\n' "$MODO" > "$HOME/.config/devspace/.modo"

tmux refresh-client 2>/dev/null || true
echo "tema '$MODO' aplicado (fundo do CONTEUDO: $BG_INATIVO / ativo $BG_ATIVO)"
echo
echo "ATENCAO: o fundo da JANELA do terminal e do iTerm2 no seu Mac."
echo "Para o gradiente REAL, rode:  devspace-itermgradient.sh"
