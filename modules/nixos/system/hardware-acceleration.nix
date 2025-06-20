{
  config,
  lib,
  pkgs,
  ...
}: {
  options.heffos.system.hardware-acceleration.enable = lib.mkEnableOption "hardware acceleration";

  config = lib.mkIf config.heffos.system.hardware-acceleration.enable {
    hardware.graphics = {
      enable = true;
      enable32Bit = true;
      extraPackages = with pkgs; [
        rocmPackages.clr.icd
      ];
    };
  };
}
