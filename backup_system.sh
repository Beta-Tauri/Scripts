#!/bin/bash

BACKUP_DIR="/mnt/backup/arch_backup"

# Crear directorio de respaldo si no existe
[ ! -d "$BACKUP_DIR" ] && mkdir -p "$BACKUP_DIR"

# Ejecutar rsync para copiar el sistema
sudo rsync -aAXv --exclude={"/dev/*","/proc/*","/sys/*","/tmp/*","/run/*","/mnt/*","/media/*","/lost+found"} / "$BACKUP_DIR"

echo "Copia de seguridad completa en $BACKUP_DIR"
