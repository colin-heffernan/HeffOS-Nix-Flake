{
  lib,
  osConfig,
  ...
}: {
  config = lib.mkIf osConfig.heffos.environments.components.bars.waybar.enable {
    programs.waybar = {
      enable = true;
      settings = {
        primary-bar = {
          # Whole bar
          layer = "top";
          position = "top";
          margin-left = 16;
          margin-top = 16;
          margin-right = 16;
          spacing = 16;
          output = ["DP-3"];
          modules-left = [
            "custom/logo"
            "group/cpu-use"
            "group/mem-use"
          ];
          modules-center = ["niri/workspaces"];
          modules-right = [
            "group/mpris-widget"
            "tray"
            "group/clock-widget"
          ];

          # Left modules
          "custom/logo" = {
            format = "";
            tooltip = false;
          };
          "group/cpu-use" = {
            orientation = "inherit";
            modules = [
              "group/cpu-thumbnail"
              "cpu#usage-by-core"
            ];
            drawer = {
              transition-duration = 200;
            };
          };
          "group/cpu-thumbnail" = {
            orientation = "inherit";
            modules = [
              "custom/cpu-logo"
              "cpu"
            ];
          };
          "custom/cpu-logo" = {
            format = "";
            tooltip = false;
          };
          "cpu" = {
            interval = 5;
            format = "{usage}%";
            tooltip = false;
          };
          "cpu#usage-by-core" = {
            interval = 2;
            format = "{icon0}{icon1}{icon2}{icon3}{icon4}{icon5}{icon6}{icon7}{icon8}{icon9}{icon10}{icon11}";
            format-icons = ["▁" "▂" "▃" "▄" "▅" "▆" "▇" "█"];
            tooltip = false;
          };
          "group/mem-use" = {
            orientation = "inherit";
            modules = [
              "custom/mem-logo"
              "memory"
            ];
          };
          "custom/mem-logo" = {
            format = "";
            tooltip = false;
          };
          "memory" = {
            format = "{}%";
            tooltip = false;
          };

          # Center modules
          "niri/workspaces" = {
            format = "{icon}";
            format-icons = {
              active = "●";
              default = "○";
            };
            disable-click = true;
          };

          # Right modules
          "group/mpris-widget" = {
            orientation = "inherit";
            modules = [
              "group/mpris-thumbnail"
              "mpris"
            ];
            drawer = {
              transition-duration = 200;
            };
          };
          "group/mpris-thumbnail" = {
            orientation = "inherit";
            modules = [
              "custom/mpris-logo"
              "mpris#player-status"
            ];
          };
          "custom/mpris-logo" = {
            format = "󰝚";
            tooltip = false;
          };
          "mpris#player-status" = {
            format = "󰓛";
            format-paused = "󰏤";
            format-playing = "󰐊";
            format-stopped = "󰓛";
            ignored-players = [
              "firefox.instance_1_37"
              "firefox"
            ];
            tooltip = false;
          };
          "mpris" = {
            format = "{artist} - {title} (from <i>{album}</i>)";
            ignored-players = [
              "firefox.instance_1_37"
              "firefox"
            ];
            # player-icons = {
            #   mpd = "󰗀";
            #   spotify = "󰓇";
            # };
            tooltip = false;
          };
          "tray" = {
            spacing = 8;
            tooltip = false;
          };
          "group/clock-widget" = {
            orientation = "inherit";
            modules = [
              "group/clock-widget-thumbnail"
              "group/clock-date-widget"
            ];
            drawer = {
              transition-duration = 200;
            };
          };
          "group/clock-widget-thumbnail" = {
            orientation = "inherit";
            modules = [
              "custom/clock-logo"
              "clock"
            ];
          };
          "custom/clock-logo" = {
            format = "󰥔";
            tooltip = false;
          };
          "clock" = {
            interval = 5;
            tooltip = false;
          };
          "group/clock-date-widget" = {
            orientation = "inherit";
            modules = [
              "custom/clock-date-logo"
              "clock#date"
            ];
          };
          "custom/clock-date-logo" = {
            format = "󰃭";
            tooltip = false;
          };
          "clock#date" = {
            interval = 5;
            format = "{:%m/%d}";
            tooltip = false;
          };
        };
      };
      style = builtins.readFile ./style.css;
      systemd = {
        enable = true;
        target = "niri.service";
      };
    };
  };
}
