#!/usr/bin/env bash
# Claude Code custom status line — pale-blue theme
# 4 lines: (1) project_dir + git branch + diff  (2) context bar + model
#          (3) 5h rate limit + reset  (4) 7d rate limit + reset
# Reads session JSON on stdin. Parses with python3 (jq-free).

input=$(cat)

# --- parse JSON via python3, emit shell-quoted KEY=value lines ---------------
eval "$(printf '%s' "$input" | python3 -c '
import json, sys, os, shlex
try:
    d = json.load(sys.stdin)
except Exception:
    d = {}

def get(path, default=""):
    x = d
    for k in path.split("."):
        if isinstance(x, dict) and x.get(k) is not None:
            x = x[k]
        else:
            return default
    return x

cur = get("workspace.project_dir") or get("workspace.current_dir") or get("cwd") or ""

def rint(v):
    try:
        return str(int(round(float(v))))
    except Exception:
        return "0"

vals = {
    "CUR":       cur,
    "MODEL":     get("model.display_name") or "",
    "EFFORT":    get("effort.level") or "",
    "CTX":       rint(get("context_window.used_percentage", 0)),
    "RL5":       rint(get("rate_limits.five_hour.used_percentage", 0)),
    "RL7":       rint(get("rate_limits.seven_day.used_percentage", 0)),
    "RL5_RESET": rint(get("rate_limits.five_hour.resets_at", 0)),
    "RL7_RESET": rint(get("rate_limits.seven_day.resets_at", 0)),
}
for k, v in vals.items():
    print(f"{k}={shlex.quote(str(v))}")
')"

# --- palette (24-bit truecolor, pale-blue family) ----------------------------
E=$'\033'
R="${E}[0m"
fg(){ printf '%s[38;2;%s;%s;%sm' "$E" "$1" "$2" "$3"; }
ICON=$(fg 143 152 255)   # #8f98ff — icons/accents
PATHC=$(fg 217 220 255)  # #d9dcff — directory
BRANCH=$(fg 143 152 255) # #8f98ff — git branch (matches bar fill)
ADD=$(fg 217 220 255)    # #d9dcff — additions
DEL=$(fg 150 154 205)    # dim lavender — deletions
LABEL=$(fg 217 220 255)  # #d9dcff — small labels
PCT=$(fg 217 220 255)    # #d9dcff — percentages
MODELC=$(fg 217 220 255) # #d9dcff — model
FILL=$(fg 143 152 255)   # #8f98ff — bar filled
EMPTY=$(fg 108 114 168)  # periwinkle (dimmed) — bar empty
DIM=$(fg 110 115 165)    # muted — separators

# --- progress bar: $1 percent, $2 width(default 15) --------------------------
bar(){
  local pct=$1 width=${2:-15} filled i out=""
  [ -z "$pct" ] && pct=0
  filled=$(( (pct * width + 50) / 100 ))
  (( filled < 0 )) && filled=0
  (( filled > width )) && filled=width
  out="${DIM}[${FILL}"
  for ((i=0; i<filled; i++)); do out+="="; done
  out+="${EMPTY}"
  for ((i=filled; i<width; i++)); do out+=" "; done
  out+="${DIM}]"
  printf '%s%s' "$out" "$R"
}

# --- format "reset in" from a unix timestamp -> compact string ---------------
fmt_reset(){
  local ts=$1 now diff d h m
  [ -z "$ts" ] || [ "$ts" = "0" ] && { printf '%s' "--"; return; }
  now=$(date +%s)
  diff=$(( ts - now ))
  (( diff < 0 )) && diff=0
  d=$(( diff / 86400 )); h=$(( (diff % 86400) / 3600 )); m=$(( (diff % 3600) / 60 ))
  if   (( d > 0 )); then printf '%dd%dh' "$d" "$h"
  elif (( h > 0 )); then printf '%dh%02dm' "$h" "$m"
  else                   printf '%dm' "$m"
  fi
}

SEP="  ${DIM}|${R}  "

# --- line 1: git branch + diff -----------------------------------------------
line1=""
if [ -n "$CUR" ] && [ -d "$CUR" ]; then
  branch=$(GIT_OPTIONAL_LOCKS=0 git -C "$CUR" --no-optional-locks branch --show-current 2>/dev/null)
  if [ -n "$branch" ]; then
    line1="${ICON}⎇  ${BRANCH}${branch}${R}"
    stat=$(GIT_OPTIONAL_LOCKS=0 git -C "$CUR" --no-optional-locks diff --shortstat 2>/dev/null)
    add=$(printf '%s' "$stat" | grep -oE '[0-9]+ insertion' | grep -oE '[0-9]+')
    del=$(printf '%s' "$stat" | grep -oE '[0-9]+ deletion'  | grep -oE '[0-9]+')
    if [ -n "$add" ] || [ -n "$del" ]; then
      line1+="  ${ADD}+${add:-0}${R} ${DEL}-${del:-0}${R}"
    fi
  fi
fi

# --- line 2: context usage bar + model ---------------------------------------
line2="${LABEL}ctx${R}${PCT}$(printf '%3s' "$CTX")%${R} $(bar "$CTX" 14)"
model_seg="${MODELC}${MODEL}${R}"
[ -n "$EFFORT" ] && model_seg+="${DIM}·${R}${LABEL}${EFFORT}${R}"
line2+=" ${model_seg}"

# --- lines 3 & 4: rate limits with reset countdown (5h / 7d) -----------------
r5=$(printf '%-5s' "$(fmt_reset "$RL5_RESET")")
r7=$(printf '%-5s' "$(fmt_reset "$RL7_RESET")")
line3="${LABEL}5h${R} ${PCT}$(printf '%3s' "$RL5")%${R} $(bar "$RL5" 14) ${ICON}↻${R} ${LABEL}${r5}${R}"
line4="${LABEL}7d${R} ${PCT}$(printf '%3s' "$RL7")%${R} $(bar "$RL7" 14) ${ICON}↻${R} ${LABEL}${r7}${R}"

if [ -n "$line1" ]; then
  printf '%b\n%b\n%b\n%b' "$line1" "$line2" "$line3" "$line4"
else
  printf '%b\n%b\n%b' "$line2" "$line3" "$line4"
fi
