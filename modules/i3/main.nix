{ configs, pkgs, ... }:

{
  services.xserver.displayManager.defaultSession = "none+i3";
  services.xserver.windowManager.i3 = {
    enable = true;
    package = pkgs.i3-gaps;
    extraPackages = with pkgs; [
      dmenu
      i3status-rust
      i3lock
      i3blocks
      i3-gaps
    ];
  };

  programs.dconf.enable = true;

  environment.systemPackages = with pkgs; [
    lxappearance # To change icons and themes
  ];
}
