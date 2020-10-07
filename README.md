## Description
This is a working c++ cmake project to compile uefi apps on Linux with clang.


## Usage

If you do not have NixOS then skip the `nix-shell` and instead install
the dependencies listed in the `shell.nix` file.

```bash
$ git clone git@github.com:Luis-Hebendanz/uefi-cmake-template.git
$ cd uefi-cmake-template
$ nix-shell shell.nix
$ mkdir build && cd build
$ cmake ..
$ make
```

This should output a binary called `BOOTX64.EFI`.
Now create a iso image by executing the shell script `create_iso.sh`.
Afterwards boot into qemu by executing `./run.sh`.

