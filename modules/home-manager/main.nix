{ config, lib, pkgs, ...}:

let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-24.05.tar.gz";
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
  
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
    home.stateVersion = "24.05";

    programs.ssh = {
      enable = true;
      extraConfig = ''
        PubkeyAuthentication yes
      '';
    };

#    home.file.".ssh/authorized_keys".text = ''
#        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIGSCn0+Tmia4dHCEOFxxmoI3owHtKqlKSQ2hYNMKn4dv ariel"
#	"ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPlq+lB2uniY1hKBUQ8olz093FZoA2dkcdpo2G7OEKTE arielsaldana@Ariels-MB"
    #'';

    home.packages = with pkgs; [
      zip
      unzip
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
      nix-prefetch
      nix-prefetch-github
      rofi
      flameshot
      ranger
      chromium
      openssl
      lxappearance
      htop
      btop
      tmux

      pkg-config

      unstable.jetbrains-toolbox
      unstable.vcpkg
      unstable.cmake
      unstable.gnumake
      unstable.clang-tools_17

      unstable.nodejs

      python39
      python311Packages.pip
      wget

      stdenv.cc.cc.lib
      conda

      #1password
      _1password-gui
    ];

    home.file = {
      ".config/nvim".source = dotfiles/nvim;
    };

    imports = [ ./configs/main.nix ];
  };

  environment.etc = {
    "xdg/gtk-2.0/gtkrc".text = "gtk-error-bell=0";
    "xdg/gtk-3.0/settings.ini".text = ''
      [Settings]
      gtk-error-bell=false
    '';
    "xdg/gtk-4.0/settings.ini".text = ''
      [Settings]
      gtk-error-bell=false
    '';    
  };
}
