#!/bin/sh
check() {
return 0
}

depends() {
return 0
}

install() {
if [ -f /lib/modprobe.d/lustre.conf ]; then
   inst_multiple /lib/modprobe.d/lustre.conf
else
   [ -d $initdir/etc/modprobe.d/ ] || mkdir $initdir/etc/modprobe.d
   echo "e1000" > $initdir/etc/modprobe.d/lustre.conf
   echo "lnet" >> $initdir/etc/modprobe.d/lustre.conf
   echo "lustre" >> $initdir/etc/modprobe.d/lustre.conf
fi


inst_hook cmdline 90 "$moddir/parse-lustre-opts.sh"

dracut_install mount.lustre lustre_routes_config lctl
inst_dir /lustremnt
[ -e /etc/udev/rules.d/95-lustre.rules ] && inst_rules /etc/udev/rules.d/95-lustre.rules
[ -e /etc/modprobe.d/lnet.conf ] && dracut_install /etc/modprobe.d/lnet.conf
inst_hook pre-pivot 95 "$moddir/lustreroot.sh"
}

