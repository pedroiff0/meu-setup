#!/usr/bin/env python3
# ==============================================================================
# Pedro Shadow Monarch OS — Ultimate Desktop Hardware HUD & Telemetry Widget
# ==============================================================================

import os
import sys
import time
import subprocess
import gi

gi.require_version('Gtk', '3.0')
gi.require_version('Gdk', '3.0')
from gi.repository import Gtk, Gdk, GLib, Pango

class HardwareHUD(Gtk.Window):
    def __init__(self):
        super().__init__(type=Gtk.WindowType.TOPLEVEL)
        
        self.set_title("✦ DevSpace Hardware HUD ✦")
        self.set_decorated(False)
        self.set_resizable(False)
        self.set_skip_taskbar_hint(True)
        self.set_skip_pager_hint(True)
        self.set_accept_focus(True)
        self.stick()
        
        # Position on right side of screen
        self.set_default_size(360, 890)
        self.move(1530, 48)
        
        # Allow dragging window anywhere
        self.add_events(Gdk.EventMask.BUTTON_PRESS_MASK)
        self.connect("button-press-event", self.on_button_press)
        
        # Enable RGBA visual
        screen = self.get_screen()
        visual = screen.get_rgba_visual()
        if visual and screen.is_composited():
            self.set_visual(visual)
        self.set_app_paintable(True)
        
        self.setup_css()
        
        # Main Container
        main_box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=8)
        main_box.set_name("hud-container")
        self.add(main_box)
        
        # 1. Header with Close Button & Title
        header_box = Gtk.Box(orientation=Gtk.Orientation.HORIZONTAL, spacing=6)
        header_box.set_name("hud-header")
        
        btn_close = Gtk.Button()
        btn_close.set_name("btn-close")
        btn_close.connect("clicked", lambda w: Gtk.main_quit())
        btn_close.set_tooltip_text("Fechar Widget")
        header_box.pack_start(btn_close, False, False, 2)
        
        title_box = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=1)
        lbl_title = Gtk.Label()
        lbl_title.set_markup("<span font='JetBrains Mono Bold 10' foreground='#c084fc'>✦ HARDWARE &amp; SENSORS HUD ✦</span>")
        lbl_title.set_xalign(0)
        lbl_subtitle = Gtk.Label()
        lbl_subtitle.set_markup("<span font='JetBrains Mono 8' foreground='#94a3b8'>Planck • Debian 13 • GTX 1660</span>")
        lbl_subtitle.set_xalign(0)
        title_box.pack_start(lbl_title, False, False, 0)
        title_box.pack_start(lbl_subtitle, False, False, 0)
        header_box.pack_start(title_box, True, True, 4)
        
        main_box.pack_start(header_box, False, False, 0)
        
        # 2. CPU Card
        cpu_card = self.create_card("💻 CPU: Intel Core i5-9400F (6 Cores)", "#38bdf8")
        self.lbl_cpu_main = Gtk.Label(xalign=0)
        self.bar_cpu = Gtk.ProgressBar(show_text=False)
        self.lbl_cpu_cores = Gtk.Label(xalign=0)
        cpu_card.pack_start(self.lbl_cpu_main, False, False, 0)
        cpu_card.pack_start(self.bar_cpu, False, False, 2)
        cpu_card.pack_start(self.lbl_cpu_cores, False, False, 0)
        main_box.pack_start(cpu_card, False, False, 0)
        
        # 3. GPU Card
        gpu_card = self.create_card("🎮 GPU: NVIDIA GeForce GTX 1660", "#a855f7")
        self.lbl_gpu_main = Gtk.Label(xalign=0)
        self.bar_gpu = Gtk.ProgressBar(show_text=False)
        self.lbl_gpu_vram = Gtk.Label(xalign=0)
        self.bar_vram = Gtk.ProgressBar(show_text=False)
        gpu_card.pack_start(self.lbl_gpu_main, False, False, 0)
        gpu_card.pack_start(self.bar_gpu, False, False, 2)
        gpu_card.pack_start(self.lbl_gpu_vram, False, False, 0)
        gpu_card.pack_start(self.bar_vram, False, False, 2)
        main_box.pack_start(gpu_card, False, False, 0)
        
        # 4. RAM & Swap Card
        ram_card = self.create_card("🧠 Memória RAM &amp; Swap", "#34d399")
        self.lbl_ram_main = Gtk.Label(xalign=0)
        self.bar_ram = Gtk.ProgressBar(show_text=False)
        self.lbl_swap = Gtk.Label(xalign=0)
        ram_card.pack_start(self.lbl_ram_main, False, False, 0)
        ram_card.pack_start(self.bar_ram, False, False, 2)
        ram_card.pack_start(self.lbl_swap, False, False, 0)
        main_box.pack_start(ram_card, False, False, 0)
        
        # 5. Storage Card
        disk_card = self.create_card("💾 Armazenamento &amp; SSDs", "#fbbf24")
        self.lbl_disk_root = Gtk.Label(xalign=0)
        self.bar_disk_root = Gtk.ProgressBar(show_text=False)
        self.lbl_disk_home = Gtk.Label(xalign=0)
        self.bar_disk_home = Gtk.ProgressBar(show_text=False)
        self.lbl_disk_win = Gtk.Label(xalign=0)
        disk_card.pack_start(self.lbl_disk_root, False, False, 0)
        disk_card.pack_start(self.bar_disk_root, False, False, 2)
        disk_card.pack_start(self.lbl_disk_home, False, False, 0)
        disk_card.pack_start(self.bar_disk_home, False, False, 2)
        disk_card.pack_start(self.lbl_disk_win, False, False, 0)
        main_box.pack_start(disk_card, False, False, 0)
        
        # 6. Motherboard & Network
        mobo_card = self.create_card("🌐 Placa-Mãe &amp; Rede", "#f43f5e")
        self.lbl_mobo = Gtk.Label(xalign=0)
        self.lbl_net = Gtk.Label(xalign=0)
        mobo_card.pack_start(self.lbl_mobo, False, False, 0)
        mobo_card.pack_start(self.lbl_net, False, False, 0)
        main_box.pack_start(mobo_card, False, False, 0)
        
        self.last_cpu_idle = 0
        self.last_cpu_total = 0
        
        self.update_telemetry()
        GLib.timeout_add_seconds(2, self.update_telemetry)

    def on_button_press(self, widget, event):
        if event.button == 1:
            self.begin_move_drag(event.button, int(event.x_root), int(event.y_root), event.time)

    def create_card(self, title_markup, accent_color):
        card = Gtk.Box(orientation=Gtk.Orientation.VERTICAL, spacing=4)
        card.set_name("hud-card")
        lbl_head = Gtk.Label(xalign=0)
        lbl_head.set_markup(f"<span font='JetBrains Mono Bold 9' foreground='{accent_color}'>{title_markup}</span>")
        card.pack_start(lbl_head, False, False, 2)
        return card

    def setup_css(self):
        css = b"""
        #hud-container {
            background-color: rgba(18, 13, 34, 0.94);
            border: 1px solid rgba(168, 85, 247, 0.5);
            border-radius: 16px;
            padding: 12px 14px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.8);
        }
        #hud-header {
            border-bottom: 1px solid rgba(168, 85, 247, 0.25);
            padding-bottom: 6px;
        }
        #btn-close {
            background-color: #ef4444;
            border-radius: 9999px;
            min-width: 12px;
            min-height: 12px;
            padding: 0;
            margin-right: 4px;
            border: none;
        }
        #btn-close:hover {
            background-color: #dc2626;
        }
        #hud-card {
            background-color: rgba(30, 27, 52, 0.75);
            border: 1px solid rgba(124, 58, 237, 0.25);
            border-radius: 10px;
            padding: 6px 8px;
        }
        progressbar trough {
            background-color: rgba(15, 12, 28, 0.85);
            border-radius: 4px;
            min-height: 5px;
        }
        progressbar progress {
            background-image: linear-gradient(to right, #7c3aed, #a855f7, #00f3ff);
            border-radius: 4px;
            min-height: 5px;
        }
        """
        provider = Gtk.CssProvider()
        provider.load_from_data(css)
        Gtk.StyleContext.add_provider_for_screen(
            Gdk.Screen.get_default(),
            provider,
            Gtk.STYLE_PROVIDER_PRIORITY_APPLICATION
        )

    def get_cpu_load(self):
        try:
            with open('/proc/stat') as f:
                fields = [float(column) for column in f.readline().strip().split()[1:]]
            idle, total = fields[3], sum(fields)
            if self.last_cpu_total > 0:
                d_idle = idle - self.last_cpu_idle
                d_total = total - self.last_cpu_total
                load = 100.0 * (1.0 - (d_idle / d_total)) if d_total > 0 else 0.0
            else:
                load = 0.0
            self.last_cpu_idle = idle
            self.last_cpu_total = total
            return max(0.0, min(100.0, load))
        except Exception:
            return 0.0

    def get_sensors_data(self):
        core_temps = []
        pkg_temp = 0.0
        mobo_temps = []
        try:
            out = subprocess.check_output(['sensors'], text=True, stderr=subprocess.DEVNULL)
            for line in out.splitlines():
                if 'Package id 0:' in line:
                    parts = line.split('+')
                    if len(parts) > 1:
                        pkg_temp = float(parts[1].split('°')[0])
                elif 'Core ' in line and ':' in line and '°C' in line:
                    parts = line.split('+')
                    if len(parts) > 1:
                        core_temps.append(float(parts[1].split('°')[0]))
                elif 'temp' in line and 'gigabyte' not in line:
                    parts = line.split('+')
                    if len(parts) > 1:
                        try:
                            t = float(parts[1].split('°')[0])
                            if 20 <= t <= 90:
                                mobo_temps.append(t)
                        except Exception:
                            pass
        except Exception:
            pass
        return pkg_temp, core_temps, mobo_temps

    def get_nvidia_data(self):
        try:
            out = subprocess.check_output(
                ['nvidia-smi', '--query-gpu=temperature.gpu,utilization.gpu,utilization.memory,memory.used,memory.total,power.draw', '--format=csv,noheader,nounits'],
                text=True, stderr=subprocess.DEVNULL
            ).strip()
            parts = [p.strip() for p in out.split(',')]
            if len(parts) >= 6:
                return {
                    'temp': float(parts[0]),
                    'gpu_util': float(parts[1]),
                    'mem_util': float(parts[2]),
                    'vram_used': float(parts[3]),
                    'vram_total': float(parts[4]),
                    'power': float(parts[5])
                }
        except Exception:
            pass
        return {'temp': 0, 'gpu_util': 0, 'mem_util': 0, 'vram_used': 0, 'vram_total': 6144, 'power': 0}

    def get_ram_data(self):
        try:
            out = subprocess.check_output(['free', '-b'], text=True, stderr=subprocess.DEVNULL, env={'LC_ALL': 'C'})
            lines = out.splitlines()
            mem = lines[1].split()
            swap = lines[2].split() if len(lines) > 2 else []
            total_ram = float(mem[1]) / (1024**3)
            used_ram = (float(mem[1]) - float(mem[6])) / (1024**3)
            avail_ram = float(mem[6]) / (1024**3)
            ram_pct = (used_ram / total_ram) * 100.0 if total_ram > 0 else 0
            
            swap_pct = 0.0
            if swap and float(swap[1]) > 0:
                swap_pct = (float(swap[2]) / float(swap[1])) * 100.0
            return used_ram, total_ram, avail_ram, ram_pct, swap_pct
        except Exception:
            return 0, 16, 16, 0, 0

    def get_disk_data(self):
        def parse_df(path):
            try:
                out = subprocess.check_output(['df', '-h', path], text=True, stderr=subprocess.DEVNULL, env={'LC_ALL': 'C'})
                line = out.splitlines()[1].split()
                return line[2], line[1], float(line[4].replace('%', ''))
            except Exception:
                return "0G", "0G", 0.0
        
        root_used, root_tot, root_pct = parse_df('/')
        home_used, home_tot, home_pct = parse_df('/home')
        return (root_used, root_tot, root_pct), (home_used, home_tot, home_pct)

    def get_net_ip(self):
        try:
            lan = subprocess.check_output(['hostname', '-I'], text=True, stderr=subprocess.DEVNULL).split()[0]
        except Exception:
            lan = "127.0.0.1"
        try:
            tailscale = subprocess.check_output(['tailscale', 'ip', '-4'], text=True, stderr=subprocess.DEVNULL).strip()
        except Exception:
            tailscale = ""
        return lan, tailscale

    def temp_color(self, t):
        if t >= 80: return "#ef4444"
        if t >= 65: return "#f59e0b"
        if t >= 50: return "#a855f7"
        return "#10b981"

    def update_telemetry(self):
        cpu_pct = self.get_cpu_load()
        pkg_temp, core_temps, mobo_temps = self.get_sensors_data()
        t_col = self.temp_color(pkg_temp)
        self.lbl_cpu_main.set_markup(
            f"<span font='JetBrains Mono 8.5'><b>Uso:</b> {cpu_pct:.1f}%  |  <b>Temp:</b> <span foreground='{t_col}'>{pkg_temp:.1f}°C</span></span>"
        )
        self.bar_cpu.set_fraction(cpu_pct / 100.0)
        
        if core_temps:
            cores_str = " ".join([f"<span foreground='{self.temp_color(t)}'>C{i}:{int(t)}°</span>" for i, t in enumerate(core_temps[:6])])
            self.lbl_cpu_cores.set_markup(f"<span font='JetBrains Mono 7.5'>{cores_str}</span>")
        else:
            self.lbl_cpu_cores.set_markup("")

        gpu = self.get_nvidia_data()
        gt_col = self.temp_color(gpu['temp'])
        self.lbl_gpu_main.set_markup(
            f"<span font='JetBrains Mono 8.5'><b>Uso:</b> {gpu['gpu_util']:.0f}%  |  <b>Temp:</b> <span foreground='{gt_col}'>{gpu['temp']:.0f}°C</span>  |  {gpu['power']:.1f}W</span>"
        )
        self.bar_gpu.set_fraction(gpu['gpu_util'] / 100.0)
        
        vram_pct = (gpu['vram_used'] / gpu['vram_total']) * 100.0 if gpu['vram_total'] > 0 else 0
        self.lbl_gpu_vram.set_markup(
            f"<span font='JetBrains Mono 8'><b>VRAM:</b> {int(gpu['vram_used'])} / {int(gpu['vram_total'])} MiB ({vram_pct:.0f}%)</span>"
        )
        self.bar_vram.set_fraction(vram_pct / 100.0)

        used_ram, tot_ram, avail_ram, ram_pct, swap_pct = self.get_ram_data()
        self.lbl_ram_main.set_markup(
            f"<span font='JetBrains Mono 8.5'><b>RAM:</b> {used_ram:.1f} / {tot_ram:.1f} GiB ({ram_pct:.1f}%)</span>"
        )
        self.bar_ram.set_fraction(ram_pct / 100.0)
        self.lbl_swap.set_markup(
            f"<span font='JetBrains Mono 8'><b>Disp:</b> {avail_ram:.1f} GiB  |  <b>Swap:</b> {swap_pct:.0f}%</span>"
        )

        (r_used, r_tot, r_pct), (h_used, h_tot, h_pct) = self.get_disk_data()
        self.lbl_disk_root.set_markup(
            f"<span font='JetBrains Mono 8'><b>Raiz (/):</b> {r_used}/{r_tot} ({r_pct:.0f}%) [SSD 1TB]</span>"
        )
        self.bar_disk_root.set_fraction(r_pct / 100.0)
        
        self.lbl_disk_home.set_markup(
            f"<span font='JetBrains Mono 8'><b>Home (/home):</b> {h_used}/{h_tot} ({h_pct:.0f}%) [SSD 1TB]</span>"
        )
        self.bar_disk_home.set_fraction(h_pct / 100.0)
        self.lbl_disk_win.set_markup(
            "<span font='JetBrains Mono 8'><b>Windows SSD:</b> 222.6 GiB (NTFS / sdb)</span>"
        )

        mobo_str = f"{int(mobo_temps[0])}°C - {int(mobo_temps[-1])}°C" if mobo_temps else "38°C"
        self.lbl_mobo.set_markup(
            f"<span font='JetBrains Mono 8'><b>Placa-Mãe (H310M):</b> {mobo_str}</span>"
        )
        lan, tail = self.get_net_ip()
        tail_str = f" | <b>TS:</b> {tail}" if tail else ""
        self.lbl_net.set_markup(
            f"<span font='JetBrains Mono 7.5'><b>IP:</b> {lan}{tail_str}</span>"
        )
        
        return True

if __name__ == '__main__':
    win = HardwareHUD()
    win.connect("destroy", Gtk.main_quit)
    win.show_all()
    Gtk.main()
