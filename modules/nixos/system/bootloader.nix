{
  config,
  lib,
  ...
}: {
  options.heffos.system.bootloader.dualboot.enable = lib.mkEnableOption "dualbooting in the bootloader";

  config = lib.mkMerge [
    (lib.mkIfElse config.heffos.system.bootloader.dualboot.enable {
        boot.loader.grub = {
          enable = true;
          devices = ["nodev"];
          efiSupport = true;
          useOSProber = true;
        };
      } {
        boot.loader.systemd-boot.enable = true;
      })
    {
      boot.loader.efi.canTouchEfiVariables = true;
    }
  ];
}
