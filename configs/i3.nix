{ pkgs, lib, ... }:

let
  mod = "Mod4";

in {
  xsession.windowManager.i3 = {
    enable = true;
    package = pkgs.i3-gaps;

    config = rec {
      modifier = "Mod4";
      bars = [
        {
          position = "top";
          statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ~/.config/i3status-rust/config-top.toml";
        }
      ];

      window.border = 0;

      gaps = {
        inner = 5;
        outer = 5;
      };

      keybindings = lib.mkOptionDefault {
        "${modifier}+b" = "exec ${pkgs.firefox}/bin/firefox";
        "${modifier}+Return" = "exec ${pkgs.kitty}/bin/kitty";
      };

      startup = [
        #{
        #}
      ];
    };

    extraConfig = ''
      default_border pixel 1
      default_floating_border pixel 1
    '';
  };

  programs.i3status-rust = {
    enable = true;
    bars = {
      top = {
        blocks = [
          {
            block = "time";
            interval = 60;
            format = "%a %d/%m %k:%M %p";
          }
        ];
      };
    };
  };
}
