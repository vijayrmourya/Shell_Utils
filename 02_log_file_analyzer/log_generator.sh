#!/usr/bin/env bash
#
# generate_log.sh — generate a synthetic complex log file for testing
#
# Usage: ./generate_log.sh [NUM_LINES] [OUTPUT_FILE]
#   NUM_LINES    Number of log lines to generate (default: 1000)
#   OUTPUT_FILE  File to write logs into (default: random.log)

# --- Configuration ----------------------------------------------------------

NUM_LINES=${1:-1000}
OUTFILE=${2:-random.log}

# Sample data for log generation
METHODS=(GET POST PUT DELETE PATCH)
URLS=(/ /index.html /login /logout /api/data /api/user /images/logo.png /css/style.css /js/app.js)
PROTOS=(HTTP/1.0 HTTP/1.1)
STATUS_CODES=(200 201 301 302 400 401 403 404 500 502 503)
REFERRERS=(- "https://example.com" "https://google.com" "https://bing.com/search?q=test")
USER_AGENTS=(
  "Mozilla/5.0 (Windows NT 10.0; Win64; x64)"
  "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7)"
  "curl/7.68.0"
  "Wget/1.20.3 (linux-gnu)"
  "PostmanRuntime/7.28.4"
)
LOG_LEVELS=(INFO WARNING ERROR DEBUG)
MODULES=(auth db api worker scheduler)
ERROR_MESSAGES=(
  "User login failed"
  "Database connection timeout"
  "NullPointerException at line 42"
  "Unauthorized access attempt"
  "File not found: /etc/config.yaml"
  "Payment processing error"
)

# Helper: random element from array
rand_elem() {
  local arr=("${!1}") 
  echo "${arr[RANDOM % ${#arr[@]}]}"
}

# Helper: random IP
rand_ip() {
  printf "%d.%d.%d.%d" $((RANDOM%223+1)) $((RANDOM%254)) $((RANDOM%254)) $((RANDOM%254))
}

# Helper: random timestamp in Apache log format, within last 30 days
rand_apache_time() {
  local days=$((RANDOM % 30))
  local secs=$((RANDOM % 86400))
  date -d "-${days} days -${secs} seconds" '+%d/%b/%Y:%H:%M:%S %z'
}

# Helper: random timestamp for application logs
rand_app_time() {
  local days=$((RANDOM % 30))
  local secs=$((RANDOM % 86400))
  date -d "-${days} days -${secs} seconds" '+%Y-%m-%d %H:%M:%S'
}

# --- Generation -------------------------------------------------------------

> "$OUTFILE"
for ((i=1; i<=NUM_LINES; i++)); do
  if (( RANDOM % 10 < 8 )); then
    # 80% chance: Apache‐style access log
    ip=$(rand_ip)
    user=$([[ $((RANDOM%5)) -eq 0 ]] && echo "-" || echo "user$((RANDOM%100))")
    time="[ $(rand_apache_time) ]"
    method=$(rand_elem METHODS[@])
    url=$(rand_elem URLS[@])
    proto=$(rand_elem PROTOS[@])
    status=$(rand_elem STATUS_CODES[@])
    size=$(( RANDOM % 5000 + 200 ))
    ref=$(rand_elem REFERRERS[@])
    ua=$(rand_elem USER_AGENTS[@])
    printf '%s - %s [%s] "%s %s %s" %s %s "%s" "%s"\n' \
      "$ip" "$user" "${time//[[:space:]]/}" "$method" "$url" "$proto" \
      "$status" "$size" "$ref" "$ua" \
      >> "$OUTFILE"
  else
    # 20% chance: application‐style log
    ts=$(rand_app_time)
    lvl=$(rand_elem LOG_LEVELS[@])
    mod=$(rand_elem MODULES[@])
    msg=$(rand_elem ERROR_MESSAGES[@])
    printf '%s [%s] (%s): %s\n' "$ts" "$lvl" "$mod" "$msg" >> "$OUTFILE"
  fi
done

echo "Generated $NUM_LINES lines of mixed log data in '$OUTFILE'."
