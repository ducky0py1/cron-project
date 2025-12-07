# Automated Cron Task Suite

A small, well-organized example project showing how to automate repeatable tasks on Ubuntu/Linux using cron and Bash scripts. Each script follows the single-responsibility principle (logging, backing up, reporting) and is designed to be easy to read, test, and maintain.

---

## Table of contents

- [Summary](#summary)
- [How it works](#how-it-works)
- [Project layout](#project-layout)
- [Example: hello.sh](#example-hellosh)
- [Installation](#installation)
- [Scheduling examples](#scheduling-examples)
- [Best practices](#best-practices)
- [Requirements & checks](#requirements--checks)
- [.gitignore recommendations](#gitignore-recommendations)

---

## Summary

This repo is a minimal, opinionated pattern for running scheduled tasks with cron:

- Keep executable scripts in `scripts/`.
- Write outputs to structured directories (`logs/`, `backups/`, `reports/`).
- Avoid committing generated artifacts to Git.
- Use absolute paths and fail-fast script settings so jobs run reliably under cron's limited environment.

---

## How it works

1. Place executable Bash scripts in `scripts/`.
2. Add entries to your user crontab (`crontab -e`) that point to the scripts using absolute paths.
3. Cron executes scripts on schedule; each script writes to `logs/`, `backups/`, or `reports/`.
4. Keep scripts idempotent and single-purpose — safe to run repeatedly.

---

## Project layout

cron-project/
├── scripts/        # Executable Bash scripts for cron jobs  
├── logs/           # Runtime logs (ignored in git)  
├── backups/        # Backup archives (ignored in git)  
├── reports/        # Generated reports (ignored in git)  
├── .gitignore  
└── README.md

---

## Example: hello.sh

This is a minimal script that appends a timestamped message to a log.

Cron entry (runs every minute):

```
* * * * * /home/$USER/cron-project/scripts/hello.sh
```

Script (scripts/hello.sh):

```bash
#!/bin/bash
set -euo pipefail

LOG_DIR="$HOME/cron-project/logs"
mkdir -p "$LOG_DIR"

echo "Hello from CRON! Time: $(date -u '+%Y-%m-%dT%H:%M:%SZ')" >> "$LOG_DIR/hello.log"
```

Notes:
- Cron runs with a very small environment; use absolute paths and set required env vars in the script or crontab.
- Use `set -euo pipefail` to catch errors and avoid silent failures.

---

## Installation

1. Clone the repository:

```bash
git clone https://github.com/ducky0py1/cron-project.git
cd cron-project
```

2. Make scripts executable:

```bash
chmod +x scripts/*.sh
```

3. Edit your crontab:

```bash
crontab -e
```

4. Add cron entries that reference the scripts (use absolute paths). For example:

```
# Every minute
* * * * * /home/$USER/cron-project/scripts/hello.sh >> /home/$USER/cron-project/logs/cron.log 2>&1
```

---

## Scheduling examples

- Every minute:
  ```
  * * * * * /home/$USER/cron-project/scripts/hello.sh
  ```

- Daily at 02:30 AM:
  ```
  30 2 * * * /home/$USER/cron-project/scripts/daily-backup.sh
  ```

- Every Monday at 03:00 AM:
  ```
  0 3 * * 1 /home/$USER/cron-project/scripts/weekly-report.sh
  ```

Tip: Redirect stderr to a logfile (or mail) to capture errors:
```
/path/to/script.sh >> /path/to/log 2>&1
```

---

## Best practices

- Use absolute paths everywhere (cron's PATH is minimal).
- Export any required env vars at the top of your crontab or inside scripts.
- Make scripts idempotent — safe to re-run.
- Create and cleanup temporary files in `$TMPDIR` or `/tmp`.
- Use log rotation for logs (logrotate) or implement size/date-based rotation in scripts.
- Test scripts manually before scheduling with cron:
  ```bash
  ./scripts/your-script.sh
  ```

---

## Requirements & checks

- A Linux distribution (Ubuntu or similar)
- cron installed and enabled
- bash
- git (to clone the repo)

Check cron status on systemd-based systems:

```bash
systemctl status cron
```

If `systemctl` is not available, use your distro's init tool, e.g., `service cron status`.

---

## .gitignore recommendations

Avoid committing generated data:

```
logs/
backups/
reports/
*.log
*.tar.gz
```

