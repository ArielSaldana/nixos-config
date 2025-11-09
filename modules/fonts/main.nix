{ config, lib, pkgs, ... }:

{
  imports = [
    ./iosevka.nix
  ];


  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
    liberation_ttf
    fira-code
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
    powerline-fonts
    (nerdfonts.override 
      { 
        fonts = [ 
          "FiraCode"
	  "DroidSansMono"
	  "Iosevka"
	  "IosevkaTerm" 
        ]; 
      }
    )
  ];
}
