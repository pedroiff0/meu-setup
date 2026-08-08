#!/usr/bin/env python3
"""
gen.py — gera os instaladores de Windows (winget) e macOS (brew) a partir do
packages.yaml, para que exista uma única fonte de verdade.

    python3 tools/gen.py
"""
from __future__ import annotations

import sys
from pathlib import Path

import yaml

ROOT = Path(__file__).resolve().parents[1]
DATA = yaml.safe_load((ROOT / "packages.yaml").read_text(encoding="utf-8"))
ITEMS = DATA["packages"]


def gen_windows() -> int:
    lines = [
        "# install.ps1 — GERADO por tools/gen.py, nao edite a mao.",
        "# Repopula um Windows usando winget.",
        "#   powershell -ExecutionPolicy Bypass -File .\\windows\\install.ps1",
        "#   powershell -ExecutionPolicy Bypass -File .\\windows\\install.ps1 -DryRun",
        "",
        "param([switch]$DryRun)",
        "",
        "if (-not (Get-Command winget -ErrorAction SilentlyContinue)) {",
        "    Write-Error 'winget nao encontrado. Instale o App Installer da Microsoft Store.'",
        "    exit 1",
        "}",
        "",
        "function Install-App($Id, $Name, $Desc) {",
        "    Write-Host \"==> $Name  ($Desc)\" -ForegroundColor Cyan",
        "    $installed = winget list --id $Id --exact 2>$null | Select-String $Id",
        "    if ($installed) { Write-Host '    ja instalado' -ForegroundColor DarkGray; return }",
        "    if ($DryRun) { Write-Host \"    [dry-run] winget install --id $Id\" -ForegroundColor DarkGray; return }",
        "    winget install --id $Id --exact --silent --accept-package-agreements --accept-source-agreements",
        "}",
        "",
    ]
    count = 0
    for it in ITEMS:
        win = it.get("windows")
        if not win:
            continue
        if isinstance(win, dict):
            sc = win.get("script")
            if sc:
                lines.append(f"Write-Host '==> {it['name']}' -ForegroundColor Cyan")
                lines.append(f"if (-not $DryRun) {{ {sc} }}")
                count += 1
            continue
        desc = it.get("desc", "").replace("'", "''")
        lines.append(f"Install-App '{win}' '{it['name']}' '{desc}'")
        count += 1
    lines += ["", "Write-Host 'Concluido.' -ForegroundColor Green", ""]
    (ROOT / "windows" / "install.ps1").write_text("\n".join(lines), encoding="utf-8")
    return count


def gen_macos() -> int:
    formulas, casks = [], []
    for it in ITEMS:
        mac = it.get("macos")
        if not mac:
            continue
        if mac.get("brew"):
            formulas.append((mac["brew"], it["name"], it.get("desc", "")))
        if mac.get("cask"):
            casks.append((mac["cask"], it["name"], it.get("desc", "")))

    lines = [
        "#!/usr/bin/env bash",
        "# install.sh — GERADO por tools/gen.py, nao edite a mao.",
        "# Repopula um macOS usando Homebrew.   Use DRY_RUN=1 para simular.",
        "set -euo pipefail",
        "",
        'DRY_RUN="${DRY_RUN:-0}"',
        'run() { if [ "$DRY_RUN" = "1" ]; then echo "  [dry-run] $*"; else "$@"; fi; }',
        "",
        "if ! command -v brew >/dev/null; then",
        '  echo "==> Instalando Homebrew"',
        '  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"',
        "fi",
        "",
        "brew update",
        "",
        "install_formula() {",
        '  local pkg="$1" name="$2" desc="$3"',
        '  echo "==> $name ($desc)"',
        '  if brew list --formula "$pkg" >/dev/null 2>&1; then echo "    ja instalado"; return; fi',
        '  run brew install "$pkg"',
        "}",
        "",
        "install_cask() {",
        '  local pkg="$1" name="$2" desc="$3"',
        '  echo "==> $name ($desc)"',
        '  if brew list --cask "$pkg" >/dev/null 2>&1; then echo "    ja instalado"; return; fi',
        '  run brew install --cask "$pkg"',
        "}",
        "",
        "# ---- formulas ----",
    ]
    for pkg, name, desc in formulas:
        lines.append(f'install_formula "{pkg}" "{name}" "{desc}"')
    lines += ["", "# ---- casks ----"]
    for pkg, name, desc in casks:
        lines.append(f'install_cask "{pkg}" "{name}" "{desc}"')
    lines += ["", 'echo "Concluido."', ""]

    out = ROOT / "macos" / "install.sh"
    out.write_text("\n".join(lines), encoding="utf-8")
    out.chmod(0o755)
    return len(formulas) + len(casks)


def gen_inventory() -> int:
    rows = ["| Programa | Descrição | Grupos | Linux | Windows | macOS |",
            "|---|---|---|---|---|---|"]
    for it in ITEMS:
        lin = it.get("linux") or {}
        linux_txt = lin.get("apt") or lin.get("flatpak") or lin.get("snap") or (
            "script" if lin.get("script") else "—")
        win = it.get("windows")
        win_txt = win if isinstance(win, str) else ("script" if win else "—")
        mac = it.get("macos") or {}
        mac_txt = mac.get("brew") or mac.get("cask") or "—"
        tags = ", ".join(it.get("tags", []))
        rows.append(f"| **{it['name']}** | {it.get('desc','')} | {tags} | "
                    f"`{linux_txt}` | `{win_txt}` | `{mac_txt}` |")
    (ROOT / "INVENTARIO.md").write_text(
        "# Inventário de programas\n\n"
        "Gerado por `tools/gen.py` a partir de `packages.yaml`.\n\n"
        + "\n".join(rows) + "\n", encoding="utf-8")
    return len(ITEMS)


if __name__ == "__main__":
    w = gen_windows()
    m = gen_macos()
    i = gen_inventory()
    print(f"windows/install.ps1: {w} apps")
    print(f"macos/install.sh   : {m} apps")
    print(f"INVENTARIO.md      : {i} itens")
    sys.exit(0)
