#!/usr/bin/sh

wget https://github.com/losnoco/smithay/archive/refs/heads/spicy-master.tar.gz -O SOURCES/smithay-spicy.tar.gz
wget https://github.com/losnoco/niri/archive/refs/heads/spicy-master.tar.gz -O SOURCES/niri-spicy.tar.gz

rpmbuild -ba ./SPECS/niri-spicy.spec

/usr/bin/sudo dnf install "./RPMS/x86_64/niri-spicy*.rpm"
