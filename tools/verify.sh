#!/usr/bin/env bash
# ==============================================================================
# verify.sh — Suíte Completa de Testes & Verificação de Integridade
# ==============================================================================
set -uo pipefail

M="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
S="${AWESOME_SKILLS_DIR:-/home/pedro/Repositorios/pessoal/awesome-skills}"
[ -d "$S" ] || S="$HOME/repos/awesome-skills"

pass=0; fail=0
ck() {
    if ( set +o pipefail; eval "$2" ) >/dev/null 2>&1; then
        echo -e "  \033[32m✔ ok\033[0m   $1"
        pass=$((pass+1))
    else
        echo -e "  \033[31m✖ FAIL\033[0m $1"
        fail=$((fail+1))
    fi
}
sk() {
    if [ -d "$S" ]; then
        ck "$1" "$2"
    else
        echo -e "  \033[2m--\033[0m   $1 (awesome-skills ausente)"
    fi
}

echo -e "\n\033[1m\033[38;5;141m== 1. Sintaxe e Compilação ==\033[0m"
ck "tools/installer.py compila" "python3 -m py_compile $M/tools/installer.py"
ck "linux/install.py compila"   "python3 -m py_compile $M/linux/install.py"
ck "tools/gen.py compila"       "python3 -m py_compile $M/tools/gen.py"
sk "gen_index.py compila"       "python3 -m py_compile $S/tools/gen_index.py"
ck "install.sh bash -n"         "bash -n $M/install.sh"
ck "bootstrap.sh bash -n"       "bash -n $M/linux/bootstrap.sh"
ck "macos/install.sh bash -n"   "bash -n $M/macos/install.sh"
ck "scripts/*.sh bash -n"       "for f in $M/scripts/*.sh; do bash -n \"\$f\" || exit 1; done"
ck "themes/*/*.sh bash -n"      "for f in $M/themes/*/*.sh; do bash -n \"\$f\" || exit 1; done"
ck "configs/*/*.sh bash -n"     "for f in $M/configs/*/*.sh; do bash -n \"\$f\" || exit 1; done"
ck "packages.yaml parseia"      "python3 -c \"import yaml;yaml.safe_load(open('$M/packages.yaml'))\""

echo -e "\n\033[1m\033[38;5;141m== 2. Validação do Manifesto (packages.yaml) ==\033[0m"
ck "todo item tem name/desc/tags" "python3 - <<'P'
import yaml, sys
d = yaml.safe_load(open('$M/packages.yaml'))['packages']
bad = [i for i in d if not all(k in i for k in ('name','desc','tags'))]
sys.exit(1 if bad or len(d)<70 else 0)
P"
ck "nomes únicos de pacotes" "python3 - <<'P'
import yaml, sys
n = [i['name'] for i in yaml.safe_load(open('$M/packages.yaml'))['packages']]
sys.exit(0 if len(n) == len(set(n)) else 1)
P"
ck "todo item tem receita Linux válida" "python3 - <<'P'
import yaml, sys
K = {'apt', 'dnf', 'pacman', 'zypper', 'flatpak', 'snap', 'script'}
d = yaml.safe_load(open('$M/packages.yaml'))['packages']
bad = [i for i in d if not (K & set((i.get('linux') or {}).keys()))]
sys.exit(1 if bad else 0)
P"

echo -e "\n\033[1m\033[38;5;141m== 3. Geradores Idempotentes ==\033[0m"
before=$(md5sum $M/windows/install.ps1 $M/macos/install.sh $M/INVENTARIO.md $M/docs/PACKAGES_CATALOG.md 2>/dev/null || true)
python3 $M/tools/gen.py >/dev/null
ck "gen.py estável e determinístico" "[ \"\$(md5sum $M/windows/install.ps1 $M/macos/install.sh $M/INVENTARIO.md $M/docs/PACKAGES_CATALOG.md 2>/dev/null)\" = \"$before\" ]"

echo -e "\n\033[1m\033[38;5;141m== 4. Comportamento do Motor de Instalação ==\033[0m"
ck "tools/installer.py --list"  "python3 $M/tools/installer.py --list"
ck "linux/install.py --list"    "python3 $M/linux/install.py --list"
ck "dry-run não altera o sistema" "python3 $M/linux/install.py --dry-run --yes"
ck "filtro --only funciona"     "python3 $M/linux/install.py --only htop --dry-run --yes 2>&1 | grep -qF '1 pacotes selecionados'"
ck "filtro --group funciona"    "python3 $M/linux/install.py --group latex --dry-run --yes 2>&1 | grep -qF texlive-full"
ck "pacote inexistente sai com código 1" "! python3 $M/linux/install.py --only naoexiste --dry-run --yes"
ck "idempotência (htop já presente)"     "python3 $M/linux/install.py --only htop --dry-run --yes 2>&1 | grep -q 'já presentes: 1'"

echo -e "\n\033[1m\033[38;5;141m== 5. Segurança e Integridade de Repositório ==\033[0m"
ck "sem segredos reais" "python3 - <<'P'
import os, sys, re
pattern = re.compile(r'\\b(gho|ghp|ghs|ghu)_[A-Za-z0-9]{36}\\b|sk-[A-Za-z0-9]{32,}|BEGIN (RSA|OPENSSH|EC) PRIVATE KEY')
root = '$M'
found = False
for r, ds, fs in os.walk(root):
    if '.git' in r: continue
    for f in fs:
        p = os.path.join(r, f)
        try:
            txt = open(p, encoding='utf-8', errors='ignore').read()
            if pattern.search(txt):
                found = True; break
        except Exception: pass
sys.exit(1 if found else 0)
P"
ck "bootstrap online 200 OK" "[ \"\$(curl -s -o /dev/null -w %{http_code} https://raw.githubusercontent.com/pedroiff0/meu-setup/main/linux/bootstrap.sh)\" = 200 ]"

echo ""
echo "=================================================="
echo -e "  \033[1mResultado: \033[32m$pass passou\033[0m | \033[31m$fail falhou\033[0m"
echo "=================================================="
[ $fail -eq 0 ]
