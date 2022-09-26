#!/bin/bash

# Change Debian to SID Branch
cp /etc/apt/sources.list /etc/apt/sources.list.bak
cp sources.list /etc/apt/sources.list 

username=$(id -u -n 1000)
builddir=$(pwd)

#natural scrolling
sudo apt input
# get device prop 
#xinput listx
#xinput list-props 11  (id from previous step)
xinput set-prop 11 "libinput Natural Scrolling Enabled" 1

# Add base packages
sudo apt install vim git neofetch unzip wireless-tools bmon htop ncdu bashtop

#autocpu-freq for laptop
git clone https://github.com/AdnanHodzic/auto-cpufreq.git
cd auto-cpufreq && sudo ./auto-cpufreq-installer
sudo auto-cpufreq --install

apt install picom bspwm sxhkd polybar rofi feh lighgtdm dmenu kitty caja flameshot lxpolkit lxappearance xorg pulseaudio pulseaudio-alsa pulseaudio-bluetooth bluez-utils pavucontrol -y

sudo apt install geany thunderbird bluez blueman xclip xfce4-power-manager fonts-roboto xbacklight xinput qt5-style-plugins font-manager brightnessctl redshift network-manager network-manager-gnome -y
sudo apt install libnotify-bin -y
apt install papirus-icon-theme fonts-noto-color-emoji fonts-firacode fonts-font-awesome libqt5svg5 qml-module-qtquick-controls -y

sudo apt install geany thunderbird bluez blueman wine winetricks

#install wine
sudo dpkg --add-architecture i386 # enable 32 bit package support for debian

sudo wget -O- https://dl.winehq.org/wine-builds/winehq.key | gpg --dearmor | sudo tee /usr/share/keyrings/winehq.gpg

echo deb [signed-by=/usr/share/keyrings/winehq.gpg] http://dl.winehq.org/wine-builds/debian/ bullseye main | sudo tee /etc/apt/sources.list.d/winehq.list

# Install updated wine packages
sudo apt update
sudo apt install --install-recommends winehq-stable -y
#sudo apt install --install-recommends winehq-staging -y ##seems to not install on deb 11


sudo apt install libvulkan1 libvulkan1:i386

#install lutris
echo "deb http://download.opensuse.org/repositories/home:/strycore/Debian_11/ ./" | sudo tee /etc/apt/sources.list.d/lutris.list

wget -q https://download.opensuse.org/repositories/home:/strycore/Debian_11/Release.key -O- | sudo apt-key add -

sudo apt update
sudo apt install lutris
sudo apt install libopusfile0 libsdl2-2.0.0-0 libsdl2-net-2.0-0 #required by lutris dosbox



# Download Nordic Theme
cd /usr/share/themes/
git clone https://github.com/EliverLara/Nordic.git

# Fira Code Nerd Font variant needed
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v1.1.0/FiraCode.zip
unzip FiraCode.zip -d /usr/share/fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v1.1.0/Meslo.zip
unzip Meslo.zip -d /usr/share/fonts
fc-cache -vf

#virtmanager
sudo apt install qemu-kvm libvirt-clients libvirt-daemon-system bridge-utils virtinst libvirt-daemon -y
sudo apt install virt-manager -y
#make network active and auto-restart
sudo virsh net-list --all
sudo virsh net-start default
sudo virsh net-autostart default
sudo modprobe vhost_net
sudo systemctl restart networking.service


#sudo systemctl enable bluetooth
#sudo systemctl start bluetooth
bluetoothctl scan on
bluetoothctl discoverable on
bluetoothctl pair FC:69:47:7C:9D:A3
bluetoothctl connect FC:69:47:7C:9D:A3
bluetoothctl trust FC:69:47:7C:9D:A3


#pair airpods
#systemctl start bluetooth.service
#pulseaudio -k
#bluetoothctl
#[bluetooth]# power on
#Changing power on succeeded
#[bluetooth]# agent on
#Agent registered
#[bluetooth]# default-agent
#Default agent request successful
#[bluetooth]# scan on
#Discovery started
#[NEW] Device B8:5D:0A:52:EF:86 AirPods
#[bluetooth]# pair B8:5D:0A:52:EF:86
#Attempting to pair with B8:5D:0A:52:EF:86
#(...)
#Pairing successful
#[bluetooth]# connect B8:5D:0A:52:EF:86
#Attempting to connect to B8:5D:0A:52:EF:86
#Connection successful
#[AirPods]# trust B8:5D:0A:52:EF:86
#Changing B8:5D:0A:52:EF:86 trust succeeded


#cd $builddir
#mkdir -p /home/$username/.config
#cp .Xresources /home/$username
#cp .Xnord /home/$username
#cp .xsessionrc /home/$username
#cp .profile /home/$username
#cp .tmux.conf /home/$username
#
#cp -R dotfiles/* /home/$username/.config/#
#
#mkdir -p /home/$username/Pictures/Backgrounds
#cp -R Backgrounds/* /home/$username/Pictures/Backgrounds
#mkdir -p /home/$username/.local/share/fonts
#cp -R fonts/* /home/$username/.local/share/fonts/
#mkdir -p /home/$username/.themes
#cp .R .themes/* /home/$username/.themes
#chown -R $username:$username /home/$username

