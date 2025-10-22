{
  config,
  lib,
  ...
}: {
  imports = [
    ./dualboot.nix
    ./rpi.nix
  ];

  options.heffos.system.bootloader.enable = lib.mkEnableOption "a bootloader";

  config = lib.mkIf (config.heffos.system.bootloader.enable && !config.heffos.system.bootloader.dualboot.enable && !config.heffos.system.bootloader.rpi.enable) {
    boot.loader.systemd-boot.enable = true;
  };
}
