#!/usr/bin/env bash
# Fast JSON telemetry generator for GNOME Shell Desktop HUD
export LC_ALL=C

# 1. CPU Load & Temps
read -r _ u n s i io ir sq st _ < /proc/stat
total=$((u + n + s + i + io + ir + sq + st))
idle=$((i + io))

cache_file="/tmp/.devspace_cpu_tick"
cpu_pct=0
if [ -f "$cache_file" ]; then
    read -r prev_total prev_idle < "$cache_file"
    d_total=$((total - prev_total))
    d_idle=$((idle - prev_idle))
    if [ "$d_total" -gt 0 ]; then
        cpu_pct=$(( (100 * (d_total - d_idle)) / d_total ))
    fi
fi
echo "$total $idle" > "$cache_file"
[ "$cpu_pct" -lt 0 ] && cpu_pct=0
[ "$cpu_pct" -gt 100 ] && cpu_pct=100

cpu_temp=0
c0=0; c1=0; c2=0; c3=0; c4=0; c5=0
if command -v sensors >/dev/null 2>&1; then
    s_out=$(sensors 2>/dev/null)
    pkg_line=$(echo "$s_out" | grep 'Package id 0:' | head -n 1)
    if [ -n "$pkg_line" ]; then
        cpu_temp=$(echo "$pkg_line" | awk -F'[+.]' '{print $2}')
    fi
    c0=$(echo "$s_out" | grep 'Core 0:' | head -n 1 | awk -F'[+.]' '{print $2}')
    c1=$(echo "$s_out" | grep 'Core 1:' | head -n 1 | awk -F'[+.]' '{print $2}')
    c2=$(echo "$s_out" | grep 'Core 2:' | head -n 1 | awk -F'[+.]' '{print $2}')
    c3=$(echo "$s_out" | grep 'Core 3:' | head -n 1 | awk -F'[+.]' '{print $2}')
    c4=$(echo "$s_out" | grep 'Core 4:' | head -n 1 | awk -F'[+.]' '{print $2}')
    c5=$(echo "$s_out" | grep 'Core 5:' | head -n 1 | awk -F'[+.]' '{print $2}')
fi
[[ "$cpu_temp" =~ ^[0-9]+$ ]] || cpu_temp=45
[[ "$c0" =~ ^[0-9]+$ ]] || c0=45
[[ "$c1" =~ ^[0-9]+$ ]] || c1=45
[[ "$c2" =~ ^[0-9]+$ ]] || c2=45
[[ "$c3" =~ ^[0-9]+$ ]] || c3=45
[[ "$c4" =~ ^[0-9]+$ ]] || c4=45
[[ "$c5" =~ ^[0-9]+$ ]] || c5=45

# 2. NVIDIA GPU
gpu_temp=0; gpu_util=0; vram_used=0; vram_tot=6144; gpu_power=0
if command -v nvidia-smi >/dev/null 2>&1; then
    nv_out=$(nvidia-smi --query-gpu=temperature.gpu,utilization.gpu,memory.used,memory.total,power.draw --format=csv,noheader,nounits 2>/dev/null | head -n 1)
    if [ -n "$nv_out" ]; then
        IFS=',' read -r g_t g_u v_u v_t g_p <<< "$nv_out"
        gpu_temp=$(echo "$g_t" | tr -d ' ')
        gpu_util=$(echo "$g_u" | tr -d ' ')
        vram_used=$(echo "$v_u" | tr -d ' ')
        vram_tot=$(echo "$v_t" | tr -d ' ')
        gpu_power=$(echo "$g_p" | tr -d ' ')
    fi
fi
[[ "$gpu_temp" =~ ^[0-9]+$ ]] || gpu_temp=45
[[ "$gpu_util" =~ ^[0-9]+$ ]] || gpu_util=0
[[ "$vram_used" =~ ^[0-9]+$ ]] || vram_used=500
[[ "$vram_tot" =~ ^[0-9]+$ ]] || vram_tot=6144

# 3. RAM & Swap
read -r ram_used ram_tot ram_avail ram_pct swap_pct < <(free -b | awk '
/^Mem:/ {
    tot = $2 / (1024^3);
    used = ($2 - $7) / (1024^3);
    avail = $7 / (1024^3);
    pct = (used / tot) * 100;
    printf "%.1f %.1f %.1f %d ", used, tot, avail, int(pct + 0.5);
}
/^Swap:/ {
    if ($2 > 0) { spct = ($3 / $2) * 100; printf "%d\n", int(spct + 0.5); }
    else { printf "0\n"; }
}')

# 4. Disks
read -r root_used root_tot root_pct < <(df -h / | awk 'NR==2 { gsub("%","",$5); print $3, $2, $5 }')
read -r home_used home_tot home_pct < <(df -h /home | awk 'NR==2 { gsub("%","",$5); print $3, $2, $5 }')

# 5. Network & Motherboard
lan_ip=$(hostname -I 2>/dev/null | awk '{print $1}')
tail_ip=$(tailscale ip -4 2>/dev/null || true)

cat << EOF
{
  "cpu_pct": ${cpu_pct:-0},
  "cpu_temp": ${cpu_temp:-45},
  "c0": ${c0:-45}, "c1": ${c1:-45}, "c2": ${c2:-45}, "c3": ${c3:-45}, "c4": ${c4:-45}, "c5": ${c5:-45},
  "gpu_pct": ${gpu_util:-0},
  "gpu_temp": ${gpu_temp:-45},
  "vram_used": ${vram_used:-0},
  "vram_tot": ${vram_tot:-6144},
  "gpu_power": "${gpu_power:-8.0}",
  "ram_used": "${ram_used:-5.8}",
  "ram_tot": "${ram_tot:-15.6}",
  "ram_avail": "${ram_avail:-9.8}",
  "ram_pct": ${ram_pct:-37},
  "swap_pct": ${swap_pct:-0},
  "root_used": "${root_used:-46G}",
  "root_tot": "${root_tot:-56G}",
  "root_pct": ${root_pct:-87},
  "home_used": "${home_used:-163G}",
  "home_tot": "${home_tot:-844G}",
  "home_pct": ${home_pct:-21},
  "lan_ip": "${lan_ip:-192.168.0.33}",
  "tail_ip": "${tail_ip:-100.120.54.126}"
}
EOF
