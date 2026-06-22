#!/bin/bash
# ==============================================
# rsync Local Backup Script
# Destination: 5TB External HDD at /mnt/backup
# ==============================================
# Place this file at: /home/[your-username]/backup_rsync.sh
# Make executable with: chmod +x backup_rsync.sh
# Schedule via cron (see docs/PHASE2-rsync-cron.md for the exact line)

TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
LOG_FILE=/mnt/backup/logs/rsync_$TIMESTAMP.log
SOURCE=$HOME/
DEST=/mnt/backup/rsync/home/

# Check if backup drive is mounted before doing anything
if ! mountpoint -q /mnt/backup; then
  echo "ERROR: /mnt/backup is not mounted. Aborting." | tee -a $LOG_FILE
  exit 1
fi

echo "[$TIMESTAMP] Starting rsync backup..." | tee -a $LOG_FILE

rsync \
  -avh \
  --delete \
  --exclude='.cache' \
  --exclude='.local/share/Trash' \
  --log-file=$LOG_FILE \
  $SOURCE \
  $DEST

EXIT_CODE=$?

if [ $EXIT_CODE -eq 0 ]; then
  echo "[SUCCESS] Backup completed at $(date)" | tee -a $LOG_FILE
else
  echo "[FAILURE] rsync exited with code $EXIT_CODE" | tee -a $LOG_FILE
fi

# Note: rsync exit code 23 ("some files/attrs were not transferred") usually
# means it hit files it doesn't have permission to read -- commonly root-owned
# files inside Docker volumes. This is an accepted limitation documented in
# docs/INCIDENT-REPORT.md, not a bug to chase down line by line.
