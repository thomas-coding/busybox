#!/bin/sh
#
# mkrootfs.sh - creates rootfs

# shell folder
current_dir=$(cd "$(dirname "$0")" || exit;pwd)
root_dir=${current_dir}/../../..

# Copy busybox to rootfs
cd ${root_dir}

rm -rf ${root_dir}/busybox/rootfs
mkdir -p ${root_dir}/busybox/rootfs
cp -r ${root_dir}/busybox/_install/* ${root_dir}/busybox/rootfs/

# Copy toolchain lib to rootfs
#mkdir -p ${shell_folder}/rootfs/lib
#cp -r /home/cn1396/.toolchain/arm-gnu-toolchain-12.2.rel1-x86_64-aarch64-none-linux-gnu/aarch64-none-linux-gnu/lib/* ${shell_folder}/busybox/rootfs/lib

# Make dev dir, now used busybox mkdevs.sh to create dev dir
mkdir -p ${root_dir}/busybox/rootfs/dev
cd ${root_dir}/busybox/rootfs/dev
sudo ${root_dir}/busybox/examples/a55/mkdevs.sh ${root_dir}/busybox/rootfs/dev
#	mknod -m 666 tty1 c 4 1
#	mknod -m 666 tty2 c 4 2
#	mknod -m 666 tty3 c 4 3
#	mknod -m 666 tty4 c 4 4
#	mknod -m 666 console c 5 1
#	mknod -m 666 null c 1 3

# Make other dir
mkdir -p ${root_dir}/busybox/rootfs/sys
mkdir -p ${root_dir}/busybox/rootfs/proc
mkdir -p ${root_dir}/busybox/rootfs/mnt
mkdir -p ${root_dir}/busybox/rootfs/initrd
mkdir -p ${root_dir}/busybox/rootfs/usr/lib
mkdir -p ${root_dir}/busybox/rootfs/usr/bin
mkdir -p ${root_dir}/busybox/rootfs/root

# copy etc
cp -r ${root_dir}/busybox/examples/a55/etc ${root_dir}/busybox/rootfs/
#ln -s /proc/mounts ${shell_folder}/busybox/rootfs/etc/mtab

# Pack rootfs
rm -rf ${root_dir}/busybox/rootfs.cpio
cd ${root_dir}/busybox/rootfs
find . | fakeroot cpio -o -H newc > ${root_dir}/busybox/rootfs.cpio

