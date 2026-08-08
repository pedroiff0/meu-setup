#!/usr/bin/env bash
# Verificação ad-hoc dos artefatos de awesome-skills e meu-setup.
set -uo pipefail
S="${AWESOME_SKILLS_DIR:-$HOME/repos/awesome-skills}"
M="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
pass=0; fail=0
ck() { if ( set +o pipefail; eval "$2" ) >/dev/null 2>&1; then echo "  ok   $1"; pass=$((pass+1)); else echo "  FAIL $1"; fail=$((fail+1)); fi; }
# checagens que dependem do repo awesome-skills só rodam se ele existir
sk() { [ -d "$S" ] && ck "$1" "$2" || echo "  --   $1 (awesome-skills ausente)"; }

echo "== sintaxe =="
ck "install.py compila"        "python3 -m py_compile $M/linux/install.py"
ck "gen.py compila"            "python3 -m py_compile $M/tools/gen.py"
sk "gen_index.py compila"      "python3 -m py_compile $S/tools/gen_index.py"
ck "bootstrap.sh bash -n"      "bash -n $M/linux/bootstrap.sh"
ck "macos/install.sh bash -n"  "bash -n $M/macos/install.sh"
ck "packages.yaml parseia"     "python3 -c \"import yaml;yaml.safe_load(open('$M/packages.yaml'))\""

echo "== manifesto =="
ck "todo item tem name/desc/tags" "python3 - <<'P'
import yaml,sys
d=yaml.safe_load(open('$M/packages.yaml'))['packages']
bad=[i for i in d if not all(k in i for k in ('name','desc','tags'))]
sys.exit(1 if bad or len(d)<50 else 0)
P"
ck "nomes únicos" "python3 - <<'P'
import yaml,sys
n=[i['name'] for i in yaml.safe_load(open('$M/packages.yaml'))['packages']]
sys.exit(0 if len(n)==len(set(n)) else 1)
P"
ck "todo item tem receita linux" "python3 - <<'P'
import yaml,sys
K={'apt','dnf','pacman','zypper','flatpak','snap','script'}
d=yaml.safe_load(open('$M/packages.yaml'))['packages']
sys.exit(1 if [i for i in d if not (K & set((i.get('linux') or {}).keys()))] else 0)
P"

echo "== geradores idempotentes =="
before=$(md5sum $M/windows/install.ps1 $M/macos/install.sh $M/INVENTARIO.md)
python3 $M/tools/gen.py >/dev/null
ck "gen.py estável" "[ \"\$(md5sum $M/windows/install.ps1 $M/macos/install.sh $M/INVENTARIO.md)\" = \"$before\" ]"
if [ -d "$S" ]; then
  b2=$(md5sum $S/README.md)
  python3 $S/tools/gen_index.py >/dev/null
  ck "gen_index.py estável" "[ \"\$(md5sum $S/README.md)\" = \"$b2\" ]"
fi

echo "== install.py comportamento =="
ck "--list funciona"        "python3 $M/linux/install.py --list"
ck "--dry-run não instala"  "python3 $M/linux/install.py --dry-run --yes"
ck "--only filtra 1 pacote" "python3 $M/linux/install.py --only htop --dry-run --yes 2>&1 | grep -qF '1 pacotes selecionados'"
ck "--group filtra"         "python3 $M/linux/install.py --group latex --dry-run --yes 2>&1 | grep -qF texlive-full"
ck "--only inexistente sai 1" "! python3 $M/linux/install.py --only naoexiste --dry-run --yes"
ck "idempotência (htop já presente)" "python3 $M/linux/install.py --only htop --dry-run --yes 2>&1 | grep -q 'já presentes: 1'"
ck "dry-run sem falhas"     "python3 $M/linux/install.py --dry-run --yes 2>&1 | grep -q 'falhas: 0'"

echo "== git/publicação =="
sk "awesome-skills limpo" "[ -z \"\$(git -C $S status --porcelain)\" ]"
ck "meu-setup limpo"      "[ -z \"\$(git -C $M status --porcelain)\" ]"
ck "sem segredos reais"    "! grep -rIqE '\\b(gho|ghp|ghs|ghu)_[A-Za-z0-9]{36}\\b|sk-[A-Za-z0-9]{32,}|BEGIN (RSA|OPENSSH|EC) PRIVATE KEY' $S $M --exclude-dir=.git"
ck "raw bootstrap 200"    "[ \"\$(curl -s -o /dev/null -w %{http_code} https://raw.githubusercontent.com/pedroiff0/meu-setup/main/linux/bootstrap.sh)\" = 200 ]"

echo; echo "passou: $pass   falhou: $fail"; [ $fail -eq 0 ]
