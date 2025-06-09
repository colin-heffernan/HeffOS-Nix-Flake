{
  config,
  lib,
  pkgs,
  ...
}: {
  options.heffos.communication.discord.enable = lib.mkEnableOption "Discord";

  config = lib.mkIf config.heffos.communication.discord.enable {
    environment.systemPackages = with pkgs; [
      discord
    ];
  };
}
