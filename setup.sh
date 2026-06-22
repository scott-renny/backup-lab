#!/bin/bash
# ==============================================================================
# 3-2-1 Backup Lab — Setup Script
# ==============================================================================
# This script automates the server-side setup from docs/PHASE1 through PHASE4.
# It assumes you've already physically connected the external HDD and identified
# its device name (e.g. /dev/sdb) via `lsblk`.
#
# This script bakes in fixes for issues hit during the original build:
#   - Restic password file is created with correct ownership/permissions up front
#     (the original build hit "permission denied" because /etc/restic-password
#      was root-owned, which silently breaks cron jobs that run as a normal user)
#   - Backup directory ownership is set explicitly to avoid root-owned subfolders
#     appearing from earlier mount/snap activity (see docs/INCIDENT-REPORT.md)
#
# Run with: sudo bash setup.sh
# ==============================================================================

set -e  # exit on first error

# ---- Load configuration ----
if [ -f .env ]; then
    source .env
else
    echo "No .env file found. Copy .env.example to .env and fill in your values first."
    exit 1
fi

echo "=== 3-2-1 Backup Lab Setup ==="
echo "Backup user: $BACKUP_USER"
echo "Mount point: $BACKUP_MOUNT"
echo ""

# ---- Step 1: Create mount point and backup directory structure ----
echo "[1/6] Creating directory structure..."
mkdir -p "$BACKUP_MOUNT"
mkdir -p "$BACKUP_MOUNT/rsync"
mkdir -p "$BACKUP_MOUNT/restic"
mkdir -p "$BACKUP_MOUNT/network"
mkdir -p "$BACKUP_MOUNT/logs"

# Fix: explicitly set ownership to avoid root-owned subdirectories blocking
# later rsync/restic runs (this bit us during the original build -- a snap-related
# mount had created a root:root directory inside /mnt/backup)
chown -R "$BACKUP_USER":"$BACKUP_USER" "$BACKUP_MOUNT"
chmod -R 770 "$BACKUP_MOUNT"
echo "    Done."

# ---- Step 2: Install required packages ----
echo "[2/6] Installing rsync, samba, restic..."
apt update -qq
apt install -y rsync samba restic
echo "    Done."

# ---- Step 3: Create the Samba backup user (least privilege) ----
echo "[3/6] Creating dedicated Samba user '$SAMBA_BACKUP_USER'..."
if ! id "$SAMBA_BACKUP_USER" &>/dev/null; then
    useradd -M -s /usr/sbin/nologin "$SAMBA_BACKUP_USER"
    echo "    User created. You will be prompted to set a Samba password next."
    smbpasswd -a "$SAMBA_BACKUP_USER"
    smbpasswd -e "$SAMBA_BACKUP_USER"
else
    echo "    User already exists, skipping creation."
fi

mkdir -p "$BACKUP_MOUNT/network/windows-pc"
mkdir -p "$BACKUP_MOUNT/network/logs"
chown -R "$SAMBA_BACKUP_USER":"$SAMBA_BACKUP_USER" "$BACKUP_MOUNT/network"
chmod 770 "$BACKUP_MOUNT/network"
echo "    Done."

# ---- Step 4: Create the Restic password file with CORRECT permissions ----
echo "[4/6] Setting up Restic password file..."
if [ ! -f "$RESTIC_PASSWORD_FILE" ]; then
    echo "Enter a strong password for the Restic repository (write this down somewhere safe):"
    read -s RESTIC_PW
    echo "$RESTIC_PW" > "$RESTIC_PASSWORD_FILE"

    # Fix: chown to the backup user (NOT root) so that cron jobs running as
    # that user can read the file without sudo. This was the root cause of
    # three separate "Resolving password failed" errors during the original
    # build -- see docs/INCIDENT-REPORT.md for the full story.
    chown "$BACKUP_USER":"$BACKUP_USER" "$RESTIC_PASSWORD_FILE"
    chmod 600 "$RESTIC_PASSWORD_FILE"
    echo "    Password file created at $RESTIC_PASSWORD_FILE (permissions: 600, owner: $BACKUP_USER)"
else
    echo "    Password file already exists at $RESTIC_PASSWORD_FILE, skipping."
fi

# ---- Step 5: Initialize the Restic repository ----
echo "[5/6] Initializing Restic repository..."
if [ ! -d "$RESTIC_REPO" ]; then
    sudo -u "$BACKUP_USER" restic init --repo "$RESTIC_REPO" --password-file "$RESTIC_PASSWORD_FILE"
    echo "    Repository initialized at $RESTIC_REPO"
else
    echo "    Repository already exists at $RESTIC_REPO, skipping."
fi

# ---- Step 6: Verify the normal user (not root) can read everything ----
echo "[6/6] Verifying permissions as $BACKUP_USER (not root)..."
sudo -u "$BACKUP_USER" restic snapshots --repo "$RESTIC_REPO" --password-file "$RESTIC_PASSWORD_FILE" || {
    echo "    WARNING: $BACKUP_USER could not read the Restic repo. Check permissions on $RESTIC_PASSWORD_FILE."
    exit 1
}
echo "    Verified -- cron jobs running as $BACKUP_USER will work correctly."

echo ""
echo "=== Setup complete ==="
echo "Next steps:"
echo "  1. Run the rsync backup script manually once to test (see docs/PHASE2)"
echo "  2. Add cron entries (see docs/PHASE2 and docs/PHASE4 for the exact lines)"
echo "  3. Configure Samba shares (see docs/PHASE3)"
echo "  4. Set up Wazuh log monitoring (see docs/PHASE6)"
