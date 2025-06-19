{
  config,
  lib,
  pkgs,
  ...
}: {
  options.heffos.environments.components.runners.fuzzel.enable = lib.mkEnableOption "Fuzzel";

  config = lib.mkIf config.heffos.environments.components.runners.fuzzel.enable {
    environment.systemPackages = with pkgs; [
      fuzzel
    ];
  };
}
