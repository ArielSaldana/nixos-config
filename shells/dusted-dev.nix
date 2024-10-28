# Run with `nix-shell cuda-shell.nix`
{ pkgs ? import <nixpkgs> { config = { allowUnfree = true; }; }, unstablePkgs ? import <nixos-unstable> { config = { allowUnfree = true; }; }  }:

pkgs.mkShell {
   name = "dusted-dev-shell";
   buildInputs = with pkgs; [
     gcc
     cmake
     openssl.dev
     boost
     pkg-config
     git
     clang
     zlib
   ];
   shellHook = ''
      echo "Evironment Setup."
   '';          
}

