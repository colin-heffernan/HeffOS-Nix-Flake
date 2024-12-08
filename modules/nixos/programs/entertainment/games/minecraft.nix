{
  config,
  lib,
  pkgs,
  ...
}: {
  options.heffos.entertainment.games.minecraft = {
    enable = lib.mkEnableOption "Prism Launcher";
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

  config = lib.mkIf config.heffos.entertainment.games.minecraft.enable {
    environment.systemPackages = with pkgs; [
      (prismlauncher.override {
        jdks = config.heffos.entertainment.games.minecraft.jdks;
      })
    ];
  };
}
