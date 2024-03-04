{ config, lib, pkgs, ...}:

let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-23.11.tar.gz";

in
{
  imports = [
    (import "${home-manager}/nixos")
  ];

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
  };

  home-manager.users.ariel = {
    home.username = "ariel";
    home.homeDirectory = "/home/ariel";
    home.stateVersion = "23.11";

    home.packages = with pkgs; [
      #vim      
      neovim
      neofetch
      firefox
      kitty
      git
      gh
      sapling
      rustup
      gcc
      libgcc

      xclip
      feh
    ];

    home.file = {
      ".config/nvim".source = dotfiles/nvim;
    };

    imports = [ ./nix-configs.nix ];
  };
}
