# vim: set ts=4 sw=4 et:

msg "Setting up SHMEM devs for VMs"

touch /dev/shm/looking-glass
chown root:kvm /dev/shm/looking-glass
chmod 660 /dev/shm/looking-glass

touch /dev/shm/scream-ivshmem
chown root:kvm /dev/shm/scream-ivshmem
chmod 660 /dev/shm/scream-ivshmem
