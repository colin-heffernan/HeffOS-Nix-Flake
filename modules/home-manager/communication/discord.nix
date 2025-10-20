{
  config,
  lib,
  pkgs,
  ...
}: {
  options.heffos-home.communication.discord.enable = lib.mkEnableOption "Discord";

  config = lib.mkIf config.heffos-home.communication.discord.enable {
    home.packages = with pkgs; [
      discord
    ];
  };
}
