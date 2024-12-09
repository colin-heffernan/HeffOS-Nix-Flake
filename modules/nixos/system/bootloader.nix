{
  config,
  lib,
  ...
}: {
  options.heffos.system.bootloader.dualboot.enable = lib.mkEnableOption "dualbooting in the bootloader";

  config = let
    mkIfElse = p: y: n:
      lib.mkMerge [
        (lib.mkIf p y)
        (lib.mkIf (!p) n)
      ];
  in
    lib.mkMerge [
      (mkIfElse config.heffos.system.bootloader.dualboot.enable {
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
