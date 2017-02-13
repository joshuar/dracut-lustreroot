#!/bin/sh

PATH=/usr/sbin:/sbin:/usr/bin:/bin

# We're following the standard used by other *root scripts here
# for command-line arguments.  However, we don't use them, our
# command-line parsing script writes the settings we need to
# files in /tmp in the initramfs

#[ -z "$1" ] && exit 1
#[ -z "$2" ] && exit 1
#[ -z "$3" ] && exit 1

netif="$1"
root="$2"
NEWROOT="$3"

# Read the settings from the files created by a command-line
# parsing script from /tmp
[ -r /tmp/lustre.server ] && read lustreserver < /tmp/lustre.server
[ -r /tmp/lustre.server ] && read lustrefs < /tmp/lustre.fs
[ -r /tmp/lustre.server ] && read lustrepath < /tmp/lustre.path
[ -r /tmp/lustre.opts ] && read lustreopts < /tmp/lustre.opts
# Create some new variables
lustreroot="$lustreserver:$lustrefs"
if [ -n $lustrepath ] ; then
    lustrerootpath="/lustremnt$lustrepath"
else
    lustrerootpath="/lustremnt"
fi
[ -n $lustreopts ] && lustreopts="-o $lustreopts"

# Make sure the required lustre kernel modules are loaded
/sbin/modprobe e1000 >/dev/null 2>&1
/sbin/modprobe lnet >/dev/null 2>&1
/sbin/modprobe lustre >/dev/null 2>&1

# Mount the lustre filesystem
ifconfig eno1 up
dhclient eno1
mount.lustre $lustreopts $lustreroot /lustremnt
sleep 5
# Bind mount the root path to $NEWROOT
NEWROOT=/sysroot
#echo "mount -B $lustrerootpath $NEWROOT" > /mount_command2.sh
mount -B $lustrerootpath $NEWROOT

exit 0
