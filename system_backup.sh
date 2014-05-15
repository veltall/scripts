#!/bin/bash
# full system backup

# Backup destination
backdest=/opt/backup

# Labels for backup name
#PC=${HOSTNAME}
pc=hp14
distro=arch
type=full
date=$(date "+%F")
backupfile="$backdest/$distro-$type-$date.tar.gz"

# Exclude file location
prog=${0##*/} # Program name from filename
excdir="/home/veltall/.scripts"
exclude_file="$excdir/backup_exclude"

# Check if chrooted prompt.
echo -n "First chroot from a LiveCD.  Are you ready to backup? (y/n): "
read executeback

# Check if exclude file exists
if [ ! -f $exclude_file ]; then
  echo -n "No exclude file exists, continue? (y/n): "
  read continue
  if [ $continue == "n" ]; then exit; fi
fi

if [ $executeback = "y" ]; then
  tar --exclude-from=$exclude_file -czpvf $backupfile /
fi
