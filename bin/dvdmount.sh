#! /bin/bash


if [ -n "$1" ]
then
sudo ount $1 /mnt/dvd -o loop, ro
echo "Mounting $1 on /mnt/dvd"
else
echo "No parameters found. Include path to .iso file"
echo "Usage: dvdmount <file>"
fi
