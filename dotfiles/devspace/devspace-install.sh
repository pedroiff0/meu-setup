#!/usr/bin/env bash
# DevSpace — instalador/integrador.
#
# Faz a ligacao de tudo:
#   1. bashrc      -> carrega palette/prompt/keybinds + welcome no login
#   2. SSH         -> welcome ao entrar remoto (via bashrc, NAO via motd root)
#   3. tmux        -> welcome curto ao criar/reatar sessao
#
# Idempotente: pode rodar quantas vezes quiser, nao duplica nada.
# Marcador usado para localizar/remover o bloco: # >>> DevSpace >>>
set -eu

MARCA_INI='# >>> DevSpace >>>'
MARCA_FIM='# <<< DevSpace <<<'
BRC="$HOME/.bashrc"

echo "== DevSpace: instalando =="

# ---------------------------------------------------------------------------
# 1. Backup do bashrc (uma vez por dia, nao polui)
# ---------------------------------------------------------------------------
BKP="$HOME/.bashrc.bak-devspace-$(date +%Y%m%d)"
[ -f "$BKP" ] || { cp "$BRC" "$BKP"; echo "backup: $BKP"; }

# ---------------------------------------------------------------------------
# 2. Remove bloco antigo (idempotencia) e escreve o novo
# ---------------------------------------------------------------------------
if grep -qF "$MARCA_INI" "$BRC" 2>/dev/null; then
  # apaga do marcador inicial ao final, inclusive
  sed -i "/$(printf '%s' "$MARCA_INI" | sed 's/[][\.*^$/]/\\&/g')/,/$(printf '%s' "$MARCA_FIM" | sed 's/[][\.*^$/]/\\&/g')/d" "$BRC"
  echo "bloco antigo removido"
fi

cat >> "$BRC" <<'BLOCO'
# >>> DevSpace >>>
# Tema DevSpace (paleta do iTerm2 do Pedro). Gerenciado por
# ~/.local/bin/devspace-install.sh — nao edite a mao, edite os arquivos em
# ~/.config/devspace/ e rode o instalador de novo.

# PATH para os scripts do tema
case ":$PATH:" in *":$HOME/.local/bin:"*) ;; *) PATH="$HOME/.local/bin:$PATH" ;; esac

if [ -n "${BASH_VERSION:-}" ] && [ -d "$HOME/.config/devspace" ]; then
  . "$HOME/.config/devspace/palette.sh"  2>/dev/null
  . "$HOME/.config/devspace/prompt.sh"   2>/dev/null
  . "$HOME/.config/devspace/keybinds.sh" 2>/dev/null

  # Welcome screen:
  #   - SSH remoto      -> completo (e o "terminal de chegada")
  #   - dentro do tmux  -> curto (a status bar ja da o contexto)
  #   - shell local     -> completo apenas no primeiro (nao repete em subshell)
  case "$-" in
    *i*)
      if [ -n "${SSH_CONNECTION:-}" ] && [ -z "${DS_JA_MOSTROU:-}" ]; then
        DS_ANIM=1 devspace-welcome.sh
        export DS_JA_MOSTROU=1
      elif [ -n "${TMUX:-}" ] && [ -z "${DS_JA_MOSTROU:-}" ]; then
        devspace-welcome.sh --curto
        export DS_JA_MOSTROU=1
      elif [ -z "${DS_JA_MOSTROU:-}" ] && [ "${SHLVL:-1}" -le 1 ]; then
        devspace-welcome.sh
        export DS_JA_MOSTROU=1
      fi
      ;;
  esac
fi
# <<< DevSpace <<<
BLOCO
echo "bashrc: bloco DevSpace instalado"

# ---------------------------------------------------------------------------
# 3. tmux: welcome curto ao criar sessao
#    Feito via hook no .tmux.conf do usuario (NAO precisa de root).
# ---------------------------------------------------------------------------
TCONF="$HOME/.tmux.conf"
if [ -f "$TCONF" ] && ! grep -q 'devspace-welcome' "$TCONF"; then
  echo "aviso: .tmux.conf sem hook do DevSpace (adicione manualmente se quiser)"
fi

# ---------------------------------------------------------------------------
# 4. Verificacao
# ---------------------------------------------------------------------------
echo
echo "== verificando =="
err=0
for f in "$HOME/.config/devspace/palette.sh" \
         "$HOME/.config/devspace/prompt.sh" \
         "$HOME/.config/devspace/keybinds.sh" \
         "$HOME/.local/bin/devspace-welcome.sh" \
         "$HOME/.local/bin/devspace-stars.sh"; do
  if bash -n "$f" 2>/dev/null; then
    printf '  [ok]    %s\n' "${f/#$HOME/~}"
  else
    printf '  [FALHA] %s\n' "${f/#$HOME/~}"; err=1
  fi
done

if bash -n "$BRC" 2>/dev/null; then
  echo "  [ok]    ~/.bashrc (sintaxe valida)"
else
  echo "  [FALHA] ~/.bashrc quebrado — restaure: cp $BKP $BRC"; err=1
fi

echo
if [ "$err" = "0" ]; then
  echo "DevSpace instalado. Abra um shell novo ou rode: source ~/.bashrc"
else
  echo "DevSpace com FALHAS acima."; exit 1
fi
