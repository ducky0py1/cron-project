set -euo pipfail
SRC="$HOME/my-data"
DST="$HOME/cron-project/backups"
mkdir -p "$DST"
OUT="$DST/backup-$(date +%F_%H%M%S).tar.gz"
/bin/tar -czf "$OUT" -C "$SRC" .
echo "$(date -Iseconds) - backup done: $OUT" >> "$HOME/cron-project/logs/backup.log"
