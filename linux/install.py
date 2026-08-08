#!/usr/bin/env python3
"""
install.py — repopula a máquina Linux a partir de packages.yaml.

Detecta a distro, escolhe o gerenciador de pacotes certo e instala tudo
(ou só os grupos escolhidos). Idempotente: pula o que já está instalado.

Uso:
    ./linux/install.py --dry-run             # mostra o que faria
    ./linux/install.py                       # instala tudo
    ./linux/install.py --group dev --group ia
    ./linux/install.py --only docker,ollama
    ./linux/install.py --list                # lista pacotes e grupos
    ./linux/install.py --yes                 # sem confirmação
"""
from __future__ import annotations

import argparse
import os
import shutil
import subprocess
import sys
from pathlib import Path

try:
    import yaml
except ImportError:
    sys.exit("Falta PyYAML. Instale com: sudo apt install -y python3-yaml "
             "(ou pip install --user pyyaml)")

ROOT = Path(__file__).resolve().parents[1]
MANIFEST = ROOT / "packages.yaml"

C = {
    "r": "\033[0m", "b": "\033[1m", "dim": "\033[2m",
    "green": "\033[32m", "yellow": "\033[33m", "red": "\033[31m",
    "cyan": "\033[36m", "blue": "\033[34m",
}
if not sys.stdout.isatty() or os.environ.get("NO_COLOR"):
    C = {k: "" for k in C}


def say(msg: str, color: str = "") -> None:
    print(f"{C.get(color, '')}{msg}{C['r']}", flush=True)


# --------------------------------------------------------------------------
# Detecção de distro / gerenciador
# --------------------------------------------------------------------------
def os_release() -> dict:
    data = {}
    p = Path("/etc/os-release")
    if p.exists():
        for line in p.read_text().splitlines():
            if "=" in line:
                k, v = line.split("=", 1)
                data[k] = v.strip().strip('"')
    return data


def detect_manager() -> tuple[str, list[str], list[str]]:
    """Retorna (chave_no_yaml, comando_install, comando_update)."""
    if shutil.which("apt-get"):
        return "apt", ["apt-get", "install", "-y"], ["apt-get", "update"]
    if shutil.which("dnf"):
        return "dnf", ["dnf", "install", "-y"], ["dnf", "check-update"]
    if shutil.which("pacman"):
        return "pacman", ["pacman", "-S", "--noconfirm", "--needed"], ["pacman", "-Sy"]
    if shutil.which("zypper"):
        return "zypper", ["zypper", "--non-interactive", "install"], ["zypper", "refresh"]
    sys.exit("Nenhum gerenciador de pacotes suportado encontrado "
             "(apt/dnf/pacman/zypper).")


def sudo_prefix() -> list[str]:
    if os.geteuid() == 0:
        return []
    if not shutil.which("sudo"):
        sys.exit("Precisa de sudo (ou rode como root).")
    return ["sudo"]


# --------------------------------------------------------------------------
# Checagem de "já instalado"
# --------------------------------------------------------------------------
def pkg_installed(mgr: str, pkg: str) -> bool:
    checks = {
        "apt": ["dpkg-query", "-W", "-f=${Status}", pkg],
        "dnf": ["rpm", "-q", pkg],
        "pacman": ["pacman", "-Qi", pkg],
        "zypper": ["rpm", "-q", pkg],
    }
    cmd = checks.get(mgr)
    if not cmd or not shutil.which(cmd[0]):
        return False
    r = subprocess.run(cmd, capture_output=True, text=True)
    if mgr == "apt":
        return r.returncode == 0 and "install ok installed" in r.stdout
    return r.returncode == 0


def flatpak_installed(app_id: str) -> bool:
    if not shutil.which("flatpak"):
        return False
    r = subprocess.run(["flatpak", "info", app_id], capture_output=True)
    return r.returncode == 0


def snap_installed(name: str) -> bool:
    if not shutil.which("snap"):
        return False
    r = subprocess.run(["snap", "list", name], capture_output=True)
    return r.returncode == 0


# --------------------------------------------------------------------------
# Execução
# --------------------------------------------------------------------------
class Runner:
    def __init__(self, dry: bool):
        self.dry = dry

    def run(self, cmd: list[str] | str, shell: bool = False) -> bool:
        pretty = cmd if isinstance(cmd, str) else " ".join(cmd)
        if self.dry:
            say(f"    [dry-run] {pretty}", "dim")
            return True
        say(f"    $ {pretty}", "dim")
        r = subprocess.run(cmd, shell=shell)
        return r.returncode == 0


def install_one(item: dict, mgr: str, install_cmd: list[str], sudo: list[str],
                runner: Runner) -> str:
    """Retorna 'ok' | 'skip' | 'fail' | 'na'."""
    name = item["name"]
    spec = item.get("linux") or {}
    if not spec:
        return "na"

    # 1) pacote nativo da distro
    native = spec.get(mgr)
    if native:
        pkgs = native.split()
        if all(pkg_installed(mgr, p) for p in pkgs):
            return "skip"
        repo = (spec.get("repo") or {}).get(mgr)
        if repo:
            say(f"    adicionando repositório de {name}", "blue")
            if not runner.run(repo, shell=True):
                say(f"    aviso: repositório de {name} falhou", "yellow")
            else:
                runner.run(sudo + ["apt-get", "update"] if mgr == "apt" else ["true"])
        ok = runner.run(sudo + install_cmd + pkgs)
        if ok:
            post = spec.get("post")
            if post:
                runner.run(post, shell=True)
            return "ok"
        # cai para os fallbacks abaixo
        say(f"    pacote nativo falhou, tentando alternativas para {name}", "yellow")

    # 2) flatpak
    fp = spec.get("flatpak")
    if fp:
        if flatpak_installed(fp):
            return "skip"
        if shutil.which("flatpak"):
            if runner.run(["flatpak", "install", "-y", "--noninteractive",
                           "flathub", fp]):
                return "ok"

    # 3) snap
    sn = spec.get("snap")
    if sn:
        if snap_installed(sn):
            return "skip"
        if shutil.which("snap"):
            cmd = sudo + ["snap", "install", sn]
            if spec.get("classic"):
                cmd.append("--classic")
            if runner.run(cmd):
                return "ok"

    # 4) script
    sc = spec.get("script")
    if sc:
        if runner.run(sc, shell=True):
            post = spec.get("post")
            if post:
                runner.run(post, shell=True)
            return "ok"

    return "fail" if (native or fp or sn or sc) else "na"


def main() -> int:
    ap = argparse.ArgumentParser(description="Repopular Linux a partir de packages.yaml")
    ap.add_argument("--dry-run", action="store_true", help="só mostra o que faria")
    ap.add_argument("--group", action="append", default=[],
                    help="instalar só esta tag (repetível)")
    ap.add_argument("--only", default="", help="lista de nomes separada por vírgula")
    ap.add_argument("--list", action="store_true", help="listar pacotes e grupos")
    ap.add_argument("--yes", "-y", action="store_true", help="não pedir confirmação")
    ap.add_argument("--manifest", default=str(MANIFEST))
    args = ap.parse_args()

    data = yaml.safe_load(Path(args.manifest).read_text(encoding="utf-8"))
    items = data.get("packages", [])

    if args.list:
        groups: dict[str, int] = {}
        for it in items:
            for t in it.get("tags", []):
                groups[t] = groups.get(t, 0) + 1
        say(f"{len(items)} pacotes no manifesto\n", "b")
        for it in items:
            tags = ",".join(it.get("tags", []))
            say(f"  {it['name']:22} {C['dim']}{tags:28}{C['r']} {it.get('desc','')}")
        say("\nGrupos:", "b")
        for g, n in sorted(groups.items()):
            say(f"  {g:14} {n}")
        return 0

    if sys.platform != "linux":
        sys.exit("Este script é só para Linux. Veja windows/ e macos/.")

    rel = os_release()
    mgr, install_cmd, update_cmd = detect_manager()
    sudo = sudo_prefix()
    runner = Runner(args.dry_run)

    say(f"Distro : {rel.get('PRETTY_NAME', 'desconhecida')}", "cyan")
    say(f"Gerenciador: {mgr}", "cyan")

    # filtros
    selected = items
    if args.only:
        wanted = {n.strip() for n in args.only.split(",") if n.strip()}
        selected = [i for i in selected if i["name"] in wanted]
    if args.group:
        wanted_tags = set(args.group)
        selected = [i for i in selected if wanted_tags & set(i.get("tags", []))]

    if not selected:
        say("Nada selecionado.", "yellow")
        return 1

    say(f"\n{len(selected)} pacotes selecionados:", "b")
    say("  " + ", ".join(i["name"] for i in selected), "dim")

    if not args.yes and not args.dry_run:
        try:
            if input("\nContinuar? [s/N] ").strip().lower() not in ("s", "y"):
                say("Abortado.", "yellow")
                return 1
        except EOFError:
            say("Sem TTY — use --yes para instalar sem confirmação.", "yellow")
            return 1

    if not args.dry_run:
        say("\nAtualizando índices de pacotes...", "blue")
        runner.run(sudo + update_cmd)

    results = {"ok": [], "skip": [], "fail": [], "na": []}
    for idx, item in enumerate(selected, 1):
        say(f"\n[{idx}/{len(selected)}] {item['name']} — {item.get('desc','')}", "b")
        status = install_one(item, mgr, install_cmd, sudo, runner)
        results[status].append(item["name"])
        icon = {"ok": ("instalado", "green"), "skip": ("já presente", "dim"),
                "fail": ("FALHOU", "red"), "na": ("sem receita p/ esta distro", "yellow")}[status]
        say(f"    -> {icon[0]}", icon[1])

    say("\n" + "=" * 60, "b")
    say(f"instalados: {len(results['ok'])}   já presentes: {len(results['skip'])}   "
        f"falhas: {len(results['fail'])}   sem receita: {len(results['na'])}", "b")
    if results["fail"]:
        say("Falharam: " + ", ".join(results["fail"]), "red")
    if results["na"]:
        say("Sem receita: " + ", ".join(results["na"]), "yellow")
    say("\nDica: reinicie a sessão se instalou docker (grupo) ou driver NVIDIA.", "cyan")
    return 1 if results["fail"] else 0


if __name__ == "__main__":
    sys.exit(main())
