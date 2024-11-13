cloud-init init --config-file cloud-init.yaml

#!/bin/bash

# Instalación automática de Ubuntu
export UBUNTU_INSTALLER_DISABLE_NETWORK_CONFIG="1"
export UBUNTU_INSTALLER_AUTOINSTALL="1"
export UBUNTU_INSTALLER_KEYMAP="us"
export UBUNTU_INSTALLER_LANGUAGE="en"
export UBUNTU_INSTALLER_COUNTRY="US"
export UBUNTU_INSTALLER_HOSTNAME="ubuntu"
export UBUNTU_INSTALLER_USERNAME="ubuntu"
export UBUNTU_INSTALLER_USERFULLNAME="Ubuntu"
export UBUNTU_INSTALLER_PASSWORD="ubuntu"

# Instalar Ubuntu
ubiquity --automatic --no-bootloader

# Instalar SSH
apt-get update
apt-get install -y openssh-server

# Configurar SSH
sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
service ssh restart

# Reiniciar
reboot