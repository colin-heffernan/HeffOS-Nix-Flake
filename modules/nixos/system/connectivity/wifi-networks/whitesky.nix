{
  config,
  lib,
  ...
}: {
  options.heffos.system.connectivity.wifi-networks.whitesky.enable = lib.mkEnableOption "WhiteSky";

  config = lib.mkIf config.heffos.system.connectivity.wifi-networks.whitesky.enable {
    networking.wireless.networks."WhiteSky-Hideaway".pskRaw = "${config.sops.placeholder.wifi.whitesky}";
  };
}
