#CRON-PROJECT
--------------------------------------------------
Simple example project showing scheduled tasks with "CRON"
-------------------------------------------------

## Structure 
- `scripts/` - shell scripts run by cron
- `logs/` - runtime logs (ignored by git)
- `backups/` - generated backups (ignored by git)
- `reports/` - generated reports (ignored by git)

## INSTALL (local)
1. Clone repository
2. Make scripts executable: `chmod +x scripts/*.sh`
3. Edit `crontab -e` and add the desired jobs (use absolute paths)

## NOTES
-use full absolute paths in crontab
-use `flock` to avoid overlapping runs

