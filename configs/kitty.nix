{ pkgs, ... }:

{
  programs.kitty = {
    enable = true;
    theme = "Tokyo Night";
    #font.name = "JetBrainsMono Nerd Font";

    extraConfig = ''
      font_size 11
      dynamic_background_opacity yes
      background_opacity 0.3
    '';
  };
}
