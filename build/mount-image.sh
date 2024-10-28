#!/bin/sh

# Get the device
device=$1
resolved_device=$(readlink -f $device)

# Get the sector size
sector_size=$(fdisk -l "$resolved_device" | grep 'Sector size' | awk -F ' ' '{print $4}')

# Get the start of the second partition
second_partition_start=$(fdisk -l "$resolved_device" | grep '^/home/' | awk 'NR==2 {print $2}')

# calculate the start of the second partition in bytes
START_PARTITION=$(( $second_partition_start*$sector_size ))
printf "Second partition starts at %d bytes\n" $START_PARTITION

# create a loop device for the the second partition of the image
# the first partition is the boot partition and we aren't interested in it

sudo losetup --offset $START_PARTITION /dev/loop666 $resolved_device

# mount the loop device to the mnt directory
sudo mount /dev/loop666 mnt





