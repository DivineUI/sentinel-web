#!/usr/bin/env bash

LOG_FILE="/var/log/sentinel/dashboard.txt"

while true; do
    tmp_file="$(mktemp "${LOG_FILE}.XXXXXX")"
    {
        echo "=== $(date '+%Y-%m-%d %H:%M:%S %Z') ==="
        echo "Hostname: $(hostname)"
        echo "Uptime: $(uptime -p 2>/dev/null || uptime)"
        echo "Load average: $(awk '{print $1, $2, $3}' /proc/loadavg)"
        echo "Memory (free -h):"
        free -h
        echo "Disk (/):"
        df -h /
        echo "Top 5 processes by memory:"
        ps -e -o pid,ppid,stat,%mem,%cpu,comm --sort=-%mem | head -n 6 | tail -n 5 | sed 's/^ *//'
        echo ""
    } > "${tmp_file}"
    chmod 644 "${tmp_file}"
    mv "${tmp_file}" "${LOG_FILE}"
    sleep 5
done
