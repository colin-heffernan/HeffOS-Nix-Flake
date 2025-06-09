{
  config,
  lib,
  ...
}: {
  options.heffos.system.bootloader.dualboot.enable = lib.mkEnableOption "a dualboot-compatible bootloader via GRUB and os-prober";

  config = lib.mkIf config.heffos.system.bootloader.dualboot.enable {
    boot.loader.grub = {
      enable = true;
      devices = ["nodev"];
      efiSupport = true;
      useOSProber = true;
    };
  };
}
