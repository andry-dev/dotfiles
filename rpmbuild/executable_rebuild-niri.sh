#!/usr/bin/sh

./SOURCES/niri-tearing.sh
rpmbuild -ba ./SPECS/niri-spicy.spec
/usr/bin/sudo dnf install "./RPMS/x86_64/niri-spicy*.rpm"
