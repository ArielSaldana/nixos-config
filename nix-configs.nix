{ config, pkgs, lib, ... }:

{
  imports = [
    ./configs/i3.nix
  ];

  programs = {
    home-manager.enable = true;
    zsh = {
      enable = true;
    };
  };

  xsession.enable = true;
  
}
