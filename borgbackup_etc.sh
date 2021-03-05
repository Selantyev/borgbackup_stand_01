#!/bin/bash
# Borgbackup script

# User and server name
BACKUP_USER=root
BACKUP_SERVER=backup-server

# Backup type (data, etc, mysql, system)
BACKUP_TYPE=etc

# Remote repository
REPOSITORY=$BACKUP_USER@$BACKUP_SERVER:/var/backups/$(hostname)-${BACKUP_TYPE}

# Export passphrase
export BORG_PASSCOMMAND="cat /root/.borg-passphrase"

# Create backup
borg create -v -s $REPOSITORY::'{now:%Y-%m-%d-%H-%M}' /etc

# Prune backups
borg prune -v --show-rc --list $REPOSITORY \
           --keep-within=92d --keep-monthly=-1
