#!/usr/bin/env bash
export LC_ALL=C
/usr/bin/python3 -c '
import sys, os, json, time, datetime, subprocess

try:
    raw_input = sys.stdin.read()
    input_data = json.loads(raw_input) if raw_input.strip() else {}
except Exception:
    input_data = {}

DS_ROXO = "\033[38;2;211;132;211m"
DS_CIANO = "\033[38;2;117;200;211m"
DS_AZUL = "\033[38;2;132;186;233m"
DS_VERDE = "\033[38;2;158;215;136m"
DS_AMARELO = "\033[38;2;253;187;104m"
DS_VERMELHO = "\033[38;2;236;110;159m"
DS_LILAS = "\033[38;2;189;114;193m"
DS_CINZA = "\033[38;2;148;163;184m"
DS_RESET = "\033[0m"
DS_DIM = "\033[2m"
DS_BOLD = "\033[1m"

model_obj = input_data.get("model", {})
if isinstance(model_obj, dict):
    model_name = model_obj.get("display_name") or model_obj.get("id") or "Gemini 3.7 Flash"
elif isinstance(model_obj, str):
    model_name = model_obj
else:
    model_name = "Gemini 3.7 Flash"

workspace = input_data.get("workspace", {})
cwd = workspace.get("current_dir") or input_data.get("cwd") or os.getcwd()
dir_label = os.path.basename(cwd) or "/"
dir_url = f"file://{cwd.replace(" ", "%20")}"
dir_link = f"\033]8;;{dir_url}\033\\{dir_label}\033]8;;\033\\"

branch_str = ""
try:
    git_check = subprocess.run(["git", "-C", cwd, "rev-parse", "--is-inside-work-tree"], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
    if git_check.returncode == 0:
        b_res = subprocess.run(["git", "-C", cwd, "branch", "--show-current"], capture_output=True, text=True)
        b_name = b_res.stdout.strip()
        if not b_name:
            b_res = subprocess.run(["git", "-C", cwd, "rev-parse", "--short", "HEAD"], capture_output=True, text=True)
            b_name = b_res.stdout.strip()
        if b_name:
            diff_res = subprocess.run(["git", "-C", cwd, "diff", "--quiet", "HEAD"], stderr=subprocess.DEVNULL)
            sujo = "✚" if diff_res.returncode != 0 else ""
            branch_str = f" {DS_DIM}|{DS_RESET} {DS_VERDE}🌿 {b_name}{sujo}{DS_RESET}"
except Exception:
    pass

cw = input_data.get("context_window", {})
total_in = int(cw.get("total_input_tokens", 0) or 0)
total_out = int(cw.get("total_output_tokens", 0) or 0)
cur_usage = cw.get("current_usage", 0)

if isinstance(cur_usage, dict):
    tokens_used = (
        int(cur_usage.get("input_tokens", 0) or 0) +
        int(cur_usage.get("output_tokens", 0) or 0) +
        int(cur_usage.get("cache_read_input_tokens", 0) or 0)
    )
elif isinstance(cur_usage, (int, float)) and cur_usage > 0:
    tokens_used = int(cur_usage)
else:
    tokens_used = total_in + total_out

ctx_size = int(cw.get("context_window_size", 1048576) or 1048576)
if ctx_size <= 0:
    ctx_size = 1048576

raw_pct = cw.get("used_percentage")
if raw_pct is not None:
    try:
        pct = float(raw_pct)
        if 0 < pct <= 1.0:
            pct *= 100.0
    except Exception:
        pct = 0.0
else:
    pct = (tokens_used / ctx_size) * 100.0 if ctx_size > 0 else 0.0

pct_int = max(0, min(100, int(pct + 0.5)))

if pct_int >= 90:
    bar_color = DS_VERMELHO
elif pct_int >= 70:
    bar_color = DS_AMARELO
else:
    bar_color = DS_VERDE

filled = pct_int // 10
bar = "█" * filled + "░" * (10 - filled)

def format_tokens(n):
    if n >= 1000000:
        return f"{n/1000000:.1f}M"
    elif n >= 1000:
        return f"{n/1000:.0f}k"
    return str(n)

tokens_disp = f"{format_tokens(tokens_used)}/{format_tokens(ctx_size)}"

def gauge_icon(pct):
    icons = ["◐", "◑", "◒", "◓", "◕", "◔", "◖", "●"]
    idx = int(pct / 12.5)
    return icons[min(len(icons) - 1, max(0, idx))]

def format_countdown(seconds):
    if seconds is None:
        return ""
    if seconds <= 0:
        return "agora"
    d = seconds // 86400
    h = (seconds % 86400) // 3600
    m = (seconds % 3600) // 60
    if d > 0:
        return f"{d}d{h}h"
    elif h > 0:
        return f"{h}h{m}m"
    else:
        return f"{m}m"

def parse_reset_seconds(quota_item):
    if not quota_item:
        return None
    sec = quota_item.get("reset_in_seconds")
    if sec is not None:
        return int(sec)
    rt = quota_item.get("reset_time") or quota_item.get("resets_at") or quota_item.get("resetsAt")
    if rt:
        try:
            if isinstance(rt, (int, float)):
                epoch = int(rt / 1000) if rt > 1000000000000 else int(rt)
                return max(0, epoch - int(time.time()))
            dt = datetime.datetime.fromisoformat(str(rt).replace("Z", "+00:00"))
            return max(0, int(dt.timestamp() - time.time()))
        except Exception:
            pass
    return None

def extract_quota_pct(quota_item):
    if not quota_item:
        return None
    rem = quota_item.get("remaining_fraction")
    if rem is not None:
        try:
            return max(0, min(100, int((1.0 - float(rem)) * 100 + 0.5)))
        except Exception:
            pass
    for k in ["used_percentage", "percent", "utilization", "used_pct"]:
        v = quota_item.get(k)
        if v is not None:
            try:
                val = float(v)
                if 0 < val <= 1.0 and "." in str(v):
                    val *= 100.0
                return max(0, min(100, int(val + 0.5)))
            except Exception:
                pass
    return None

quota = input_data.get("quota", {})
rate_limits = input_data.get("rate_limits", {}) or input_data.get("rate_limit", {})

is_3p = any(x in model_name.lower() for x in ["claude", "sonnet", "opus", "gpt"])

q5 = None
if is_3p:
    q5 = quota.get("3p-5h") or quota.get("five_hour") or rate_limits.get("five_hour")
if not q5:
    q5 = quota.get("gemini-5h") or quota.get("five_hour") or quota.get("3p-5h") or rate_limits.get("five_hour")

qw = None
if is_3p:
    qw = quota.get("3p-weekly") or quota.get("seven_day") or quota.get("weekly") or rate_limits.get("seven_day")
if not qw:
    qw = quota.get("gemini-weekly") or quota.get("seven_day") or quota.get("weekly") or quota.get("3p-weekly") or rate_limits.get("seven_day")

p5 = extract_quota_pct(q5)
sec5 = parse_reset_seconds(q5)

pw = extract_quota_pct(qw)
secw = parse_reset_seconds(qw)

rate_display = ""
if p5 is not None:
    g5 = gauge_icon(p5)
    cd5 = format_countdown(sec5)
    cd5_txt = f" (⏳{cd5})" if cd5 else ""
    c5 = DS_VERMELHO if p5 >= 90 else (DS_AMARELO if p5 >= 75 else DS_LILAS)
    rate_display += f" {c5}{g5}{DS_RESET} 5h:{p5}%{cd5_txt}"

if pw is not None:
    gw = gauge_icon(pw)
    cdw = format_countdown(secw)
    cdw_txt = f" (⏳{cdw})" if cdw else ""
    cw_col = DS_VERMELHO if pw >= 90 else (DS_AMARELO if pw >= 75 else DS_LILAS)
    rate_display += f"  {cw_col}{gw}{DS_RESET} 7d:{pw}%{cdw_txt}"

def format_duration(sec):
    if sec is None or sec < 0:
        return "0s"
    h = int(sec // 3600)
    m = int((sec % 3600) // 60)
    s = int(sec % 60)
    if h > 0:
        return f"{h}h {m}m"
    elif m > 0:
        return f"{m}m {s}s"
    else:
        if sec < 10 and isinstance(sec, float):
            return f"{sec:.1f}s"
        return f"{s}s"

session_id = input_data.get("session_id") or input_data.get("conversation_id")
agent_state = input_data.get("agent_state", "idle")

tp = input_data.get("transcript_path")
if not tp or not os.path.exists(tp):
    home = os.path.expanduser("~")
    candidates = []
    if session_id:
        candidates.append(f"{home}/.gemini/antigravity-cli/brain/{session_id}/.system_generated/logs/transcript.jsonl")
    if tp:
        candidates.append(tp.replace("/antigravity/", "/antigravity-cli/"))
    for c in candidates:
        if os.path.exists(c):
            tp = c
            break

session_sec = 0
working_sec = 0
now = time.time()

if tp and os.path.exists(tp):
    first_ts = None
    user_input_timestamps = []
    last_step_ts = None
    try:
        with open(tp, "r", encoding="utf-8", errors="ignore") as tf:
            for line in tf:
                if not first_ts and "created_at" in line:
                    try:
                        obj = json.loads(line)
                        ca = obj.get("created_at")
                        if ca:
                            first_ts = datetime.datetime.fromisoformat(ca.replace("Z", "+00:00")).timestamp()
                    except Exception:
                        pass
                if "USER_INPUT" in line:
                    try:
                        obj = json.loads(line)
                        if obj.get("type") == "USER_INPUT":
                            ca = obj.get("created_at")
                            if ca:
                                user_input_timestamps.append(datetime.datetime.fromisoformat(ca.replace("Z", "+00:00")).timestamp())
                    except Exception:
                        pass
                if "created_at" in line:
                    try:
                        obj = json.loads(line)
                        ca = obj.get("created_at")
                        if ca:
                            last_step_ts = datetime.datetime.fromisoformat(ca.replace("Z", "+00:00")).timestamp()
                    except Exception:
                        pass
        if first_ts:
            session_sec = max(0, now - first_ts)
        if user_input_timestamps:
            last_ui_ts = user_input_timestamps[-1]
            if agent_state == "working":
                working_sec = max(0, now - last_ui_ts)
            elif last_step_ts and last_step_ts >= last_ui_ts:
                working_sec = max(0, last_step_ts - last_ui_ts)
    except Exception:
        pass

session_fmt = format_duration(session_sec)
working_fmt = format_duration(working_sec)
time_info = f"⏱ Sessão: {session_fmt} • ⚡ Working: {working_fmt}"

if rate_display:
    line1 = f"{DS_ROXO}[Antigravity | {model_name}]{DS_RESET} 📁 {dir_link}{branch_str} {DS_DIM}|{DS_RESET}{rate_display}"
else:
    line1 = f"{DS_ROXO}[Antigravity | {model_name}]{DS_RESET} 📁 {dir_link}{branch_str}"

line2 = f"{bar_color}{bar}{DS_RESET} {pct_int}% • {tokens_disp} • {DS_AMARELO}{time_info}{DS_RESET}"

print(line1)
print(line2)
' "$@"
