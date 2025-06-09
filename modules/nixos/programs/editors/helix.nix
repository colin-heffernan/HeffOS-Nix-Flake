{
  config,
  lib,
  pkgs,
  ...
}: {
  options.heffos.editors.helix.enable = lib.mkEnableOption "Helix";

  config = lib.mkIf config.heffos.editors.helix.enable {
    environment.systemPackages = with pkgs; [
      helix
    ];
  };
}
