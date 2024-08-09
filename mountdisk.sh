#!/bin/bash

# Instalar ntfs-3g
sudo pacman -S --noconfirm ntfs-3g

# Reparar el sistema de archivos NTFS
sudo ntfsfix /dev/sda1

# Crear punto de montaje si no existe
if [ ! -d "/run/media/Utility" ]; then
    sudo mkdir -p /run/media/Utility
fi

# Intentar montar manualmente
sudo mount -t ntfs-3g /dev/sda1 /run/media/Utility

# Obtener UUID del disco
UUID=$(blkid -s UUID -o value /dev/sda1)

# Editar /etc/fstab para montaje automático si no está ya presente
if ! grep -q "$UUID" /etc/fstab; then
    echo "UUID=$UUID /run/media/Utility ntfs-3g defaults 0 2" | sudo tee -a /etc/fstab
fi

# Recargar systemd y montar todas las particiones
sudo systemctl daemon-reload
sudo mount -a

echo "Montaje de disco NTFS completado y configurado para montaje automático."

