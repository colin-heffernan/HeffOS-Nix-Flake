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

    environment.systemPackages = with pkgs; [
      xwayland-satellite
      wl-clipboard
    ];
  };
}
