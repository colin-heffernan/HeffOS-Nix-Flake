{
  config,
  lib,
  ...
}: {
  options.heffos.utility.direnv.enable = lib.mkEnableOption "Direnv";

  config = lib.mkIf config.heffos.utility.direnv.enable {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
