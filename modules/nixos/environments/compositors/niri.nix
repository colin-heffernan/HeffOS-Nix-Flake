{
  config,
  lib,
  pkgs,
  ...
}: {
  options.heffos.environments.compositors.niri.enable = lib.mkEnableOption "Niri";

  config = lib.mkIf config.heffos.environments.compositors.niri.enable {
    programs.niri.enable = true;

    # Prevent GNOME's SSH agent from interfering with `ssh-agent`
    services.gnome.gcr-ssh-agent.enable = false;

    # Set icons
    xdg.icons = {
      enable = true;
      fallbackCursorThemes = lib.mkDefault [
        "Posy_Cursor_Black"
      ];
    };

    environment.systemPackages = with pkgs; [
      xwayland-satellite
      wl-clipboard
      posy-cursors
    ];
  };
}
