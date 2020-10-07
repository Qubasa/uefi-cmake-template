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
Now create an iso image by executing the shell script `create_iso.sh`.
Afterwards boot into qemu by executing `./run.sh`.


## Updating UEFI headers
The current efi headers are from the efi specification 2.8. If you want to update them
checkout the [edk2](https://github.com/tianocore/edk2) and copy the contents of the folder
`edk2/MdePkg/Include` to `include/UEFI`. Then patch one line in `include/UEFI/x64/ProcessorBind.h`
from `typedef unsigned short  CHAR16;` to `typedef wchar_t CHAR16;`.

You should probably also update `bios.bin` by [building OVMF from edk2](https://github.com/tianocore/tianocore.github.io/wiki/How-to-build-OVMF)


## Trivia
You can inspect the generated assembly by executing `make src/main.s`
and then viewing the generated asm file with your favourite editor.

