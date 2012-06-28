#!/bin/bash
log='/tmp/init.log'

# This script will be run as root - be careful!

# Update repos and upgrade packages.
apt-get update &>> $log
apt-get upgrade -y &>> $log

# Install required binaries.
apt-get install -y binfmt-support qemu qemu-user-static unzip &>> $log

# Make /images folder and download images.
mkdir /images

mkdir /images/debian-squeeze
wget "http://files.velocix.com/c1410/images/debian/6/debian6-19-04-2012/debian6-19-04-2012.zip" -O "/images/debian-squeeze.zip" &>> $log
unzip "/images/debian-squeeze.zip" -d /images/debian-squeeze &>> $log
rm /images/debian-squeeze.zip
mount -o loop,offset=80740352 "/images/debian-squeeze/debian6-19-04-2012/debian6-19-04-2012.img" /mnt &>> $log
echo "Mounted Debian Squeeze image at /mnt"

cp /usr/bin/qemu-arm-static /mnt/usr/bin/

# You can `chroot /mnt` to load the emulated system!
