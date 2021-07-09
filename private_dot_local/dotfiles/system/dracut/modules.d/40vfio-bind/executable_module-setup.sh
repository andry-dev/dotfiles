#!/bin/bash

check() {
	return 0
}

depends() {
	return 0
}

install() {
	inst_hook pre-trigger 91 "$moddir/vfio-bind.sh"
}

installkernel() {
	instmods vfio vfio_iommu_type1 vfio_pci vfio_virqfd
}
