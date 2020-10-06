#!/usr/bin/env bash

set -xe

mkdir -p iso

if [ ! -f iso/fat.img ]; then
    echo "Creating fat.img..."
    dd if=/dev/zero of=./iso/fat.img bs=1k count=1440
    mformat -i iso/fat.img -f 1440 ::
    mmd -i iso/fat.img ::/EFI
    mmd -i iso/fat.img ::/EFI/BOOT
fi

echo "Copying efi app"
mcopy -o -i iso/fat.img build/BOOTX64.EFI ::/EFI/BOOT

xorriso -as mkisofs -R -f -e fat.img -no-emul-boot -o cdimage.iso iso

