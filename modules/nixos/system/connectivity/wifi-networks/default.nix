{
  config,
  lib,
  ...
}: {
  imports = [
    ./a12.nix
    ./whitesky.nix
  ];

  config = lib.mkIf (config.heffos.system.connectivity.wifi-networks.a12.enable || config.heffos.system.connectivity.wifi-networks.whitesky.enable) {
    networking.wireless = {
      enable = true;
      secretsFile = "${config.heffos.config-dir}/secrets/wireless.conf";
    };
  };
}
