#!/bin/sh

sudo mv mnt/etc/ld.so.preload  mnt/etc/ld.so.preload.backup

sudo cp /usr/bin/qemu-arm-static mnt/usr/bin/

#sudo sed -i '1i deb http://raspbian.mirrors.lucidnetworks.net/raspbian/ buster main contrib non-free rpi' /etc/apt/sources.list

# move the appropriate sources.list file into place
#sudo cp files/sources-base.list mnt/etc/apt/sources.list
#sudo cp files/sources-old.list mnt/etc/apt/sources.list
#sudo cp files/sources-raspios.list mnt/etc/apt/sources.list

# Locale configuration

sudo cp files/locale mnt/etc/default/locale
sudo cp files/locale.gen mnt/etc/locale.gen

################################################
# Chroot Commands
################################################

sudo cp base-packages.sh mnt/
cd mnt
sudo chroot . ./base-packages.sh
cd ..
sudo rm mnt/base-packages.sh

# Cleanup

sudo mv mnt/etc/ld.so.preload.backup  mnt/etc/ld.so.preload

