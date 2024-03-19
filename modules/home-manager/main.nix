{ config, lib, pkgs, ...}:

let
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-23.11.tar.gz";
  unstable = import <nixos-unstable> { config = { allowUnfree = true; }; };
  #cuda = pkgs.cudaPackages.cudatoolkit;
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

      pkg-config

      unstable.jetbrains-toolbox
      unstable.vcpkg
      unstable.cmake
      unstable.gnumake
      unstable.clang-tools_17

      unstable.nodejs

      python38

      #gnupg
      #autoconf
      #procps
      #util-linux
      #m4
      #gperf
      #cudatoolkit
      #linuxPackages.nvidia_x11
      #libGLU libGL
      #cudaPackages.cudatoolkit
      #cudaPackages.cudnn
      #cudaPackages.cuda_cudart
      #unstable.cudaPackages.cuda_nvcc
      
    ];


    #home.sessionVariables = {
    #  CUDA_PATH = "${cuda}";
    #  CUDA_ROOT = "${cuda}";
    #  CUDA_HOME = "${cuda}";
    #  PATH = lib.makeBinPath [
    #    cuda
    #    pkgs.git
    #    pkgs.neovim
    #    unstable.jetbrains-toolbox
    #  ] + ":$PATH";
    #  LD_LIBRARY_PATH = "${cuda}/lib64:${pkgs.linuxPackages.nvidia_x11}/lib:$LD_LIBRARY_PATH";
    #};


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
