{
  config,
  lib,
  pkgs,
  ...
}: {
  options.heffos.environments.components.wallpapers.swaybg.enable = lib.mkEnableOption "SwayBG";

  config = lib.mkIf config.heffos.environments.components.wallpapers.swaybg.enable {
    systemd.user.services.swaybg = {
      description = "SwayBG user service";
      after = ["niri.service"];
      wantedBy = ["graphical-session.target"];
      serviceConfig = {
        ExecStart = "${pkgs.swaybg}/bin/swaybg -m fill -i %h/Pictures/desktop.png";
        Restart = "on-failure";
      };
    };
  };
}
