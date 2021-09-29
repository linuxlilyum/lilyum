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

for i in NetworkManager sddm; do
	systemctl -f enable $i
done

# for i in purge-kernels; do
# 	systemctl -f disable $i
# done

systemctl -f disable purge-kernels

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
