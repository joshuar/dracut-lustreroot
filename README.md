# About

This is a dracut module to provide support for booting a machine with
its root on LustreFS.  This module is based largely on concepts in the
modules included with dracut, namely the nfs, netroot and syslog
modules.

# Requirements

 - A working Lustre cluster.
 - PXE boot network.
 - Dracut v003

# Usage

## Installation

 - Install this module under the dracut `modules.d` directory (usually
   located at either `/usr/share/dracut/modules.d` or
   `/usr/lib/dracut/modules.d` depending on your distribution) in a
   directory called `95lustre`.

## Configuration

 - Edit the dracut configuration file and change the
   `DRACUT_ADDMODULES` parameter to include "lustre".
 - Edit your kernel command-line and include the following three
   arguments as outlined below:
  - `lustreserver`: IP address and interface on which to connect to
   lustre server in *lnet* format. e.g., `IPaddr@o2ib` or
   `IPaddr@tcp0`.
  - `lustrefs`: Lustre filesystem to mount. e.g., `/lustrefs1`.
  - `lustrepath`: Directory path on Lustre filesystem to use as root.
   e.g., `/images/centos/6.5`.
 - Rebuild your initramfs with dracut.

# Limitations

 - Only tested with CentOS 6.5.