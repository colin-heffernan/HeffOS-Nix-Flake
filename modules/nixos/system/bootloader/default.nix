{
  config,
  lib,
  ...
}: {
  imports = [
    ./dualboot.nix
    ./rpi.nix
  ];

  config = lib.mkIf (!config.heffos.system.bootloader.dualboot.enable && !config.heffos.system.bootloader.rpi.enable) {
    boot.loader.systemd-boot.enable = true;
  };
}
