{ pkgs, lib, ... }:

let
  modifier = "Mod4";
  background = "#282a36";

in {
  xsession.windowManager.i3 = {
    enable = true;
    #package = pkgs.i3-gaps;

    config = {
      modifier = modifier;
      
      fonts = {
        names = ["Iosevka"];
	style = "Light";
	size = 8.0;
      };

      bars = [
        {
          position = "top";
          statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs ~/.config/i3status-rust/config-top.toml";
	  fonts = {
            names = [
	      "Iosevka"
	    ];
	    style = "Regular";
	    size = 12.0;
	  };
	  colors = {
            background = background;
            separator = "#aaaaaa";
          };
	  #settings = {
          #};
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
        icons = "awesome6";
	theme = "semi-native";
	settings = {
	  theme.overrides = {
            idle_fg = "#FFFFFF";
	    idle_bg = background;
	    #idle_bg = "#06060f";
	    #info_fg = "#89b4fa";
            #info_bg = "#00000000";
            #good_fg = "#a6e3a1";
            #good_bg = "#00000000";
            #warning_fg = "#fab387";
            #warning_bg = "#00000000";
            #critical_fg = "#f38ba8";
            #critical_bg = "#00000000";
            #separator = "\ue0b2";
	    #separator = "\uf0f3";
	    #separator = "\U+2190";
            separator_bg = background;
            separator_fg = "auto";
	    separator = " ";
	  };
	};
        blocks = [
	  #{
	  #  block = "cpu";
	  #  info_cpu = 20;
	  #  warning_cpu = 50;
	  #  critical_cpu = 90;
	  #}
	  {
	    block = "disk_space";
	    path = "/";
	    info_type = "available";
	    alert_unit = "GB";
	    interval = 20;
	    warning = 20;
	    alert = 10;
	    format = " $icon Root: $available.eng(w:2) ";
	  }
	  {
	    block = "memory";
	    format = " $icon $mem_total_used_percents.eng(w:2) ";
	    format_alt = " $icon_swap $swap_used_percents.eng(w:2) ";
	  }
	  {
	    block = "sound";
	    format = " $icon $volume ";
	  }
          {
            block = "time";
            interval = 5;
            #format = "%a %d %d/%m %k:%M %p";
	    format = " $icon $timestamp.datetime(f:'%a %m-%d-%y %r') ";
          }
        ];
      };
    };
  };
}
