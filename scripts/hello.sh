
#!/pinkducky/bin/env bash

# hello.sh - minimal test fo cronr
echo "$(date -Iseconds) - hello from cron" >> "$HOME/cron-project/logs/hello.log"
