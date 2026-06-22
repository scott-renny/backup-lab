# Phase 3: Samba Network Share

## Goal

Turn the Ubuntu Server into a basic network-attached storage (NAS) target so other devices on the LAN can write backups to the same 5TB HDD over SMB/CIFS — this is the "network" copy in the 3-2-1 strategy.

## Why a dedicated Samba user

Rather than exposing the server's normal login account over the network, this lab creates a separate `backupuser` account scoped only to the backup share. It has no shell (`/usr/sbin/nologin`) and cannot SSH in — it exists purely as a Samba identity with access to one directory.

```bash
sudo useradd -M -s /usr/sbin/nologin backupuser
sudo smbpasswd -a backupuser
sudo smbpasswd -e backupuser
```

## Directory setup

```bash
sudo mkdir -p /mnt/backup/network/windows-pc
sudo chown -R backupuser:backupuser /mnt/backup/network
sudo chmod 770 /mnt/backup/network
```

## Samba configuration

See [`smb.conf.snippet`](smb.conf.snippet) for the exact share definition to add to `/etc/samba/smb.conf`. After editing:

```bash
testparm                          # validates syntax
sudo systemctl restart smbd
sudo ufw allow 'Samba'            # open the firewall for SMB
```

> **Security note:** see the bottom of [`smb.conf.snippet`](smb.conf.snippet) for a documented design decision around the server's global `map to guest` / `usershare allow guests` settings. The backup share itself is correctly locked down with `valid users`, but this is worth understanding if you add more shares later.

## Connecting from another device

Find the server's LAN IP:

```bash
hostname -I
```

From Windows, map the share (see the Windows automation lab writeup, in progress, for the full Task Scheduler + robocopy setup):

```
\\<server-ip>\NetworkBackup
```

## Verification checklist

- [ ] `testparm` reports no syntax errors
- [ ] Another device on the LAN can connect to `\\<server-ip>\NetworkBackup` and authenticate as `backupuser`
- [ ] A test file written from that device appears in `/mnt/backup/network/` on the server

## Next

[Phase 4: Restic encrypted backups →](PHASE4-restic-encryption.md)
