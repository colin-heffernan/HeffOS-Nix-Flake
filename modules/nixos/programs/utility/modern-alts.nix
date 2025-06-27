{
  config,
  lib,
  pkgs,
  ...
}: {
  options.heffos.utility.modern-alts.enable = lib.mkEnableOption "modern alternatives to standard utilities";

  config = lib.mkIf config.heffos.utility.modern-alts.enable {
    environment.systemPackages = with pkgs; [
      bat
      eza
      delta
    ];
  };
}
