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
            "memory"
          ];
          modules-center = ["niri/workspaces"];
          modules-right = [
            "mpd"
            "tray"
            "clock"
          ];

          # Left modules
          "custom/logo" = {
            format = "";
          };
          "group/cpu-use" = {
            orientation = "inherit";
            modules = [
              "cpu"
              "cpu#usage-by-core"
            ];
            drawer = {
              transition-duration = 200;
            };
          };
          "cpu" = {
            interval = 5;
            format = "  {usage}%";
          };
          "cpu#usage-by-core" = {
            interval = 2;
            format = "{icon0}{icon1}{icon2}{icon3}{icon4}{icon5}{icon6}{icon7}{icon8}{icon9}{icon10}{icon11}";
            format-icons = ["▁" "▂" "▃" "▄" "▅" "▆" "▇" "█"];
          };
          "memory" = {
            format = "  {}%";
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
          "mpd" = {
            interval = 1;
            format = "󰝚  {artist} - {title} (from {album})";
          };
          "tray" = {
            spacing = 8;
          };
          "clock" = {
            interval = 5;
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
