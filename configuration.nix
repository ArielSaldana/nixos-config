# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./modules/nvidia/main.nix
      ./modules/docker/main.nix
#      ./modules/fonts/main.nix
      ./modules/home-manager/main.nix
#      ./modules/i3/main.nix
#      ./modules/curl/main.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelModules = [ "kvm-amd" ]; #virtualization
  virtualisation.libvirtd = {
  enable = true;
  qemu = {
    package = pkgs.qemu_kvm;
    runAsRoot = true;
    swtpm.enable = true;
    ovmf = {
      enable = true;
      packages = [(pkgs.OVMF.override {
        secureBoot = true;
        tpmSupport = true;
      }).fd];
    };
  };
};

  boot.initrd.luks.devices."luks-f301b87d-798f-4896-98d0-561be1c6ceb6".device = "/dev/disk/by-uuid/f301b87d-798f-4896-98d0-561be1c6ceb6";
  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Configure ZSH
  programs.zsh = {
    enable = true;
    shellAliases = {
      ll="ls --color --group-directories-first -AFohg";
      ls="ls --color --group-directories-first -F";
      la="ls --color --group-directories-first -AF";
      update = "sudo nixos-rebuild switch";
      svim = "sudo nvim";
    };
  };

  # Configure Oh My Zsh
  programs.zsh.ohMyZsh = {
    enable = true;
    theme = "robbyrussell";
    plugins = [
      "sudo"
      "git"
    ];
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ariel = {
    isNormalUser = true;
    description = "ariel";
    extraGroups = [ "networkmanager" "wheel" "plugdev" "libvirtd" ];
    packages = with pkgs; [];
    shell = pkgs.zsh;
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
  #  home-manager
    #ca-certs
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;

    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
    };


  };

  # Open ports in the firewall.
  #networking.firewall.allowedTCPPorts = [ 22 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

  # Display configuration
  environment.pathsToLink = [ "libexec" ];
  services.xserver = {
    enable = true;
    # Configure keymap in X11
    layout = "us";
    xkbVariant = "";
    dpi = 96;
    desktopManager = {
      xterm.enable = false;
    };
    displayManager = {
      defaultSession = "none+i3";
    };
    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        dmenu
        i3status
        i3lock
        i3blocks
        i3-gaps
      ];
    };
  };

  # Enable sound with pipewire.
  #sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  security.pam.services.login = {
  limits = [
    {
      domain = "*";
      type = "hard";
      item = "nofile";
      value = "65535";
    }
    {
      domain = "*";
      type = "soft";
      item = "nofile";
      value = "65535";
    }
  ];
};

  boot.kernel.sysctl = {
  "fs.file-max" = 2097152;
  "net.ipv4.ip_local_port_range" = "1024 65535";
  "net.core.somaxconn" = 4096;
  "net.ipv4.tcp_max_syn_backlog" = 4096;
  "net.ipv4.tcp_tw_reuse" = 1;
  "net.ipv4.tcp_tw_recycle" = 1;
  "net.ipv4.tcp_fin_timeout" = 15;
};
  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [ 22 80 443 3000 6333 6334 50051 50052 5432 6379 9000 9002 9042 27017 28017];

}
