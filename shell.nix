with import <nixpkgs> {};
  stdenv.mkDerivation {
    hardeningDisable = [ "all" ];
    name = "env";
    buildInputs = with pkgs; [
      llvmPackages_10.clang-unwrapped
      llvmPackages_10.lld
      cmake
      gnumake
      mtools
      xorriso
    ];
    shellHook = ''
      export HISTFILE=${toString ./.history}
    '';
  }
