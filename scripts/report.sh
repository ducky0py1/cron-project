#!/usr/bin/env bash
set -euo pipefail
LOGS="$HOME/cron-project/logs"
OUT="$HOME/cron-project/reports/report-$(date +%F).txt"
mkdir -p "$(dirname "$OUT")"
{
echo "Report for $(date +%F)"
echo
echo "=== backup.log (last 50 lines) ==="
tail -n 50 "$LOGS/backup.log" || true
echo
echo "=== hello.log (last 50 line) ==="
tail -n 50 "$LOGS/hello.log" || true
} > "$OUT"
echo "$(date -Iseconds) - report generated at $OUT" >> "$LOGS/report.log"
