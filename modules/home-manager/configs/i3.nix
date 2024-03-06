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
          statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs /etc/nixos/modules/home-manager/dotfiles/i3status-rust/config.toml";
        }
      ];

      window.border = 0;

      gaps = {
        inner = 5;
        outer = 5;
      };

      keybindings = lib.mkOptionDefault {
        "${modifier}+b" = "exec ${pkgs.chromium}/bin/chromium";
        "${modifier}+Return" = "exec ${pkgs.kitty}/bin/kitty";
	"${modifier}+Shift+4" = "exec ${pkgs.flameshot}/bin/flameshot gui";
	"${modifier}+Shift+5" = "exec ${pkgs.flameshot}/bin/flameshot screen -p ~/Screenshots";
      };

      startup = [
        {
	  # Set our background on startup, required feh to be installed..
	  command = "feh --bg-scale ~/.background-image";
	  always = true;
	  notification = false;
        }
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
