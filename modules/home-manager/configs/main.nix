{ config, pkgs, lib, ... }:

{
  imports = [
    ./i3.nix
    ./picom.nix
    ./kitty.nix
  ];

  programs = {
    home-manager.enable = true;
    zsh = {
      enable = true;
    };
  };

  xsession.enable = true;
}
