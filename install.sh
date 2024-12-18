#!/bin/bash

# extra apps to install
# zoom ungoogled-chromium *pcoip*

# CONFIG stuff

pushd ~
git clone https://github.com/NeitherDucks/dotfiles.git
rsync -q ~/dotfiles/home/ ~
popd

# SDDM stuff

# Create autologin file
touch /etc/sddm.conf.d/autologin.conf
# Set autologin to my username and a hyprland session
echo -e "[Autologin]\nUser=$USER\nSession=hyprland" > /etc/sddm.conf.d/autologin.conf

# NVIDIA stuff

# Enable nvidia kernel mode setting
sed -i '/MODULES=()/c\MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm)' /etc/mkinitcpio.conf

# Creating nvidia mode settings file
touch /etc/modprobe.d/nvidia.conf
# Add modeset and fbdev settings
echo -e "options nvidia_drm modeset=1 fbdev=1" > /etc/modprobe.d/nvidia.conf
# Add on suspend memory to ram settings
echo -e "options nvidia NVreg_PreserveVideoMemoryAllocations=1 NVreg_TemporaryFilePath=/var/tmp" >> /etc/modprobe.d/nvidia.conf

# Rebuild the initramfs
mkinitcpio -P

# Enable nvidia sleep services
systemctl enable nvidia-suspend.service
systemctl enable nvidia-hibernate.service


# FSTAB stuff
echo -e "\n# /dev/nvme0n1p1\nUUID=16D47727D47707EF	/mnt/projects   ntfs-3g		relatime,umask=0022,uid=1000,windows_names 0 0" >> /etc/fstab
echo -e "\n# /dev/nvme1n1p1\nUUID=C03A7FAE3A7F9FD8	/mnt/games	ntfs-3g		relatime,umask=0022,uid=1000,windows_names 0 0" >> /etc/fstab

# Install paru
pushd ~
git clone https://aur.archlinux.org/paru.git
pushd paru
makepkg -si
popd
popd

# Other apps
paru
paru brave
paru pypr
