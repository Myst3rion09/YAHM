#!/bin/sh

EQ3LOOP_MAJOR=`/bin/cat /sys/module/plat_eq3ccu2/parameters/eq3charloop_major`
UART_MAJOR=`/bin/cat /sys/module/plat_eq3ccu2/parameters/uart_major`

version () { /bin/echo "$@" | /usr/bin/awk -F. '{ /usr/bin/printf("%03d%03d%03d\n", $1,$2,$3); }'; }

# generate/update dev nodes

/bin/rm -f /dev/eq3loop
/bin/rm -f /dev/ttyS0
/bin/rm -f /dev/mmd_bidcos
/bin/rm -f /dev/mxs_auart_raw.0

/bin/mknod -m 666 /dev/mxs_auart_raw.0 c $UART_MAJOR 0

# get radio mac and serial
/bin/eq3configcmd update-coprocessor -p /dev/mxs_auart_raw.0 -t HM-MOD-UART -c -se 2>&1 | /bin/grep "SerialNumber:" | /usr/bin/cut -d' ' -f5 > /sys/module/plat_eq3ccu2/parameters/board_serial
/bin/eq3configcmd read-default-rf-address -f /dev/mxs_auart_raw.0 -h | /bin/grep "^0x" > /sys/module/plat_eq3ccu2/parameters/radio_mac

firmware_version=`/bin/eq3configcmd update-coprocessor -p /dev/mxs_auart_raw.0 -t HM-MOD-UART -c -v 2>&1 | /bin/grep "Version:" | /usr/bin/cut -d' ' -f5`
/bin/echo $firmware_version > /sys/module/plat_eq3ccu2/parameters/board_extended_info

if [ "$(version "$firmware_version")" -lt "$(version "2.0.0")" ]; then
	/bin/ln -sf /dev/mxs_auart_raw.0 /dev/mmd_bidcos
else
	/bin/mknod -m 666 /dev/eq3loop c $EQ3LOOP_MAJOR 0                               
	/bin/mknod -m 666 /dev/ttyS0 c $EQ3LOOP_MAJOR 1  
	/bin/mknod -m 666 /dev/mmd_bidcos c $EQ3LOOP_MAJOR 2
fi
