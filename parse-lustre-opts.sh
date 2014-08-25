#!/bin/sh
# Parses the lustre commandline options
#
# Preferred format:
#
#    lustreserver = IPa@o2ib:IPb@o2ib
#    lustrefs     = /system
#    lustrepath   = /image/centos-6.5

type getarg >/dev/null 2>&1 || . /lib/dracut-lib.sh

# Get the lustre-specific initramfs command-line arguments
lustreserver=$(getarg lustreserver=)
lustrefs=$(getarg lustrefs=)
lustrepath=$(getarg lustrepath=)
# Write the argument values out to temporary files under /tmp
# These will be used later by our lustreroot.sh script to
# mount the lustre fs
[ -n "$lustreserver" ] && echo $lustreserver > /tmp/lustre.server
[ -n "$lustrefs" ] && echo $lustrefs > /tmp/lustre.fs
[ -n "$lustrepath" ] && echo $lustrepath > /tmp/lustre.path

# Set required variables so dracut doesn't complain
rootok=1
root="lustrefs"
netroot=lustre

echo '[ -e $NEWROOT/proc ]' > /initqueue-finished/lustreroot.sh

