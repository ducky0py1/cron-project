cat > ~/cron-project/scripts/cleanup.sh <<'BASH'
#!/usr/bin/env bash
set -euo pipefail
DIR="$HOME/cron-project/backups"
mkdir -p "$DIR"
find "$DIR" -type f -mtime +30 -print -delete >> "$HOME/cron-project/logs/cleanup.log" 2>&1 || true
echo "$(date -Iseconds) - cleanup done" >> "$HOME/cron-project/logs/cleanup.log"
