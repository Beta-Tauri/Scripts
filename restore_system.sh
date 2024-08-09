#!/bin/bash

BACKUP_DIR="/mnt/backup/arch_backup"

# Restaurar desde el respaldo
sudo rsync -aAXv "$BACKUP_DIR" / --exclude={"/dev/*","/proc/*","/sys/*","/tmp/*","/run/*","/mnt/*","/media/*","/lost+found"}

echo "Restauración completa desde $BACKUP_DIR"
