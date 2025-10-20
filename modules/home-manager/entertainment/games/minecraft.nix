{
  config,
  lib,
  pkgs,
  ...
}: {
  options.heffos-home.entertainment.games.minecraft = {
    enable = lib.mkEnableOption "Minecraft (via Prism Launcher)";
    jdks = lib.mkOption {
      type = lib.types.listOf lib.types.package;
      description = "List of JDK versions to use.";
      default = with pkgs; [
        jdk21
        jdk17
        jdk8
      ];
    };
  };

  config = lib.mkIf config.heffos-home.entertainment.games.minecraft.enable {
    home.packages = with pkgs; [
      (prismlauncher.override {
        jdks = config.heffos-home.entertainment.games.minecraft.jdks;
      })
    ];
  };
}
