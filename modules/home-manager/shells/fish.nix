{
  lib,
  osConfig,
  ...
}: {
  config = lib.mkIf osConfig.heffos.shells.fish.enable {
    programs.fish = {
      enable = true;
      functions.fish_greeting = "";
    };
  };
}
