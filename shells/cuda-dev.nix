# Run with `nix-shell cuda-shell.nix`
{ pkgs ? import <nixpkgs> { config = { allowUnfree = true; }; }, unstablePkgs ? import <nixos-unstable> { config = { allowUnfree = true; }; }  }:

pkgs.mkShell {
   name = "cuda-env-shell";
   buildInputs = with unstablePkgs; [
     git gitRepo gnupg autoconf curl
     procps gnumake util-linux m4 gperf unzip
     cudatoolkit linuxPackages.nvidia_x11
     libGLU libGL
     xorg.libXi xorg.libXmu freeglut
     xorg.libXext xorg.libX11 xorg.libXv xorg.libXrandr zlib 
     ncurses5 stdenv.cc binutils
   ];
   shellHook = ''
      export CUDA_PATH=${unstablePkgs.cudatoolkit}
      # export LD_LIBRARY_PATH=${unstablePkgs.linuxPackages.nvidia_x11}/lib:${pkgs.ncurses5}/lib
      export EXTRA_LDFLAGS="-L/lib -L${unstablePkgs.linuxPackages.nvidia_x11}/lib"
      export EXTRA_CCFLAGS="-I/usr/include"
   '';          
}

