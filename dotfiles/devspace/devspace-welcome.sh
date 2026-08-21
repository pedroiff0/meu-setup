#!/usr/bin/env bash
# ==============================================================================
# Pedro Shadow Monarch OS — Ultimate Complete Hardware & System Telemetry Fetch
# ==============================================================================

# Sai silencioso se nao for terminal interativo (evita quebrar scp/rsync)
[ -t 1 ] || exit 0

# Cores ANSI Truecolor Neon Cósmicas
C_RESET=$'\033[0m'
C_BOLD=$'\033[1m'
C_DIM=$'\033[2m'
C_PURPLE=$'\033[38;2;168;85;247m'   # Hollow Purple
C_CYAN=$'\033[38;2;0;243;255m'      # Electric Cyan
C_RED=$'\033[38;2;244;63;94m'       # Crimson Red
C_GOLD=$'\033[38;2;251;191;36m'     # Astral Gold
C_GREEN=$'\033[38;2;16;185;129m'    # Emerald Green
C_MAGENTA=$'\033[38;2;217;70;239m'  # Deep Magenta
C_SLATE=$'\033[38;2;148;163;184m'   # Slate Grey
C_WHITE=$'\033[38;2;241;245;249m'   # Snow White

# 1. Animação Fluida do Vapor de Café Cósmico (~180ms)
anima_cafe() {
  local frames=(
    "   ( ( (      ·  ✧ "
    "    ) ) )    ✦  ·  "
    "   ( ( (       ✧ · "
  )
  for f in "${frames[@]}"; do
    printf "\r%s%s%s" "$C_CYAN" "$f" "$C_RESET"
    sleep 0.06
  done
  printf "\r%30s\r" ""
}
[ -z "${NO_ANIM:-}" ] && anima_cafe

# 2. Coleta Precisa e Completa de Hardware & Sistema
USER_NAME="$(whoami)"
HOST_NAME="$(hostname -s 2>/dev/null || hostname)"
OS_NAME="Pedro Shadow Monarch OS (Debian 13 Trixie x86_64)"
KERNEL_VER="$(uname -r)"
UPTIME_STR="$(uptime -p 2>/dev/null | sed 's/^up //' || uptime | awk -F'( |,|:)+' '{print $6 "h " $7 "m"}')"
DEB_PKGS="$(dpkg -l 2>/dev/null | grep -c '^ii')"
FLAT_PKGS="$(flatpak list 2>/dev/null | wc -l)"
PKGS_STR="${DEB_PKGS} (dpkg), ${FLAT_PKGS} (flatpak)"
SHELL_STR="Bash ${BASH_VERSION%%(*}"
THEME_STR="WhiteSur-Dark-purple"
ICONS_STR="WhiteSur-purple-dark"
CURSOR_STR="WhiteSur-cursors"
TERM_STR="${TERM_PROGRAM:-GNOME Terminal} (${TERM:-xterm-256color})"
MOTHERBOARD="$(cat /sys/devices/virtual/dmi/id/board_name 2>/dev/null || echo 'Gigabyte H310M H 2.0')"

# CPU
CPU_RAW="$(lscpu 2>/dev/null | grep 'Model name' | head -n 1 | cut -d: -f2 | xargs)"
CPU_MODEL="${CPU_RAW:-Intel Core i5-9400F CPU @ 2.90GHz}"
CPU_CORES="$(nproc 2>/dev/null || echo 6)"
CPU_MAX_MHZ="$(lscpu 2>/dev/null | grep 'CPU max MHz' | awk '{printf "%.2f GHz", $4/1000}')"
[ -z "$CPU_MAX_MHZ" ] && CPU_MAX_MHZ="4.10 GHz"

# GPU NVIDIA
GPU_NAME="$(nvidia-smi --query-gpu=name --format=csv,noheader 2>/dev/null | head -n 1 || echo 'NVIDIA GeForce GTX 1660')"
GPU_DRIVER="$(nvidia-smi --query-gpu=driver_version --format=csv,noheader 2>/dev/null | head -n 1 || echo '610.57')"
GPU_TEMP="$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader 2>/dev/null | head -n 1 || echo '54')°C"
GPU_VRAM_USED="$(nvidia-smi --query-gpu=memory.used --format=csv,noheader 2>/dev/null | head -n 1 || echo '180 MiB')"
GPU_VRAM_TOTAL="$(nvidia-smi --query-gpu=memory.total --format=csv,noheader 2>/dev/null | head -n 1 || echo '6144 MiB')"
GPU_POWER="$(nvidia-smi --query-gpu=power.draw --format=csv,noheader 2>/dev/null | head -n 1 || echo '21.4 W')"

# Memória RAM & Swap
MEM_LINE="$(LC_ALL=C free -m 2>/dev/null | awk '/Mem:/ {printf "%.1f GiB / %.1f GiB (%.1f%%) | Disp: %.1f GiB", $3/1024, $2/1024, ($3/$2)*100, $7/1024}')"
SWAP_LINE="$(LC_ALL=C free -m 2>/dev/null | awk '/Swap:/ {if ($2>0) printf "%.1f GiB / %.1f GiB (%.1f%%)", $3/1024, $2/1024, ($3/$2)*100; else print "Desativado"}')"

# Discos
DISK_ROOT="$(df -h / 2>/dev/null | awk 'NR==2 {print $3 " / " $2 " (" $5 ")"}')"
DISK_HOME="$(df -h /home 2>/dev/null | awk 'NR==2 {print $3 " / " $2 " (" $5 ")"}')"
DISK_WIN="222.6 GiB (NTFS / Windows SSD)"

# Rede & IPs
ETH_IP="$(ip -4 addr show enp5s0 2>/dev/null | awk '/inet / {print $2}' | cut -d/ -f1)"
[ -z "$ETH_IP" ] && ETH_IP="$(hostname -I 2>/dev/null | awk '{print $1}')"
TAIL_IP="$(ip -4 addr show tailscale0 2>/dev/null | awk '/inet / {print $2}' | cut -d/ -f1)"
[ -n "$TAIL_IP" ] && IP_STR="${ETH_IP} (LAN) | ${TAIL_IP} (Tailscale)" || IP_STR="${ETH_IP}"

LOCALE_STR="${LANG:-pt_BR.UTF-8}"
DISPLAY_STR="1920x1080 @ 60Hz (Wayland / GNOME 48.7)"

# 3. Renderização do Dashboard Completo
echo
echo -e "${C_CYAN}         (  (  (            ${C_PURPLE}✦ ${C_BOLD}${USER_NAME}${C_RESET}@${C_CYAN}${HOST_NAME}${C_RESET}"
echo -e "${C_CYAN}          )  )  )           ${C_PURPLE}------------------------------------------------------------${C_RESET}"
echo -e "${C_PURPLE}        .----------.        ${C_PURPLE}🌌 OS:${C_RESET}          ${C_WHITE}${OS_NAME}${C_RESET}"
echo -e "${C_PURPLE}       /  ${C_GOLD}☕ DEV${C_PURPLE}   / )       ${C_PURPLE}🏠 Host:${C_RESET}        ${C_WHITE}${HOST_NAME} (${MOTHERBOARD})${C_RESET}"
echo -e "${C_PURPLE}      |  ${C_CYAN}COSMOS${C_PURPLE}  |/ /        ${C_PURPLE}🐧 Kernel:${C_RESET}      ${C_WHITE}${KERNEL_VER}${C_RESET}"
echo -e "${C_PURPLE}      |  ${C_MAGENTA}COFFEE${C_PURPLE}  | /         ${C_PURPLE}⏱ Uptime:${C_RESET}      ${C_WHITE}${UPTIME_STR}${C_RESET}"
echo -e "${C_PURPLE}       \\        /           ${C_PURPLE}📦 Packages:${C_RESET}    ${C_WHITE}${PKGS_STR}${C_RESET}"
echo -e "${C_PURPLE}        '------'            ${C_PURPLE}🖥 Display:${C_RESET}     ${C_WHITE}${DISPLAY_STR}${C_RESET}"
echo -e "${C_PURPLE}     ·  ✦    ✧   ·          ${C_PURPLE}🐚 Shell:${C_RESET}       ${C_WHITE}${SHELL_STR}${C_RESET}"
echo -e "${C_PURPLE}   ___   ___ __   __        ${C_PURPLE}🎨 Theme:${C_RESET}       ${C_WHITE}${THEME_STR}${C_RESET}"
echo -e "${C_PURPLE}  |   \\ | __|\\ \\ / /        ${C_PURPLE}🎭 Icons:${C_RESET}       ${C_WHITE}${ICONS_STR}${C_RESET}"
echo -e "${C_PURPLE}  | |) || _|  \\ V /         ${C_PURPLE}🖱 Cursor:${C_RESET}      ${C_WHITE}${CURSOR_STR}${C_RESET}"
echo -e "${C_PURPLE}  |___/ |___|  \\_/          ${C_PURPLE}📟 Terminal:${C_RESET}    ${C_WHITE}${TERM_STR}${C_RESET}"
echo -e "${C_PURPLE}                            💻 CPU:${C_RESET}         ${C_WHITE}${CPU_MODEL}${C_RESET} (${C_CYAN}${CPU_CORES} Cores @ ${CPU_MAX_MHZ}${C_RESET})"
echo -e "${C_PURPLE}                            🎮 GPU:${C_RESET}         ${C_WHITE}${GPU_NAME}${C_RESET} (${C_RED}${GPU_TEMP}${C_RESET}, ${C_GOLD}${GPU_POWER}${C_RESET})"
echo -e "${C_PURPLE}                            🎮 VRAM:${C_RESET}        ${C_WHITE}${GPU_VRAM_USED} / ${GPU_VRAM_TOTAL}${C_RESET} (Driver: ${GPU_DRIVER})"
echo -e "${C_PURPLE}                            🧠 Memory (RAM):${C_RESET} ${C_WHITE}${MEM_LINE}${C_RESET}"
echo -e "${C_PURPLE}                            🔄 Swap:${C_RESET}        ${C_WHITE}${SWAP_LINE}${C_RESET}"
echo -e "${C_PURPLE}                            💾 Disk (/):${C_RESET}    ${C_WHITE}${DISK_ROOT} [SSD 1TB / ext4]${C_RESET}"
echo -e "${C_PURPLE}                            🏠 Disk (/home):${C_RESET} ${C_WHITE}${DISK_HOME} [SSD 1TB / ext4]${C_RESET}"
echo -e "${C_PURPLE}                            🪟 Disk (Win):${C_RESET}   ${C_WHITE}${DISK_WIN}${C_RESET}"
echo -e "${C_PURPLE}                            🌐 Network IP:${C_RESET}  ${C_WHITE}${IP_STR}${C_RESET}"
echo -e "${C_PURPLE}                            🗺 Locale:${C_RESET}      ${C_WHITE}${LOCALE_STR}${C_RESET}"
echo -e "${C_PURPLE}                            ⚡ Palette:${C_RESET}     \033[48;2;18;13;34m  \033[48;2;168;85;247m  \033[48;2;0;243;255m  \033[48;2;244;63;94m  \033[48;2;251;191;36m  \033[48;2;16;185;129m  \033[48;2;241;245;249m  ${C_RESET}"
echo
