#!/usr/bin/env bash
# DevSpace — gera o perfil de cores para o iTerm2 do MAC (fundo lilas claro).
#
# POR QUE ESTE SCRIPT EXISTE:
#   O fundo da janela e desenhado pelo iTerm2 que roda no MacBook. Nenhuma
#   sequencia ANSI cria gradiente, e nada nesta maquina Linux alcanca aquele
#   fundo. Entao geramos aqui o arquivo .itermcolors e voce importa no Mac.
#
# GRADIENTE DE VERDADE no iTerm2 (o .itermcolors so leva cor SOLIDA):
#   Settings > Profiles > Window > Background image
#     -> use o PNG gerado por este script (degrade lilas)
#     -> Blending: ~0.15   Style: Stretch
#   Isso e o unico caminho para degrade real de fundo no iTerm2.
#
# Uso:
#   devspace-itermgradient.sh          -> gera em ~/devspace-mac/
set -u

SAIDA="$HOME/devspace-mac"
mkdir -p "$SAIDA"

# --- paleta clara: fundo lilas, texto roxo escuro (contraste AA) ---
# Mantidas as cores de ACENTO do plist original do Pedro (#d384d3 etc),
# mas rebalanceadas para legibilidade sobre fundo CLARO: os tons pastel do
# tema escuro (ex: #9ed788) somem em fundo #f5f0fe.
gerar_itermcolors() {
  # $1 = nome, resto = pares "Chave:#hex"
  local arq="$SAIDA/$1.itermcolors"; shift
  {
    echo '<?xml version="1.0" encoding="UTF-8"?>'
    echo '<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">'
    echo '<plist version="1.0">'
    echo '<dict>'
    local par chave hex r g b
    for par in "$@"; do
      chave="${par%%:*}"; hex="${par##*:}"; hex="${hex#\#}"
      r=$((16#${hex:0:2})); g=$((16#${hex:2:2})); b=$((16#${hex:4:2}))
      printf '\t<key>%s</key>\n\t<dict>\n' "$chave"
      printf '\t\t<key>Blue Component</key>\n\t\t<real>%.10f</real>\n'  "$(awk -v v="$b" 'BEGIN{print v/255}')"
      printf '\t\t<key>Green Component</key>\n\t\t<real>%.10f</real>\n' "$(awk -v v="$g" 'BEGIN{print v/255}')"
      printf '\t\t<key>Red Component</key>\n\t\t<real>%.10f</real>\n'   "$(awk -v v="$r" 'BEGIN{print v/255}')"
      printf '\t</dict>\n'
    done
    echo '</dict>'
    echo '</plist>'
  } > "$arq"
  echo "  $arq"
}

echo "gerando perfil de cores do iTerm2 (tema CLARO lilas):"
# Cores ANSI escurecidas ate contraste >= 4.6 (WCAG AA) contra o ponto MAIS
# saturado do gradiente (#d9c8f7). Medido: as versoes pastel originais do tema
# escuro davam 2.2-3.9 sobre fundo claro (ilegiveis). Matiz/saturacao
# preservados; so a luminosidade caiu.
gerar_itermcolors "DevSpace-Lilas-Claro" \
  "Background Color:#f5f0fe"   `# lilas quase branco` \
  "Foreground Color:#2f2748"   `# roxo escuro — 9.01 no pior ponto do gradiente` \
  "Bold Color:#4c1d95" \
  "Cursor Color:#6d28d9" \
  "Cursor Text Color:#ffffff" \
  "Selection Color:#d8c9f5" \
  "Selected Text Color:#2f2748" \
  "Link Color:#1f54ab" \
  "Ansi 0 Color:#3a3350"   "Ansi 8 Color:#5c5478"  \
  "Ansi 1 Color:#a32454"   "Ansi 9 Color:#a32353"  \
  "Ansi 2 Color:#25633f"   "Ansi 10 Color:#276340" \
  "Ansi 3 Color:#7a4e0e"   "Ansi 11 Color:#784f13" \
  "Ansi 4 Color:#1f54ab"   "Ansi 12 Color:#1c54aa" \
  "Ansi 5 Color:#7c38a2"   "Ansi 13 Color:#812fac" \
  "Ansi 6 Color:#175f69"   "Ansi 14 Color:#1a5f68" \
  "Ansi 7 Color:#4a4266"   "Ansi 15 Color:#1a1626"

# ---------------------------------------------------------------------------
# PNG do gradiente — para "Background image" do iTerm2.
# Gerado em SVG (texto puro) e convertido se houver conversor; senao o SVG
# sozinho ja serve, pois o iTerm2 aceita PNG/JPG — convertemos no Mac se faltar.
# ---------------------------------------------------------------------------
SVG="$SAIDA/devspace-gradiente.svg"
cat > "$SVG" <<'SVGEOF'
<svg xmlns="http://www.w3.org/2000/svg" width="2560" height="1600" viewBox="0 0 2560 1600">
  <defs>
    <linearGradient id="g" x1="0" y1="0" x2="1" y2="1">
      <stop offset="0%"   stop-color="#faf7ff"/>
      <stop offset="35%"  stop-color="#f1e9fd"/>
      <stop offset="70%"  stop-color="#e6d9fb"/>
      <stop offset="100%" stop-color="#d9c8f7"/>
    </linearGradient>
    <radialGradient id="brilho" cx="18%" cy="12%" r="65%">
      <stop offset="0%"   stop-color="#ffffff" stop-opacity="0.75"/>
      <stop offset="100%" stop-color="#ffffff" stop-opacity="0"/>
    </radialGradient>
  </defs>
  <rect width="2560" height="1600" fill="url(#g)"/>
  <rect width="2560" height="1600" fill="url(#brilho)"/>
</svg>
SVGEOF
echo "  $SVG"

# tenta converter para PNG com o que existir na maquina
PNG="$SAIDA/devspace-gradiente.png"
if command -v rsvg-convert >/dev/null 2>&1; then
  rsvg-convert -w 2560 -h 1600 "$SVG" -o "$PNG" && echo "  $PNG (rsvg-convert)"
elif command -v convert >/dev/null 2>&1; then
  convert -background none "$SVG" "$PNG" && echo "  $PNG (imagemagick)"
elif command -v inkscape >/dev/null 2>&1; then
  inkscape "$SVG" --export-filename="$PNG" >/dev/null 2>&1 && echo "  $PNG (inkscape)"
elif python3 -c 'import cairosvg' 2>/dev/null; then
  python3 -c "import cairosvg;cairosvg.svg2png(url='$SVG',write_to='$PNG',output_width=2560,output_height=1600)" && echo "  $PNG (cairosvg)"
else
  echo "  (sem conversor SVG->PNG aqui; o iTerm2 aceita o SVG convertido no Mac,"
  echo "   ou abra o .svg no Preview do macOS e exporte como PNG)"
fi

cat <<INSTR

────────────────────────────────────────────────────────────────
COMO APLICAR NO MAC (o fundo da janela e de la, nao daqui)
────────────────────────────────────────────────────────────────
1) Copie os arquivos para o Mac (rode ISTO NO MAC):

   scp -r $(whoami)@$(hostname -s 2>/dev/null || hostname):~/devspace-mac ~/Downloads/

2) Cores solidas:
   iTerm2 > Settings > Profiles > Colors > Color Presets > Import...
   escolha  DevSpace-Lilas-Claro.itermcolors   e depois selecione o preset.

3) GRADIENTE de verdade (o passo que faz o degrade):
   iTerm2 > Settings > Profiles > Window > Background image
     - imagem : devspace-gradiente.png
     - Style  : Stretch
     - Blending: ~0.15  (quanto menor, mais forte a imagem)

4) Volte aqui e rode, para o tmux casar com o tema claro:
   devspace-bg.sh claro

Para voltar ao escuro:  devspace-bg.sh escuro  (e troque o preset no iTerm2)
INSTR
