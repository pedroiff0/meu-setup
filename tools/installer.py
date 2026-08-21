#!/usr/bin/env python3
"""Universal Multi-System Installer for meu-setup (Cosmic Purple Dev Edition).

Features:
- Granular item-by-item selection [✔] across ALL themes, system tweaks, and applications.
- Full Custom Setup Wizard: Step-by-step control (Themes -> Tweaks -> Packages -> Review).
- Dynamic Viewport Scrolling & Terminal Width Bounds (no line wrapping glitches).
- Multi-System Dispatcher: Linux (apt/dnf/pacman/zypper/flatpak/snap), macOS (brew/cask), Windows (winget/powershell).
- Clickable Terminal Hyperlinks (OSC 8 + explicit URLs).
- Aesthetic Purple, Astronomy & Developer Theme with Cosmic Coffee intro ☕ 🪐 🌌.
"""
from __future__ import annotations

import argparse
import atexit
import fcntl
import os
import platform
import re
import shutil
import subprocess
import sys
import termios
import tty
from pathlib import Path

# ------------------------------------------------------------------------------
# 1. Operating System Detection & Path Dispatcher
# ------------------------------------------------------------------------------
SYS_NAME = platform.system().lower()
IS_LINUX = SYS_NAME == "linux"
IS_MACOS = SYS_NAME == "darwin"
IS_WINDOWS = SYS_NAME == "windows"

if IS_LINUX:
    distro_name = "Linux"
    if Path("/etc/os-release").exists():
        for line in Path("/etc/os-release").read_text().splitlines():
            if line.startswith("PRETTY_NAME="):
                distro_name = line.split("=", 1)[1].strip('"')
                break
    OS_LABEL = f"🐧 {distro_name} (Tier 1 Primary Platform)"
elif IS_MACOS:
    OS_LABEL = f"🍎 macOS ({platform.mac_ver()[0] or 'Darwin'} - Paths Adapted)"
elif IS_WINDOWS:
    OS_LABEL = f"🪟 Windows (NT {platform.version()} - Winget & PowerShell)"
else:
    OS_LABEL = f"🌐 {platform.system()} (POSIX Compatible)"

# Paths
SCRIPT_DIR = Path(__file__).resolve().parent
REPO_ROOT = SCRIPT_DIR.parent
PACKAGES_YAML = REPO_ROOT / "packages.yaml"
DOTFILES_DIR = REPO_ROOT / "dotfiles"
THEMES_DIR = REPO_ROOT / "themes"
CONFIGS_DIR = REPO_ROOT / "configs"
SCRIPTS_DIR = REPO_ROOT / "scripts"
GITHUB_REPO_URL = "https://github.com/pedroiff0/meu-setup"

# ANSI Styling (Purple / Cosmic Astronomy & Dev Theme)
ESC = "\033["
RESET = f"{ESC}0m"
BOLD = f"{ESC}1m"
DIM = f"{ESC}2m"

# Cosmic Purple Palette
PURPLE = "\033[38;5;141m"       # Soft Lavender Purple
VIOLET = "\033[38;5;99m"        # Deep Space Violet
NEBULA = "\033[38;5;183m"       # Light Nebula
MAGENTA = "\033[38;5;201m"      # Cyber Magenta
STARLIGHT = "\033[38;5;159m"    # Ice-blue Star Glow
COSMIC_GREEN = "\033[38;5;120m" # Aurora Green
GOLD_STAR = "\033[38;5;220m"    # Cosmic Gold / Coffee Crema
CYAN_DEV = "\033[38;5;87m"      # Hacker Cyan
WHITE = f"{ESC}37m"
HIDE_CURSOR = f"{ESC}?25l"
SHOW_CURSOR = f"{ESC}?25h"


def hyperlink(url: str, text: str | None = None) -> str:
    """Create terminal clickable hyperlink (OSC 8 standard) with fallback text."""
    display = text if text is not None else url
    return f"\033]8;;{url}\033\\{display}\033]8;;\033\\"


def restore_cursor():
    try:
        sys.stdout.write(SHOW_CURSOR)
        sys.stdout.flush()
    except Exception:
        pass


atexit.register(restore_cursor)


def cancel_and_exit():
    restore_cursor()
    print(f"\n{GOLD_STAR}🟡 Operação abortada pelo usuário (ESC/Ctrl+C).{RESET}\n")
    sys.exit(0)


def ensure_tty():
    if not sys.stdin.isatty():
        try:
            sys.stdin = open("/dev/tty", "r")
        except Exception:
            pass


def getch() -> str:
    """Read a single keypress or ANSI escape sequence reliably on POSIX/Windows."""
    if os.name == "nt":
        import msvcrt
        ch = msvcrt.getch()
        if ch in (b"\x00", b"\xe0"):
            ch2 = msvcrt.getch()
            if ch2 == b"H": return "UP"
            if ch2 == b"P": return "DOWN"
            if ch2 == b"K": return "LEFT"
            if ch2 == b"M": return "RIGHT"
        if ch == b"\x1b": return "ESC"
        if ch in (b"\x08",): return "BACKSPACE"
        if ch in (b"\r", b"\n"): return "ENTER"
        if ch == b" ": return "SPACE"
        if ch == b"\x03": raise KeyboardInterrupt
        return ch.decode("utf-8", errors="ignore")

    fd = sys.stdin.fileno()
    old_settings = termios.tcgetattr(fd)
    try:
        tty.setraw(fd)
        ch = sys.stdin.read(1)
        if ch == "\x1b":
            old_flags = fcntl.fcntl(fd, fcntl.F_GETFL)
            fcntl.fcntl(fd, fcntl.F_SETFL, old_flags | os.O_NONBLOCK)
            try:
                rest = sys.stdin.read(10)
            except (IOError, TypeError):
                rest = ""
            finally:
                fcntl.fcntl(fd, fcntl.F_SETFL, old_flags)

            if not rest:
                return "ESC"
            if rest in ("[A", "OA") or rest.endswith("A"): return "UP"
            elif rest in ("[B", "OB") or rest.endswith("B"): return "DOWN"
            elif rest in ("[C", "OC") or rest.endswith("C"): return "RIGHT"
            elif rest in ("[D", "OD") or rest.endswith("D"): return "LEFT"
            elif rest in ("[H", "[1~"): return "HOME"
            elif rest in ("[F", "[4~"): return "END"
            return "IGNORE"
        elif ch in ("\x7f", "\x08"):
            return "BACKSPACE"
        elif ch in ("\r", "\n"):
            return "ENTER"
        elif ch == " ":
            return "SPACE"
        elif ch == "\x03":
            raise KeyboardInterrupt
        elif ch == "\x04":
            return "EOF"
        return ch
    finally:
        termios.tcsetattr(fd, termios.TCSADRAIN, old_settings)


def print_banner():
    setup_link = hyperlink(GITHUB_REPO_URL, "☕ MEU-SETUP")
    author_link = hyperlink("https://github.com/pedroiff0", "@pedroiff0")
    banner = f"""{PURPLE}{BOLD}
          .      *       .     (  )   (   )  )       *       .      .
    *        .       .          ) (   )  (  (     .       .      *
       .         *       .     ( )  (    ) )        .        .
   .       *   ┌───────────────────────────────┐     *      .       *
             * │      {setup_link}      │ *       .       .
     *         └───────────────────────────────┘            *
  🪐  ███╗   ███╗███████╗██╗   ██╗      ███████╗███████╗████████╗██╗   ██╗██████╗   🌌
      ████╗ ████║██╔════╝██║   ██║      ██╔════╝██╔════╝╚══██╔══╝██║   ██║██╔══██╗
      ██╔████╔██║█████╗  ██║   ██║█████╗███████╗█████╗     ██║   ██║   ██║██████╔╝  ⟨/⟩
      ██║╚██╔╝██║██╔══╝  ██║   ██║╚════╝╚════██║██╔══╝     ██║   ██║   ██║██╔═══╝    λ
      ██║ ╚═╝ ██║███████╗╚██████╔╝      ███████║███████╗   ██║   ╚██████╔╝██║        ☄️
{NEBULA}  ══════════════════════════════════════════════════════════════════════════════════════
  ✨ UNIVERSAL MULTI-SYSTEM SETUP • TEMAS • TWEAKS • ENERGIA • 100+ APPS ✨
  🛰️  OS Detection: {CYAN_DEV}{OS_LABEL}{NEBULA} • Curated by {author_link}
{PURPLE}  ══════════════════════════════════════════════════════════════════════════════════════{RESET}
"""
    print(banner)


def load_manifest() -> list[dict]:
    import yaml
    if not PACKAGES_YAML.exists():
        sys.exit(f"Erro: {PACKAGES_YAML} não encontrado.")
    data = yaml.safe_load(PACKAGES_YAML.read_text(encoding="utf-8"))
    return data.get("packages", [])


# ------------------------------------------------------------------------------
# 2. Granular Item Registries
# ------------------------------------------------------------------------------

THEMES_REGISTRY = [
    ("devspace_prompt", "DevSpace Prompt Planck", "Prompt com café ☕, usuário magenta, caminho ciano, Git 🌿 e relógio", "themes/devspace/install-devspace.sh"),
    ("devspace_palette", "DevSpace Paletas Cósmicas", "Paleta escuro (#120d22), lilás claro e dispatcher ~/.config/devspace/.modo", "themes/devspace/install-devspace.sh"),
    ("devspace_aliases", "DevSpace Aliases Modernos", "Aliases rápidos no shell: lg (lazygit), ld (lazydocker), ls/ll (eza), cat (bat), du (duf)", "themes/devspace/install-devspace.sh"),
    ("devspace_statusline", "DevSpace Statusline (Antigravity)", "Script agy-statusline.sh com telemetria nativa e monitor de contexto", "themes/devspace/install-devspace.sh"),
    ("devspace_welcome", "DevSpace Welcome Screen", "Tela de boas-vindas animada devspace-welcome.sh e campo estelar", "themes/devspace/install-devspace.sh"),
    ("firefox_theme", "Firefox DevSpace Cósmico", "userChrome.css com abas compactas em gradiente e userContent.css", "themes/firefox/install-firefox-theme.sh"),
    ("tmux_conf", "Tmux Configuração Base (.tmux.conf)", "True color, prefix Ctrl+a, binds vi, suporte a mouse e histórico 200k", "themes/tmux/install-tmux-theme.sh"),
    ("tmux_statusline", "Tmux Status Bar em Português", "Frases dev rotativas, data/hora em português e bolinha roxa separadora (●)", "themes/tmux/install-tmux-theme.sh"),
    ("tmux_antighost", "Tmux Anti-Ghosting (redraw-pane.sh)", "Redimensionamento imperceptível para forçar repintura de tela em TUIs (Claude/Hermes/AGY)", "themes/tmux/install-tmux-theme.sh"),
    ("tmux_resurrect", "Tmux Resurrect & Higiene de Saves", "Persistência contínua com limpeza automática de saves vazios de 0 bytes", "themes/tmux/install-tmux-theme.sh"),
    ("whitesur_gtk", "WhiteSur GTK Theme (macOS Look)", "Tema GTK Dark Purple com botões arredondados estilo traffic lights", "themes/whitesur/install-whitesur.sh"),
    ("whitesur_icons", "WhiteSur Icon Theme", "Conjunto completo de ícones modernos estilo Apple/Big Sur", "themes/whitesur/install-whitesur.sh"),
    ("whitesur_cursors", "WhiteSur Cursors", "Cursores de alta precisão WhiteSur", "themes/whitesur/install-whitesur.sh"),
    ("whitesur_dock", "Plank Dock Tema macOS", "Configuração de dock inferior centralizado com transparência e zoom", "themes/whitesur/install-whitesur.sh"),
    ("starship_prompt", "Starship Prompt Cósmico", "Preset starship.toml multiplataforma em Rust (Bash, Zsh, PowerShell)", "dotfiles/starship/starship.toml"),
    ("alacritty_theme", "Alacritty Tema DevSpace", "Esquema de cores alacritty.toml calibrado para DevSpace", "dotfiles/alacritty/alacritty.toml"),
    ("kitty_theme", "Kitty Tema DevSpace", "Esquema de cores kitty.conf calibrado para DevSpace", "dotfiles/kitty/kitty.conf"),
    ("windows_term", "Windows Terminal DevSpace", "Color scheme JSON fragment para Windows Terminal", "dotfiles/windows-terminal/settings-fragment.json"),
    ("wallpapers", "Wallpapers Big Sur 5K & DevSpace", "Imagens em alta definição para ~/Pictures/Wallpapers", "themes/wallpapers/download-wallpapers.sh"),
]

TWEAKS_REGISTRY = [
    ("pwr_server_mask", "Servidor 24/7: Mascarar Suspensão", "Mascara sleep.target, suspend.target, hibernate.target no systemd", "configs/power/server-24-7.sh"),
    ("pwr_server_gnome", "Servidor 24/7: Desativar Sleep GNOME", "Configura sleep-inactive-ac-timeout = 0 e sleep-inactive-battery = 0", "configs/power/server-24-7.sh"),
    ("pwr_server_lid", "Servidor 24/7: Ignorar Tampa do Laptop", "Configura systemd-logind HandleLidSwitch=ignore para rodar com tampa fechada", "configs/power/server-24-7.sh"),
    ("net_bbr", "Rede: TCP BBR v2 (Google)", "Controle de congestionamento para máxima vazão e mínima latência", "configs/network/apply-bbr.sh"),
    ("net_fq", "Rede: Fair Queuing (FQ)", "Queueing discipline para fluxo ótimo de pacotes TCP", "configs/network/apply-bbr.sh"),
    ("sys_inotify", "Kernel: Inotify Watchers (524k)", "Aumenta fs.inotify.max_user_watches para 524288 (Node.js, Vite, Webpack, IDEs)", "configs/network/apply-sysctl-tuning.sh"),
    ("sys_file_max", "Kernel: File Descriptors (2M)", "Aumenta fs.file-max para 2097152 descritores de arquivo abertos", "configs/network/apply-sysctl-tuning.sh"),
    ("sys_swappiness", "Kernel: Swappiness = 10", "Prioriza memória RAM e reduz swap prematuro em disco", "configs/network/apply-sysctl-tuning.sh"),
    ("storage_docker_root", "Docker: Data-Root (/home/docker-data)", "Move o armazenamento de contêineres e volumes para partição maior", "configs/storage/setup-docker-storage.sh"),
    ("storage_docker_logs", "Docker: Rotação de Logs (50MB)", "Limita logs dos contêineres em 50MB (max 3 arquivos) e ativa live-restore", "configs/storage/setup-docker-storage.sh"),
    ("storage_fstrim", "Armazenamento: SSD TRIM Periódico", "Ativa fstrim.timer no systemd para manutenção de SSDs/NVMe", "configs/storage/setup-fstrim.sh"),
    ("net_adguard", "Rede: AdGuard Home DNS Sinkhole", "Sobe container AdGuard Home em Docker (porta 53 + painel web http://localhost:8085)", "configs/network/setup-adguard.sh"),
    ("sec_ufw", "Segurança: Firewall UFW Padrão", "Bloqueia entrada não autorizada e libera SSH (22), HTTP (80), HTTPS (443) e DNS (53)", "configs/network/setup-firewall.sh"),
    ("hw_sensors", "Hardware: Sensores Térmicos (lm-sensors)", "Executa detecção automática de sensores térmicos e voltagens", "configs/monitoring/setup-monitoring.sh"),
    ("pwr_laptop_tlp", "Notebook: Otimizador de Bateria (TLP)", "Ativa serviço TLP para economia inteligente de energia", "configs/power/laptop-battery.sh"),
    ("pwr_laptop_powertop", "Notebook: Powertop Autotune", "Ajusta parâmetros de hardware para baixo consumo de bateria", "configs/power/laptop-battery.sh"),
    ("pwr_laptop_cpufreq", "Notebook: Auto-CPUfreq", "Governador dinâmico de frequência de CPU para notebooks", "configs/power/laptop-battery.sh"),
]

PACKS = {
    "fullstack": {
        "title": "🚀 Full-Stack & Developer Essentials",
        "description": "Compiladores, Python, Node, Git, Docker, Caddy, Databases e CLIs",
        "tags": ["base", "dev", "python", "js", "database", "web", "cli"],
    },
    "devops": {
        "title": "⚡ DevOps, Docker & Cloud Infrastructure",
        "description": "Docker, Compose, Lazydocker, Caddy, Tailscale, Syncthing, Netdata e Redes",
        "tags": ["infra", "rede", "security", "sysadmin", "cli"],
    },
    "ai": {
        "title": "🧠 AI, LLMs & Local Inference Stack",
        "description": "Ollama, Open-WebUI, Hermes Agent, Claude Code, Antigravity CLI e CUDA/GPU",
        "tags": ["ia", "gpu", "dev", "cli"],
    },
    "academic": {
        "title": "📚 Academic, LaTeX & Research Stack",
        "description": "TeXLive Full, Pandoc, Typst, Zotero, Poppler e Utilitários de PDF",
        "tags": ["latex", "academic", "pdf", "escritorio"],
    },
    "creative": {
        "title": "🎨 Creative, Media & Design Stack",
        "description": "FFmpeg, Inkscape, GIMP, VLC, OBS Studio e Kdenlive",
        "tags": ["midia", "design", "creative", "video"],
    },
    "server_min": {
        "title": "🖥️ Minimal Headless Server Stack",
        "description": "Base essencial de servidor, monitoramento (btop/htop/ncdu), rede e segurança",
        "tags": ["base", "sysadmin", "rede", "infra"],
    },
    "all": {
        "title": "📦 Complete Workstation (Todos os 100+ Pacotes)",
        "description": "Instalação integral de todas as aplicações e ferramentas do repositório",
        "tags": "ALL",
    },
}


# ------------------------------------------------------------------------------
# 3. Robust TUI Selection Components (With Safe Viewport Scrolling)
# ------------------------------------------------------------------------------

def tui_multiselect(
    title: str,
    options: list[tuple[str, str, str]],  # (key, label, subtitle)
    default_selected: list[str] | None = None,
    allow_empty: bool = False,
    allow_back: bool = False,
    single_choice: bool = False,
) -> list[str] | str:
    """Standardized Checkbox Selection Interface [✔] with Safe Viewport Scrolling and Arrow Navigation."""
    if not sys.stdin.isatty():
        return [opt[0] for opt in options] if default_selected is None else default_selected

    sys.stdout.write(HIDE_CURSOR)
    sys.stdout.flush()

    selected = set(default_selected if default_selected is not None else ([options[0][0]] if not allow_empty else []))
    cursor = 0
    num_opts = len(options)
    lines_rendered = 0
    warning_msg = ""

    def render():
        nonlocal lines_rendered
        term_cols, term_rows = shutil.get_terminal_size((80, 24))
        max_line_len = max(20, term_cols - 2)

        # Dynamic viewport pagination based on terminal height
        page_size = max(4, min(num_opts, term_rows - 7))
        start_idx = max(0, min(cursor - page_size // 2, num_opts - page_size))
        end_idx = min(start_idx + page_size, num_opts)
        visible_options = options[start_idx:end_idx]

        buf = []
        if lines_rendered > 0:
            buf.append(f"{ESC}{lines_rendered}F")

        # Header
        header_text = f"┌── 🌌 {title} [{len(selected)}/{num_opts} selecionados]"
        if len(header_text) > max_line_len:
            header_text = header_text[:max_line_len - 3] + "..."
        buf.append(f"{BOLD}{PURPLE}{header_text}{RESET}\n")
        lines = 1

        for rel_idx, (key, label, sub) in enumerate(visible_options):
            abs_idx = start_idx + rel_idx
            is_active = abs_idx == cursor
            is_checked = key in selected
            box = f"{COSMIC_GREEN}[✔]{RESET}" if is_checked else f"{DIM}[ ]{RESET}"
            ptr = f"{MAGENTA}❯{RESET}" if is_active else " "

            # Cleanly truncate label + subtitle to prevent line wrapping
            avail_len = max_line_len - 10
            sub_clean = f" ({sub})" if sub else ""
            full_line_text = f"{label}{sub_clean}"
            if len(full_line_text) > avail_len:
                full_line_text = full_line_text[:avail_len - 3] + "..."

            if is_active:
                buf.append(f"  {ptr} {box} {BOLD}{NEBULA}{full_line_text}{RESET}{ESC}K\n")
            else:
                buf.append(f"  {ptr} {box} {WHITE}{full_line_text}{RESET}{ESC}K\n")
            lines += 1

        # Scroll indicator if paginated
        if num_opts > page_size:
            scroll_text = f"  {DIM}── Exibindo {start_idx+1}-{end_idx} de {num_opts} opções ──{RESET}"
            buf.append(f"{scroll_text}{ESC}K\n")
            lines += 1

        if warning_msg:
            buf.append(f"  {GOLD_STAR}⚠️  {warning_msg}{RESET}{ESC}K\n")
            lines += 1

        back_hint = " | ←/b: Voltar" if allow_back else ""
        all_hint = " | a: Todos" if not single_choice else ""
        footer = f"{DIM}└── [↑/↓: Mover | Espaço: Marcar{all_hint} | →/Enter: Avançar{back_hint} | Esc: Sair]{RESET}"
        buf.append(f"{footer}{ESC}K\n")
        lines += 1

        lines_rendered = lines
        sys.stdout.write("".join(buf))
        sys.stdout.flush()

    try:
        while True:
            render()
            key = getch()
            warning_msg = ""
            if key in ("UP", "k"):
                cursor = (cursor - 1) % num_opts
            elif key in ("DOWN", "j"):
                cursor = (cursor + 1) % num_opts
            elif key == "SPACE":
                cur_key = options[cursor][0]
                if single_choice:
                    selected.clear()
                    selected.add(cur_key)
                else:
                    if cur_key in selected:
                        selected.remove(cur_key)
                    else:
                        selected.add(cur_key)
            elif key in ("a", "A") and not single_choice:
                if len(selected) == num_opts:
                    selected.clear()
                else:
                    selected = set(opt[0] for opt in options)
            elif key == "RIGHT":
                cur_key = options[cursor][0]
                if single_choice:
                    selected.clear()
                selected.add(cur_key)
                break
            elif key == "ENTER":
                if single_choice:
                    cur_key = options[cursor][0]
                    selected.clear()
                    selected.add(cur_key)
                    break
                elif not selected and not allow_empty:
                    cur_key = options[cursor][0]
                    selected.add(cur_key)
                    break
                elif selected or allow_empty:
                    break
            elif allow_back and key in ("b", "B", "LEFT", "BACKSPACE"):
                print()
                return "__BACK__"
            elif key in ("ESC", "q", "Q", "EOF"):
                cancel_and_exit()
    finally:
        sys.stdout.write(SHOW_CURSOR)
        sys.stdout.flush()

    print()
    return [opt[0] for opt in options if opt[0] in selected]


def tui_package_browser(
    all_packages: list[dict],
    default_selected_names: set[str] | None = None,
    allow_back: bool = True,
) -> list[dict] | str:
    """Interactive Package browser with viewport scrolling, search, details and 1-by-1 control."""
    if not sys.stdin.isatty():
        return all_packages

    sys.stdout.write(HIDE_CURSOR)
    sys.stdout.flush()

    sort_modes = ["name", "category"]
    sort_idx = 0
    search_query = ""
    selected_tag_filter = "ALL"

    def get_filtered_packages():
        items = all_packages
        if selected_tag_filter != "ALL":
            items = [p for p in items if selected_tag_filter in p.get("tags", [])]
        if search_query:
            q = search_query.lower()
            items = [
                p for p in items
                if q in p["name"].lower() or any(q in t.lower() for t in p.get("tags", [])) or q in p.get("desc", "").lower()
            ]
        sm = sort_modes[sort_idx]
        if sm == "name":
            return sorted(items, key=lambda x: x["name"])
        elif sm == "category":
            return sorted(items, key=lambda x: (x.get("tags", ["outros"])[0], x["name"]))
        return items

    selected_names = set(default_selected_names if default_selected_names is not None else [])
    cursor = 0
    lines_rendered = 0
    warning_msg = ""

    try:
        while True:
            term_cols, term_rows = shutil.get_terminal_size((80, 24))
            max_line_len = max(20, term_cols - 2)

            items = get_filtered_packages()
            if not items:
                items = all_packages
                search_query = ""

            num_items = len(items)
            cursor = max(0, min(cursor, num_items - 1))

            page_size = max(4, min(num_items, term_rows - 10))
            start_idx = max(0, min(cursor - page_size // 2, num_items - page_size))
            end_idx = min(start_idx + page_size, num_items)
            visible_items = items[start_idx:end_idx]
            focused = items[cursor]

            buf = []
            if lines_rendered > 0:
                buf.append(f"{ESC}{lines_rendered}F")

            header = f"{BOLD}{PURPLE}┌── 🎯 Catálogo de Aplicações [Marcados: {len(selected_names)}/{len(all_packages)}] {RESET}"
            if search_query:
                header += f" {GOLD_STAR}(Busca: '{search_query}'){RESET}"
            if selected_tag_filter != "ALL":
                header += f" {CYAN_DEV}(Tag: {selected_tag_filter}){RESET}"
            buf.append(f"{header}{ESC}K\n")
            lines = 1

            for rel_i, item in enumerate(visible_items):
                abs_i = start_idx + rel_i
                is_active = abs_i == cursor
                is_checked = item["name"] in selected_names

                box = f"{COSMIC_GREEN}[✔]{RESET}" if is_checked else f"{DIM}[ ]{RESET}"
                ptr = f"{MAGENTA}❯{RESET}" if is_active else " "

                name_str = f"{item['name']:<22}"
                tags_str = f"[{','.join(item.get('tags', []))[:18]}]"
                desc_str = item.get('desc', '')[:30]

                if is_active:
                    buf.append(f"  {ptr} {box} {BOLD}{NEBULA}{name_str}{RESET} {PURPLE}{tags_str:<20}{RESET} {DIM}{desc_str}{RESET}{ESC}K\n")
                else:
                    buf.append(f"  {ptr} {box} {WHITE}{name_str}{RESET} {PURPLE}{tags_str:<20}{RESET} {DIM}{desc_str}{RESET}{ESC}K\n")
                lines += 1

            sort_label = f"Ordem: {sort_modes[sort_idx].capitalize()}"
            scroll_info = f"Exibindo {start_idx+1}-{end_idx} de {num_items} pacotes [{sort_label}]"
            buf.append(f"  {DIM}── {scroll_info} ──{RESET}{ESC}K\n")
            lines += 1

            if warning_msg:
                buf.append(f"  {GOLD_STAR}⚠️  {warning_msg}{RESET}{ESC}K\n")
                lines += 1

            lin_spec = focused.get("linux") or {}
            lin_desc = lin_spec.get("apt") or lin_spec.get("flatpak") or lin_spec.get("snap") or ("script" if lin_spec.get("script") else "—")
            win_desc = focused.get("windows") or "—"
            mac_desc = (focused.get("macos") or {}).get("brew") or (focused.get("macos") or {}).get("cask") or "—"

            buf.append(f"{BOLD}{VIOLET}┌─ 🔭 Ficha do Pacote ───────────────────────────────────────────────{RESET}{ESC}K\n")
            buf.append(f"│ {BOLD}Nome:{RESET}      {NEBULA}{focused['name']}{RESET} ({CYAN_DEV}{', '.join(focused.get('tags', []))}{RESET}){ESC}K\n")
            buf.append(f"│ {BOLD}Descrição:{RESET} {WHITE}{focused.get('desc', '')[:max_line_len-16]}{RESET}{ESC}K\n")
            buf.append(f"│ {BOLD}Receitas:{RESET}  Linux: {STARLIGHT}{lin_desc}{RESET} | Win: {STARLIGHT}{win_desc}{RESET} | Mac: {STARLIGHT}{mac_desc}{RESET}{ESC}K\n")
            buf.append(f"{BOLD}{VIOLET}└────────────────────────────────────────────────────────────────────{RESET}{ESC}K\n")
            lines += 5

            back_hint = " | ←/b: Voltar" if allow_back else ""
            footer = f"{DIM}└── [↑/↓: Mover | Espaço: Marcar | a: Todos | /: Buscar | t: Tags | s: Ordem | →/Enter: Salvar{back_hint} | Esc: Sair]{RESET}"
            buf.append(f"{footer}{ESC}K\n")
            lines += 1

            lines_rendered = lines
            sys.stdout.write("".join(buf))
            sys.stdout.flush()

            key = getch()
            warning_msg = ""
            if key in ("UP", "k"):
                cursor = (cursor - 1) % num_items
            elif key in ("DOWN", "j"):
                cursor = (cursor + 1) % num_items
            elif key == "SPACE":
                cur_name = items[cursor]["name"]
                if cur_name in selected_names:
                    selected_names.remove(cur_name)
                else:
                    selected_names.add(cur_name)
            elif key in ("a", "A"):
                if len(selected_names) == len(all_packages):
                    selected_names.clear()
                else:
                    selected_names = set(p["name"] for p in all_packages)
            elif key == "s":
                sort_idx = (sort_idx + 1) % len(sort_modes)
            elif key == "t":
                all_tags = sorted(list(set(t for p in all_packages for t in p.get("tags", []))))
                tag_opts = [("ALL", "🌐 Todas as Categorias", f"{len(all_packages)} pacotes")] + [(t, f"📁 {t.upper()}", f"Filtro de tag") for t in all_tags]
                res_tag = tui_multiselect("Filtrar por Categoria / Tag", tag_opts, default_selected=[selected_tag_filter], allow_back=True, single_choice=True)
                if res_tag != "__BACK__":
                    selected_tag_filter = res_tag[0]
                    cursor = 0
                lines_rendered = 0
            elif key == "/":
                restore_cursor()
                sys.stdout.write(f"\n{BOLD}{GOLD_STAR}Filtrar pacotes por palavra-chave (Enter para limpar): {RESET}")
                sys.stdout.flush()
                try:
                    search_query = input().strip()
                except (EOFError, KeyboardInterrupt):
                    search_query = ""
                cursor = 0
                lines_rendered = 0
                sys.stdout.write(HIDE_CURSOR)
            elif key == "RIGHT":
                cur_name = items[cursor]["name"]
                selected_names.add(cur_name)
                break
            elif key == "ENTER":
                if not selected_names:
                    cur_name = items[cursor]["name"]
                    selected_names.add(cur_name)
                break
            elif allow_back and key in ("b", "B", "LEFT", "BACKSPACE"):
                print()
                return "__BACK__"
            elif key in ("ESC", "q", "Q", "EOF"):
                cancel_and_exit()
    finally:
        sys.stdout.write(SHOW_CURSOR)
        sys.stdout.flush()

    print()
    return [p for p in all_packages if p["name"] in selected_names]


# ------------------------------------------------------------------------------
# 4. Action Handlers
# ------------------------------------------------------------------------------

def apply_theme_items(selected_keys: list[str]) -> int:
    applied = 0
    for key, label, sub, script in THEMES_REGISTRY:
        if key not in selected_keys:
            continue
        print(f"  {NEBULA}• Configurando:{RESET} {WHITE}{label}{RESET} ({DIM}{sub}{RESET})")
        if script.endswith(".sh"):
            target_script = REPO_ROOT / script
            if target_script.exists():
                subprocess.run(["bash", str(target_script)], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
        elif script.endswith(".toml") or script.endswith(".json") or script.endswith(".conf"):
            src = REPO_ROOT / script
            if "starship" in script:
                dst = Path.home() / ".config" / "starship.toml"
                dst.parent.mkdir(parents=True, exist_ok=True)
                shutil.copyfile(src, dst)
            elif "alacritty" in script:
                dst = Path.home() / ".config" / "alacritty" / "alacritty.toml"
                dst.parent.mkdir(parents=True, exist_ok=True)
                shutil.copyfile(src, dst)
            elif "kitty" in script:
                dst = Path.home() / ".config" / "kitty" / "kitty.conf"
                dst.parent.mkdir(parents=True, exist_ok=True)
                shutil.copyfile(src, dst)
        print(f"    {COSMIC_GREEN}✔ Pronto!{RESET}")
        applied += 1
    return applied


def apply_tweak_items(selected_keys: list[str]) -> int:
    applied = 0
    for key, label, sub, script in TWEAKS_REGISTRY:
        if key not in selected_keys:
            continue
        print(f"  {NEBULA}• Aplicando Tweak:{RESET} {WHITE}{label}{RESET} ({DIM}{sub}{RESET})")
        target_script = REPO_ROOT / script
        if target_script.exists():
            subprocess.run(["bash", str(target_script)], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
        print(f"    {COSMIC_GREEN}✔ Pronto!{RESET}")
        applied += 1
    return applied


def run_themes_hub():
    """Granular Item-by-Item Theme Hub."""
    ensure_tty()
    print(f"\n{BOLD}{PURPLE}┌── 🎨 Themes & Multi-OS Styling Hub (Controle Item por Item) {RESET}")
    print(f"{DIM}Marque exatamente quais componentes visuais você deseja ativar:{RESET}\n")

    theme_opts = [(item[0], item[1], item[2]) for item in THEMES_REGISTRY]
    default_active = ["devspace_prompt", "devspace_palette", "devspace_aliases", "devspace_statusline", "firefox_theme", "tmux_conf", "tmux_statusline", "tmux_antighost", "tmux_resurrect"]

    res = tui_multiselect("Selecione os Componentes de Tema & Estilização", theme_opts, default_selected=default_active, allow_back=True)
    if res == "__BACK__":
        return

    print(f"\n{BOLD}{PURPLE}🎨 Aplicando {len(res)} componente(s) visual(is)...{RESET}\n")
    applied = apply_theme_items(res)
    print(f"\n{COSMIC_GREEN}{BOLD}🎉 {applied} tema(s) e estilizações configurados com sucesso!{RESET}\n")


def run_tweaks_hub():
    """Granular Item-by-Item System Tweaks Hub."""
    ensure_tty()
    print(f"\n{BOLD}{PURPLE}┌── ⚙️  System Tweaks, Power & Kernel Hub (Controle Item por Item) {RESET}")
    print(f"{DIM}Marque exatamente quais ajustes de energia, rede e kernel deseja aplicar:{RESET}\n")

    tweak_opts = [(item[0], item[1], item[2]) for item in TWEAKS_REGISTRY]
    default_active = ["pwr_server_mask", "pwr_server_gnome", "pwr_server_lid", "net_bbr", "net_fq", "sys_inotify", "sys_file_max", "sys_swappiness", "storage_docker_root", "storage_docker_logs", "storage_fstrim"]

    res = tui_multiselect("Selecione os Ajustes de Sistema & Energia", tweak_opts, default_selected=default_active, allow_back=True)
    if res == "__BACK__":
        return

    print(f"\n{BOLD}{PURPLE}⚙️  Aplicando {len(res)} ajuste(s) de sistema...{RESET}\n")
    applied = apply_tweak_items(res)
    print(f"\n{COSMIC_GREEN}{BOLD}🎉 {applied} otimização(ões) aplicadas com sucesso!{RESET}\n")


def run_custom_wizard():
    """Complete 4-Step Custom Setup Wizard with Item-by-Item Control."""
    ensure_tty()
    all_packages = load_manifest()
    step = 1

    selected_themes = ["devspace_prompt", "devspace_palette", "devspace_aliases", "devspace_statusline", "firefox_theme", "tmux_conf", "tmux_statusline", "tmux_antighost", "tmux_resurrect"]
    selected_tweaks = ["pwr_server_mask", "pwr_server_gnome", "pwr_server_lid", "net_bbr", "net_fq", "sys_inotify", "sys_file_max", "sys_swappiness", "storage_docker_root", "storage_fstrim"]
    selected_packages: list[dict] = []

    while True:
        # STEP 1: Themes
        if step == 1:
            theme_opts = [(item[0], item[1], item[2]) for item in THEMES_REGISTRY]
            res = tui_multiselect("Wizard (Etapa 1/4): Escolha os Temas & Estilizações", theme_opts, default_selected=selected_themes, allow_back=True)
            if res == "__BACK__":
                return
            selected_themes = res
            step = 2
            continue

        # STEP 2: Tweaks & Power
        elif step == 2:
            tweak_opts = [(item[0], item[1], item[2]) for item in TWEAKS_REGISTRY]
            res = tui_multiselect("Wizard (Etapa 2/4): Escolha as Otimizações de Sistema & Energia", tweak_opts, default_selected=selected_tweaks, allow_back=True)
            if res == "__BACK__":
                step = 1
                continue
            selected_tweaks = res
            step = 3
            continue

        # STEP 3: Applications & Packages
        elif step == 3:
            pkg_method_opts = [
                ("all_browser", "🎯 Navegar e Selecionar Pacote por Pacote (Catálogo 100+)", "Abre o navegador interativo com busca, detalhes e filtros"),
                ("pack_fullstack", PACKS["fullstack"]["title"], PACKS["fullstack"]["description"]),
                ("pack_devops", PACKS["devops"]["title"], PACKS["devops"]["description"]),
                ("pack_ai", PACKS["ai"]["title"], PACKS["ai"]["description"]),
                ("pack_server", PACKS["server_min"]["title"], PACKS["server_min"]["description"]),
                ("pack_all", PACKS["all"]["title"], PACKS["all"]["description"]),
                ("none", "⏩ Pular Instalação de Pacotes", "Aplica apenas os temas e otimizações escolhidos"),
            ]
            res = tui_multiselect("Wizard (Etapa 3/4): Seleção de Softwares & Aplicações", pkg_method_opts, default_selected=["all_browser"], allow_back=True, single_choice=True)
            if res == "__BACK__":
                step = 2
                continue

            chosen_pkg_mode = res[0]

            if chosen_pkg_mode == "none":
                selected_packages = []
            elif chosen_pkg_mode == "all_browser":
                prev_names = set(p["name"] for p in selected_packages) if selected_packages else set()
                b_res = tui_package_browser(all_packages, default_selected_names=prev_names, allow_back=True)
                if b_res == "__BACK__":
                    continue
                selected_packages = b_res
            else:
                pack_key = chosen_pkg_mode.replace("pack_", "")
                pack_tags = PACKS[pack_key]["tags"]
                pack_pool = all_packages if pack_tags == "ALL" else [p for p in all_packages if any(t in pack_tags for t in p.get("tags", []))]
                # Let user refine the pack item-by-item!
                pack_opts = [(p["name"], f"{p['name']:<22} [{','.join(p.get('tags',[]))[:16]}]", p.get("desc","")[:40]) for p in pack_pool]
                pack_selected_names = tui_multiselect(f"Refinar Itens do Pack [{PACKS[pack_key]['title']}]", pack_opts, default_selected=[p["name"] for p in pack_pool], allow_back=True)
                if pack_selected_names == "__BACK__":
                    continue
                selected_packages = [p for p in pack_pool if p["name"] in pack_selected_names]

            step = 4
            continue

        # STEP 4: Review & Confirmation
        elif step == 4:
            print(f"\n{BOLD}{PURPLE}┌── 📋 Resumo da Configuração Personalizada ─────────────────────────{RESET}")
            print(f"│ {BOLD}Temas ({len(selected_themes)} selecionados):{RESET}")
            for t in selected_themes:
                t_label = next((item[1] for item in THEMES_REGISTRY if item[0] == t), t)
                print(f"│   {COSMIC_GREEN}✔{RESET} {WHITE}{t_label}{RESET}")
            print(f"│")
            print(f"│ {BOLD}Ajustes de Sistema & Energia ({len(selected_tweaks)} selecionados):{RESET}")
            for tw in selected_tweaks:
                tw_label = next((item[1] for item in TWEAKS_REGISTRY if item[0] == tw), tw)
                print(f"│   {COSMIC_GREEN}✔{RESET} {WHITE}{tw_label}{RESET}")
            print(f"│")
            print(f"│ {BOLD}Aplicações ({len(selected_packages)} selecionadas):{RESET}")
            if selected_packages:
                pkg_names_str = ", ".join(p["name"] for p in selected_packages[:15])
                if len(selected_packages) > 15:
                    pkg_names_str += f" e mais {len(selected_packages)-15} pacotes..."
                print(f"│   {COSMIC_GREEN}✔{RESET} {WHITE}{pkg_names_str}{RESET}")
            else:
                print(f"│   {DIM}(Nenhum pacote selecionado para instalação){RESET}")
            print(f"{BOLD}{PURPLE}└────────────────────────────────────────────────────────────────────{RESET}\n")

            confirm_opts = [
                ("exec", "🚀 Executar Instalação e Aplicar Todas as Configurações", "Aplica temas, tweaks e instala os pacotes escolhidos"),
                ("dry_run", "🔍 Simular em Dry-Run", "Apenas mostra comandos sem alterar o sistema"),
            ]
            confirm_res = tui_multiselect("Confirmar e Iniciar Execução", confirm_opts, default_selected=["exec"], allow_back=True, single_choice=True)
            if confirm_res == "__BACK__":
                step = 3
                continue

            mode = confirm_res[0]
            is_dry = mode == "dry_run"

            if is_dry:
                print(f"\n{GOLD_STAR}[DRY-RUN] Simulação concluída. Nenhuma alteração foi realizada.{RESET}\n")
                return

            # Execute
            print(f"\n{BOLD}{PURPLE}🚀 Aplicando configurações selecionadas...{RESET}\n")
            apply_theme_items(selected_themes)
            apply_tweak_items(selected_tweaks)

            if selected_packages:
                pkg_names = ",".join(p["name"] for p in selected_packages)
                if IS_LINUX:
                    subprocess.run(["python3", str(REPO_ROOT / "linux" / "install.py"), "--only", pkg_names, "--yes"])
                elif IS_MACOS:
                    subprocess.run(["bash", str(REPO_ROOT / "macos" / "install.sh")])
                elif IS_WINDOWS:
                    subprocess.run(["powershell", "-ExecutionPolicy", "Bypass", "-File", str(REPO_ROOT / "windows" / "install.ps1")])

            print(f"\n{PURPLE}{BOLD}══════════════════════════════════════════════════════════════════════════════════════{RESET}")
            print(f"  {COSMIC_GREEN}{BOLD}🎉 Instalação e Configuração Personalizada Concluídas com Sucesso!{RESET}")
            print(f"  {WHITE}Todos os itens marcados foram configurados e validados no seu sistema.{RESET}")
            print(f"{PURPLE}{BOLD}══════════════════════════════════════════════════════════════════════════════════════{RESET}\n")
            return


def run_quick_setup():
    """Quick setup installing elite CLI tools, DevSpace styling and 24/7 server tweaks."""
    print(f"\n{BOLD}{PURPLE}🚀 Iniciando Instalação Rápida (DevSpace Complete Stack)...{RESET}\n")

    print(f"  {NEBULA}1/3 Aplicando Tema DevSpace, Tmux e Firefox...{RESET}")
    apply_theme_items(["devspace_prompt", "devspace_palette", "devspace_aliases", "devspace_statusline", "firefox_theme", "tmux_conf", "tmux_statusline", "tmux_antighost", "tmux_resurrect"])

    print(f"  {NEBULA}2/3 Aplicando Otimizações de Servidor 24/7 (TCP BBR + Sysctl + Anti-Sleep)...{RESET}")
    apply_tweak_items(["pwr_server_mask", "pwr_server_gnome", "pwr_server_lid", "net_bbr", "net_fq", "sys_inotify", "sys_file_max", "sys_swappiness", "storage_docker_root", "storage_fstrim"])

    if IS_LINUX:
        print(f"  {NEBULA}3/3 Instalando pacotes essenciais de desenvolvimento...{RESET}")
        subprocess.run(["python3", str(REPO_ROOT / "linux" / "install.py"), "--group", "base", "--group", "cli", "--group", "dev", "--yes"])

    print(f"\n{PURPLE}{BOLD}══════════════════════════════════════════════════════════════════════════════════════{RESET}")
    print(f"  {COSMIC_GREEN}{BOLD}🎉 Quick Setup Concluído com Sucesso!{RESET}")
    print(f"  {WHITE}Seu ambiente DevSpace está configurado, otimizado e pronto para alta produtividade.{RESET}")
    print(f"{PURPLE}{BOLD}══════════════════════════════════════════════════════════════════════════════════════{RESET}\n")


def run_diagnostics():
    """System Telemetry & Health Diagnostics."""
    print(f"\n{BOLD}{PURPLE}┌── 📊 Diagnóstico & Telemetria do Sistema ───────────────────────────{RESET}")
    print(f"│ {BOLD}Sistema Operacional:{RESET} {CYAN_DEV}{OS_LABEL}{RESET}")
    print(f"│ {BOLD}Arquitetura:{RESET}         {WHITE}{platform.machine()}{RESET}")
    print(f"│ {BOLD}Processador:{RESET}         {WHITE}{platform.processor() or 'x86_64'}{RESET}")
    print(f"│ {BOLD}Kernel:{RESET}              {WHITE}{platform.release()}{RESET}")

    if IS_LINUX:
        cc_path = Path("/proc/sys/net/ipv4/tcp_congestion_control")
        cc = cc_path.read_text().strip() if cc_path.exists() else "desconhecido"
        qd_path = Path("/proc/sys/net/core/default_qdisc")
        qd = qd_path.read_text().strip() if qd_path.exists() else "desconhecido"
        print(f"│ {BOLD}TCP Congestion:{RESET}      {COSMIC_GREEN if cc=='bbr' else GOLD_STAR}{cc} (qdisc: {qd}){RESET}")

        sleep_status = "desconhecido"
        if shutil.which("systemctl"):
            sleep_status = subprocess.run(["systemctl", "is-enabled", "sleep.target"], capture_output=True, text=True).stdout.strip()
        print(f"│ {BOLD}Sleep Target:{RESET}        {COSMIC_GREEN if sleep_status=='masked' else GOLD_STAR}{sleep_status} (Servidor 24/7){RESET}")

        docker_active = shutil.which("docker") is not None
        print(f"│ {BOLD}Docker Runtime:{RESET}      {COSMIC_GREEN if docker_active else DIM}{'Presente' if docker_active else 'Ausente'}{RESET}")

    print(f"{BOLD}{PURPLE}└────────────────────────────────────────────────────────────────────{RESET}\n")


def run_uninstaller():
    """Safe Uninstaller and Rollback Tool."""
    ensure_tty()
    print(f"\n{BOLD}{PURPLE}┌── 🗑️  Desinstalador & Reversão de Configurações {RESET}")
    print(f"{DIM}Selecione quais modificações deseja reverter:{RESET}\n")

    rollback_opts = [
        ("unmask_sleep", "⚡ Desmascarar Suspensão no Systemd", "Restaura o comportamento padrão de suspensão/hibernação"),
        ("clean_devspace", "🌌 Remover Integrações do DevSpace no Shell", "Remove as linhas do DevSpace do ~/.bashrc e ~/.zshrc"),
        ("clean_firefox", "🦊 Remover Tema Personalizado do Firefox", "Restaura o visual padrão removendo userChrome.css"),
    ]

    res = tui_multiselect("Selecione itens para desinstalar/reverter", rollback_opts, default_selected=[], allow_back=True)
    if res == "__BACK__":
        return

    for item in res:
        if item == "unmask_sleep":
            subprocess.run(["sudo", "systemctl", "unmask", "sleep.target", "suspend.target", "hibernate.target", "hybrid-sleep.target"])
            print(f"  {COSMIC_GREEN}✔ Suspensão desmascarada no systemd.{RESET}")
        elif item == "clean_devspace":
            bashrc = Path.home() / ".bashrc"
            if bashrc.exists():
                txt = bashrc.read_text()
                txt = re.sub(r"# >>> DevSpace.*?# <<< DevSpace.*?\n", "", txt, flags=re.S)
                bashrc.write_text(txt)
                print(f"  {COSMIC_GREEN}✔ DevSpace removido de ~/.bashrc.{RESET}")
        elif item == "clean_firefox":
            ff_dir = Path.home() / ".mozilla" / "firefox"
            if ff_dir.exists():
                for chrome_dir in ff_dir.glob("*/chrome"):
                    shutil.rmtree(chrome_dir, ignore_errors=True)
                print(f"  {COSMIC_GREEN}✔ Temas do Firefox removidos.{RESET}")

    print(f"\n{COSMIC_GREEN}🎉 Processo de limpeza concluído!{RESET}\n")


def run_interactive():
    ensure_tty()
    print_banner()

    all_packages = load_manifest()
    total_packages = len(all_packages)

    step0_choice = "custom"

    while True:
        step0_opts = [
            ("custom", "⚙️  Configuração Personalizada (Wizard Passo a Passo 1-a-1)", "Controle total: Escolha exatamente quais temas, quais tweaks e quais pacotes instalar"),
            ("quick", "🚀 Quick Setup (DevSpace Complete Stack)", "Instalação rápida do stack essencial DevSpace + Firefox + Tmux + 24/7 Tweaks"),
            ("themes", "🎨 Themes & Multi-OS Styling Hub (Item por Item)", f"Selecione entre {len(THEMES_REGISTRY)} componentes de temas, terminal e desktop"),
            ("tweaks", "⚙️  System Tweaks, Power & Kernel Hub (Item por Item)", f"Selecione entre {len(TWEAKS_REGISTRY)} ajustes de energia, rede e kernel"),
            ("packages", "📦 Catálogo Completo de Aplicações", f"Navegue e selecione 1-a-1 entre todos os {total_packages} pacotes catalogados"),
            ("packs", "🗂️  Instalar por Packs Temáticos (Com Refinamento)", "Full-stack, DevOps, IA/LLMs, Acadêmico/LaTeX, Criativo, Servidor Mínimo"),
            ("diag", "📊 Diagnóstico & Telemetria do Sistema", "Inspeciona status do BBR, suspensão, hardware e ambiente"),
            ("uninstall", "🗑️  Desinstalador & Reversão de Configurações", "Reverte temas, configurações de suspensão e dotfiles"),
        ]
        res = tui_multiselect("Escolha o Fluxo de Instalação", step0_opts, default_selected=[step0_choice], allow_back=False, single_choice=True)
        step0_choice = res[0]

        if step0_choice == "custom":
            run_custom_wizard()
            return
        elif step0_choice == "quick":
            run_quick_setup()
            return
        elif step0_choice == "themes":
            run_themes_hub()
            continue
        elif step0_choice == "tweaks":
            run_tweaks_hub()
            continue
        elif step0_choice == "diag":
            run_diagnostics()
            continue
        elif step0_choice == "uninstall":
            run_uninstaller()
            continue
        elif step0_choice == "packages":
            selected = tui_package_browser(all_packages, allow_back=True)
            if selected == "__BACK__":
                continue
            if selected and IS_LINUX:
                pkg_names = ",".join(p["name"] for p in selected)
                subprocess.run(["python3", str(REPO_ROOT / "linux" / "install.py"), "--only", pkg_names])
            return
        elif step0_choice == "packs":
            pack_opts = []
            for k, v in PACKS.items():
                pack_opts.append((k, v["title"], v["description"]))

            pack_res = tui_multiselect("Selecione um Pack Temático", pack_opts, default_selected=["fullstack"], allow_back=True, single_choice=True)
            if pack_res == "__BACK__":
                continue

            chosen_pack = pack_res[0]
            pack_tags = PACKS[chosen_pack]["tags"]
            pack_pool = all_packages if pack_tags == "ALL" else [p for p in all_packages if any(t in pack_tags for t in p.get("tags", []))]

            pack_item_opts = [(p["name"], f"{p['name']:<22} [{','.join(p.get('tags',[]))[:16]}]", p.get("desc","")[:40]) for p in pack_pool]
            refined_names = tui_multiselect(f"Refinar Pacotes do Pack [{PACKS[chosen_pack]['title']}]", pack_item_opts, default_selected=[p["name"] for p in pack_pool], allow_back=True)
            if refined_names == "__BACK__":
                continue

            if refined_names and IS_LINUX:
                pkg_names = ",".join(refined_names)
                subprocess.run(["python3", str(REPO_ROOT / "linux" / "install.py"), "--only", pkg_names])
            return


def main():
    parser = argparse.ArgumentParser(
        prog="meu-setup installer",
        description="Universal Multi-System Installer for meu-setup (Cosmic Purple Dev Edition)",
    )
    parser.add_argument("--wizard", action="store_true", help="Abre o wizard passo a passo com controle total item por item")
    parser.add_argument("--quick", action="store_true", help="Instalação rápida do stack essencial DevSpace")
    parser.add_argument("--themes", action="store_true", help="Abre o hub de temas e estilização item por item")
    parser.add_argument("--tweaks", action="store_true", help="Abre o hub de ajustes de sistema, energia e kernel item por item")
    parser.add_argument("--pack", choices=list(PACKS.keys()), help="Instala um pack temático")
    parser.add_argument("--group", action="append", default=[], help="Instala pacotes de uma tag específica")
    parser.add_argument("--only", help="Lista de nomes de pacotes separados por vírgula")
    parser.add_argument("--list", action="store_true", help="Lista todos os pacotes e grupos")
    parser.add_argument("--diag", action="store_true", help="Exibe telemetria e diagnóstico do sistema")
    parser.add_argument("--uninstall", action="store_true", help="Abre o menu de reversão e desinstalação")
    parser.add_argument("--dry-run", action="store_true", help="Simula ações sem aplicar alterações")
    parser.add_argument("--yes", "-y", action="store_true", help="Executa sem pedir confirmações")

    args = parser.parse_args()

    if args.list:
        print_banner()
        all_pkgs = load_manifest()
        print(f"{BOLD}{PURPLE}=== Total: {len(all_pkgs)} pacotes catalogados ==={RESET}\n")
        for p in all_pkgs:
            tags = ",".join(p.get("tags", []))
            print(f"  • {BOLD}{p['name']:<24}{RESET} {PURPLE}[{tags:20}]{RESET} {DIM}{p.get('desc', '')}{RESET}")
        return

    if args.diag:
        print_banner()
        run_diagnostics()
        return

    if args.wizard:
        run_custom_wizard()
        return

    if args.quick:
        run_quick_setup()
        return

    if args.themes:
        run_themes_hub()
        return

    if args.tweaks:
        run_tweaks_hub()
        return

    if args.uninstall:
        run_uninstaller()
        return

    if args.pack or args.group or args.only:
        all_pkgs = load_manifest()
        if args.pack:
            tags = PACKS[args.pack]["tags"]
            selected = all_pkgs if tags == "ALL" else [p for p in all_pkgs if any(t in tags for t in p.get("tags", []))]
        elif args.group:
            wanted_tags = set(args.group)
            selected = [p for p in all_pkgs if wanted_tags & set(p.get("tags", []))]
        elif args.only:
            wanted_names = set(n.strip() for n in args.only.split(","))
            selected = [p for p in all_pkgs if p["name"] in wanted_names]
        else:
            selected = all_pkgs

        if IS_LINUX:
            pkg_names = ",".join(p["name"] for p in selected)
            cmd = ["python3", str(REPO_ROOT / "linux" / "install.py"), "--only", pkg_names]
            if args.dry_run: cmd.append("--dry-run")
            if args.yes: cmd.append("--yes")
            subprocess.run(cmd)
        return

    try:
        run_interactive()
    except (KeyboardInterrupt, EOFError):
        cancel_and_exit()


if __name__ == "__main__":
    main()
