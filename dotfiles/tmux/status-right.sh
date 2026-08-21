#!/usr/bin/env bash
# ==============================================================================
# Tmux Status Right — Dev Quotes & Full Portuguese Date/Time with Purple Separators
# ==============================================================================

# Frases motivacionais de Dev, Código & Cosmos
quotes=(
  "Código limpo é poesia em execução."
  "Construa o futuro linha por linha."
  "Foco no processo, a maestria virá."
  "Refatore hoje, agradeça amanhã."
  "Grandes sistemas nascem de pequenos commits."
  "Mente cósmica, execução cirúrgica."
  "Transforme café em código de alto impacto."
  "Erros são apenas testes unitários da evolução."
  "Mantenha a calma e envie o PR."
  "Domine as sombras, conquiste o terminal."
  "Cada linha de código é um degrau na evolução."
  "Simplicidade é o ápice da sofisticação."
  "Arquitetura sólida resiste a qualquer tempestade."
  "Não apenas faça funcionar, faça brilhar."
  "O universo conspira a favor de quem compila."
  "Automação hoje, liberdade sempre."
  "Progresso diário supera perfeição adiada."
  "Pensar antes de codar economiza 10h de debug."
  "Debugar é ser o detetive de um crime que você cometeu."
  "O único código sem bugs é o que ainda não foi escrito."
  "Comite cedo, teste com calma, viva sem medo."
  "Menos boilerplate, mais engenharia de verdade."
  "Performance não é opcional, é respeito ao hardware."
)

num_quotes=${#quotes[@]}
# Rotaciona a cada 60 segundos
idx=$(( ($(date +%s) / 60) % num_quotes ))
frase="${quotes[$idx]}"

# Data formatada em Português
dias=("domingo" "segunda-feira" "terça-feira" "quarta-feira" "quinta-feira" "sexta-feira" "sábado")
meses=("" "Janeiro" "Fevereiro" "Março" "Abril" "Maio" "Junho" "Julho" "Agosto" "Setembro" "Outubro" "Novembro" "Dezembro")

dia_sem_num=$(date +%w)
dia_sem="${dias[$dia_sem_num]}"

dia_mes=$(date +%-d)
mes_num=$(date +%-m)
mes_nome="${meses[$mes_num]}"

hora=$(date +"%Hh%M")

# Formatação com bolinha roxa separadora (●) entre frase, data e horário
printf '#[fg=#94a3b8]"%s"#[default]  #[fg=#a855f7]●#[default]  #[fg=#e2e8f0]%s, %s de %s#[default]  #[fg=#a855f7]●#[default]  #[fg=#f1f5f9]%s#[default] ' \
  "$frase" "$dia_sem" "$dia_mes" "$mes_nome" "$hora"
