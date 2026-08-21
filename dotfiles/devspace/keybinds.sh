#!/usr/bin/env bash
# DevSpace — atalhos de teclado e aliases tematicos.
#
# Teclas do readline (funcionam na linha de comando do bash):
#   Alt+g  -> git status
#   Alt+l  -> ls detalhado
#   Alt+t  -> entra/reata o tmux DevSpace
#   Alt+u  -> sobe um diretorio
#   Alt+e  -> abre a welcome screen de novo (com animacao)
#   Ctrl+g -> busca no historico (fzf se existir, senao Ctrl+r nativo)
#
# NOTA: `bind` so existe em shell INTERATIVO. Em script/cron ele imprime
# "bind: warning: line editing not enabled" — por isso o guard abaixo.

case "$-" in *i*) ;; *) return 0 2>/dev/null || exit 0 ;; esac
[ -z "${BASH_VERSION:-}" ] && return 0

# --- teclas (\e = Alt). \C-m executa a linha. ---
bind '"\eg": "\C-a\C-kgit status -sb\C-m"'   2>/dev/null
bind '"\el": "\C-a\C-kls -lah --color=auto\C-m"' 2>/dev/null
bind '"\et": "\C-a\C-kds\C-m"'               2>/dev/null
bind '"\eu": "\C-a\C-kcd ..\C-m"'            2>/dev/null
bind '"\ee": "\C-a\C-kDS_ANIM=1 devspace-welcome.sh\C-m"' 2>/dev/null

# Ctrl+g: historico. Usa fzf se estiver instalado, senao cai no reverse-search.
if command -v fzf >/dev/null 2>&1; then
  bind '"\C-g": "\C-a\C-k$(history | fzf --tac | sed \"s/^ *[0-9]* *//\")\C-m"' 2>/dev/null
else
  bind '"\C-g": reverse-search-history' 2>/dev/null
fi

# Busca no historico com as setas usando o que ja foi digitado
bind '"\e[A": history-search-backward' 2>/dev/null
bind '"\e[B": history-search-forward'  2>/dev/null

# --- aliases tematicos ---
alias ll='ls -lah --color=auto'
alias la='ls -A --color=auto'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias ..='cd ..'
alias ...='cd ../..'

alias orbita='cd ~/Repositorios/pessoal'          # onde os projetos moram
alias universo='DS_ANIM=1 devspace-welcome.sh'    # welcome com animacao
alias estrelas='devspace-stars.sh'                # animacao de estrelas
alias constelacao='tmux ls'                       # sessoes tmux
alias telescopio='git log --oneline --graph --decorate -20'
alias cometa='git status -sb'
alias lancar='git push origin HEAD'

# tmux: entra/reata a sessao DevSpace (nunca cria duplicada)
ds() {
  local sessao="${1:-DevSpace}"
  if [ -n "${TMUX:-}" ]; then
    echo "ja esta dentro do tmux (sessao: $(tmux display -p '#S'))"
    return 0
  fi
  if tmux has-session -t "$sessao" 2>/dev/null; then
    tmux attach -t "$sessao"
  else
    tmux new-session -s "$sessao"
  fi
}

# Salva a sessao tmux na hora (atalho de terminal, nao de tmux)
alias salvar-sessao='~/.tmux/plugins/tmux-resurrect/scripts/save.sh && echo "sessao tmux salva"'
