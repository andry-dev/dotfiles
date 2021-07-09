#!/bin/bash

DEVS="0000:05:00.0 0000:05:00.1"

for dev in $DEVS; do
	echo "vfio-pci" > /sys/bus/pci/devices/$dev/driver_override
done

modprobe -i vfio-pci
