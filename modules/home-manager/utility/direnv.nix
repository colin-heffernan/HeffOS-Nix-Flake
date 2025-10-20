{
  config,
  lib,
  ...
}: {
  options.heffos-home.utility.direnv.enable = lib.mkEnableOption "Direnv";

  config = lib.mkIf config.heffos-home.utility.direnv.enable {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
