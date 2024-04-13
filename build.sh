#!/bin/bash

VERSION="6.6.25"

ROOT="$PWD"
TARBALL="linux-${VERSION}.tar.xz"
TARBALLURL="https://cdn.kernel.org/pub/linux/kernel/v${VERSION:0:1}.x/${TARBALL}"

curl -LO $TARBALLURL
tar -xf $TARBALL
cd linux-${VERSION}

for patch in $(ls $ROOT/patches)
do
	patch -p1 < $ROOT/patches/$patch
done

cp ${ROOT}/config .config
make olddefconfig
make bindeb-pkg -j$(nproc) INSTALL_MOD_STRIP=1
