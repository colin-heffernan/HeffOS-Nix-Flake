{
  config,
  lib,
  ...
}: {
  options.heffos-home.shells.bash.enable = lib.mkEnableOption "GNU BASH";

  config = lib.mkIf config.heffos-home.shells.fish.enable {
    programs.bash = {
      enable = true;
      shellAliases = config.heffos-home.shells.aliases;
    };
  };
}
