{
  config,
  lib,
  ...
}: {
  options.heffos.system.zram.enable = lib.mkEnableOption "swap on ZRAM";

  config = lib.mkIf config.heffos.system.zram.enable {
    zramSwap.enable = true;
  };
}
