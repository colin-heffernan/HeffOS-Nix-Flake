{
  config,
  lib,
  ...
}: {
  imports = [
    ./a12.nix
    ./eduroam.nix
  ];

  config = lib.mkIf (config.heffos.system.connectivity.wifi-networks.a12.enable || config.heffos.system.connectivity.wifi-networks.eduroam.enable) {
    networking.wireless = {
      enable = true;
      # FIXME: Fix `sops-nix` and set secretsFile to `config.sops.secrets."wireless.conf".path`
      secretsFile = "/home/colin/Repos/HeffOS-Nix-Flake/secrets/wireless.conf";
    };
  };
}