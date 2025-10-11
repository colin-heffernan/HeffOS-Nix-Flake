{
  config,
  lib,
  ...
}: {
  options.heffos.system.bootloader.rpi.enable = lib.mkEnableOption "the Raspberry Pi bootloader";

  config = lib.mkIf config.heffos.system.bootloader.rpi.enable {
    boot.loader.generic-extlinux-compatible.enable = true;
    boot.loader.grub.enable = false;
  };
}
