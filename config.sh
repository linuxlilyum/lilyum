#!/bin/bash
#================
# FILE          : config.sh
#----------------
# PROJECT       : OpenSuSE KIWI Image System
# COPYRIGHT     : (c) 2006 SUSE LINUX Products GmbH. All rights reserved
#               :
# AUTHOR        : Marcus Schaefer <ms@suse.de>
#               :
# BELONGS TO    : Operating System images
#               :
# DESCRIPTION   : configuration script for SUSE based
#               : operating systems
#               :
#               :
# STATUS        : BETA
#----------------
#======================================
# Functions...
#--------------------------------------
test -f /.kconfig && . /.kconfig
test -f /.profile && . /.profile

#======================================
# Greeting...
#--------------------------------------
echo "Düzenleniyor: [$kiwi_iname]..."

#======================================
# Setup baseproduct link
#--------------------------------------
suseSetupProduct

#======================================
# Activate services
#--------------------------------------
suseInsertService sshd

#======================================
# Setting the Graphical Target 
#--------------------------------------
baseSetRunlevel 5

#==========================================
# Remove package docs
#------------------------------------------
rm -rf /usr/share/doc/packages/*
rm -rf /usr/share/doc/manual/*

#--------------------------------------
# enable and disable services

for i in NetworkManager tlp tlp-sleep avahi-dnsconfd; do
	systemctl -f enable $i
done

for i in purge-kernels wicked auditd apparmor sddm; do
	systemctl -f disable $i
done

#Keys
REPODIR="/etc/zypp/repos.d"
KEYS="key-Google.pub key-Packman.pub key-Skype.pub key-openSUSE.pub key-Nvidia.pub key-Tarbetu.pub key-Vivaldi.pub key-Brave.asc"

for i in $KEYS; do 
    THE_FILE=$REPODIR/$i
    rpm --import $THE_FILE
    rm $THE_FILE
done

rm -rf /var/cache/zypp/raw/*

#======================================
# /etc/sudoers hack to fix #297695 
# (Installation Live CD: no need to ask for password of root)
#--------------------------------------
sed -i -e "s/ALL ALL=(ALL) ALL/ALL ALL=(ALL) NOPASSWD: ALL/" /etc/sudoers 
chmod 0440 /etc/sudoers

/usr/sbin/useradd -m -u 999 lilyum -c "lilyum" -p "" -s /usr/bin/fish

# fish shell for root 
chsh -s /usr/bin/fish


# delete passwords
passwd -d root
passwd -d lilyum
# empty password is ok
pam-config -a --nullok

: > /var/log/zypper.log

chown -R lilyum:users /home/lilyum
echo "Storage=volatile" >> /etc/systemd/journald.conf

#Flatpak
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
#flatpak install -y -vv --noninteractive flathub com.valvesoftware.Steam
#flatpak install -y -vv --noninteractive flathub org.telegram.desktop
#flatpak install -y -vv --noninteractive flathub com.spotify.Client

#BreezeBlurred
git clone https://github.com/alex47/BreezeBlurred
cd BreezeBlurred
mkdir build
cd build
cmake .. -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_BUILD_TYPE=Release -DKDE_INSTALL_LIBDIR=lib -DBUILD_TESTING=OFF -DKDE_INSTALL_USE_QT_SYS_PATHS=ON
sudo make install
cd ..
cd ..
rm -rf BreezeBlurred

echo "blacklist pcspkr" | sudo tee /etc/modprobe.d/beep.conf
