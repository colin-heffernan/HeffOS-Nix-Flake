{
  config,
  lib,
  pkgs,
  ...
}: {
  options.heffos.environments.desktop-environments.cosmic.enable = lib.mkEnableOption "COSMIC DE";

  config = lib.mkIf config.heffos.environments.desktop-environments.cosmic.enable {
    services.desktopManager.cosmic.enable = true;

    # Prevent GNOME's SSH agent from interfering with `ssh-agent`
    services.gnome.gcr-ssh-agent.enable = false;
  };
}
