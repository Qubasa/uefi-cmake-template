#!/usr/bin/env bash


echo "========START QEMU========"
echo "Exit qemu with CTRL+A, X"
qemu-kvm \
    -cpu qemu64,+svm,vendor=AuthenticAMD \
    -drive if=pflash,format=raw,file=./bios.bin \
    -nographic \
    -debugcon file:debug.log -global isa-debugcon.iobase=0x402 \
    -cdrom cdimage.iso
