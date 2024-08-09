#!/bin/bash


# Actualizar el sistema base
sudo pacman -Syu --noconfirm

# Instalar y habilitar yay para AUR
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm
cd ..

# Instalar y habilitar Snap
git clone https://aur.archlinux.org/snapd.git
cd snapd
makepkg -si --noconfirm
cd ..
sudo systemctl enable --now snapd.socket
sudo ln -s /var/lib/snapd/snap /snap

# Instalar paquetes adicionales desde AUR
yay -S --noconfirm mariadb mysql-workbench microsoft-edge-dev-bin spotify postman-bin visual-studio-code-bin obs-studio torbrowser-launcher discord ntfs-3g dhcpcd inetutils telegram-deskstop


# Instalar Warp desde el archivo local
sudo pacman -U /run/media/Utility/Tools/Packages/warp-terminal-v0.2024.07.30.08.02.stable_01-1-x86_64.pkg.tar.zst

# Inicializar la base de datos de MariaDB
sudo mariadb-install-db --user=mysql --basedir=/usr --datadir=/var/lib/mysql

# Iniciar y habilitar MariaDB
sudo systemctl enable mariadb
sudo systemctl start mariadb

# Ejecutar la configuración inicial de MariaDB
sudo mysql_secure_installation

# Crear archivo de escritorio para Warp
sudo bash -c 'cat <<EOF > /usr/share/applications/warp-terminal.desktop
[Desktop Entry]
Name=Warp Terminal
Exec=warp
Terminal=false
Type=Application
Icon=utilities-terminal
EOF'

# Establecer Warp como la terminal predeterminada en GNOME
gsettings set org.gnome.desktop.default-applications.terminal exec warp
gsettings set org.gnome.desktop.default-applications.terminal exec-arg ""

echo "Warp configurado como la terminal predeterminada en GNOME."

echo "Instalación de paquetes y configuraciones adicionales completada."
