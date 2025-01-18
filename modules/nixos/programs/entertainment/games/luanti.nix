{
  config,
  lib,
  pkgs,
  ...
}: {
  options.heffos.entertainment.games.luanti.enable = lib.mkEnableOption "Luanti (formerly Minetest)";

  config = lib.mkIf config.heffos.entertainment.games.luanti.enable {
    environment.systemPackages = with pkgs; [
      luanti-client
    ];
  };
}
