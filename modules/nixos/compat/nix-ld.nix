{
  config,
  lib,
  ...
}: {
  options.heffos.compat.nix-ld.enable = lib.mkEnableOption "Nix-LD";

  config = lib.mkIf config.heffos.compat.nix-ld.enable {
    programs.nix-ld.enable = true;
  };
}
