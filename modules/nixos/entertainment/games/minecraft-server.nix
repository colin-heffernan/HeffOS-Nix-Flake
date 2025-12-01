{
  config,
  lib,
  pkgs,
  ...
}: {
  options.heffos.entertainment.games.minecraft-server.enable = lib.mkEnableOption "a Minecraft server";

  config = lib.mkIf config.heffos.entertainment.games.minecraft-server.enable {
    services.minecraft-server = {
      enable = true;
      eula = true;
      declarative = true;
      serverProperties = {
        server-port = 42099;
        difficulty = 1;
        gamemode = 1;
        motd = "liaserver";
        allow-cheats = true;
      };
      package = pkgs.minecraftServers.fabric-1_20_1;
    };
  };
}
