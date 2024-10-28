#!/bin/sh

# Locales

locale-gen en_US.UTF-8

sudo sed -i '1i deb http://raspbian.mirrors.lucidnetworks.net/raspbian/ buster main contrib non-free rpi' /etc/apt/sources.list
sudo apt-get update

# basic utilities
sudo apt install -y \
   pkg-config \
   build-essential \
   git \
   dbus
sudo apt clean

# python
sudo apt install -y \
   python-setuptools \
   python-dev \
   python-pip \
   python-pil \
   python-dbus
sudo apt clean

# lua
sudo apt install -y \
   lua5.2 \
   liblua5.2 \
   liblua5.2-dev \
   libusb-dev
sudo apt clean

# graphics
sudo apt install -y \
   libsdl2-dev \
   libsdl2-image-dev \
   libsdl2-mixer-dev \
   libsdl2-ttf-dev \
   libgl1-mesa-dev \
   libgles2-mesa-dev \
   libgstreamer1.0-dev \
   gstreamer1.0-plugins-bad \
   gstreamer1.0-plugins-base \
   gstreamer1.0-plugins-good \
   gstreamer1.0-plugins-ugly \
   gstreamer1.0-omx \
   gstreamer1.0-alsa \
   libmtdev1 \
   libmtdev-dev
sudo apt clean

# foot pedal
sudo apt install -y wiringpi
sudo apt clean

# GUI
pip install kivy==1.11.1

# camera stuff
pip install -I Cython==0.23
pip install lupa==1.7 --install-option="--no-luajit"


# storage stuff
sudo apt install -y \
   udisks2
sudo apt clean

# Make the filesystem Read Only
sudo apt install -y \
  unionfs-fuse

dphys-swapfile swapoff
dphys-swapfile uninstall
systemctl disable dphys-swapfile 
