#!/bin/bash

SYSEHCI=/sys/bus/pci/drivers/ehci_hcd
SYSUHCI=/sys/bus/pci/drivers/uhci_hcd

if [[ $EUID != 0 ]] ; then
 echo This must be run as root!
 exit 1
fi

if ! cd $SYSUHCI ; then
 echo Weird error. Failed to change directory to $SYSUHCI
 exit 1
fi

for i in ????:??:??.? ; do
 echo -n "$i" > unbind
 echo -n "$i" > bind
done

if ! cd $SYSEHCI ; then
 echo Weird error. Failed to change directory to $SYSEHCI
 exit 1
fi

for i in ????:??:??.? ; do
 echo -n "$i" > unbind
 echo -n "$i" > bind
done
