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
      export NIX_DEBUG=1 # Print all compile flags
      export VERBOSE=1   # Print all make commands
      ln -s ${pkgs.llvmPackages_10.lld.dev.outPath} lld-dev
    '';
  }
