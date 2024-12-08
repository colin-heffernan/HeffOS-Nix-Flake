{
  config,
  lib,
  pkgs,
  ...
}: {
  options.heffos.communication.matrix = {
    enable = lib.mkEnableOption "a Matrix client";
    package = lib.mkOption {
      type = lib.types.package;
      description = "Matrix client to use.";
      default = pkgs.element-desktop;
    };
  };

  config = lib.mkIf config.heffos.communication.matrix.enable {
    environment.systemPackages = [config.heffos.communication.matrix.package];
  };
}
