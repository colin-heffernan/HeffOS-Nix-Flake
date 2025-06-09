{
  config,
  lib,
  ...
}: {
  options.heffos.system.bootloader.rpi = {
    enable = lib.mkEnableOption "the Raspberry Pi bootloader";
    version = lib.mkOption {
      type = lib.types.int;
      description = "Which version of the Raspberry Pi is being used.";
      default = 3;
    };
  };

  config = lib.mkIf config.heffos.system.bootloader.rpi.enable {
    boot.loader.raspberryPi = {
      enable = true;
      version = config.heffos.system.bootloader.rpi.version;
      uboot.enable = true;
    };
  };
}
