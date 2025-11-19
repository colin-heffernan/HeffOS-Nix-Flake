{
  config,
  lib,
  ...
}: {
  options.heffos.system.connectivity.wifi-networks.a12.enable = lib.mkEnableOption "A12";

  config = lib.mkIf config.heffos.system.connectivity.wifi-networks.a12.enable {
    networking.wireless.networks."a12".pskRaw = "${config.sops.placeholder.wifi.a12}";
  };
}
