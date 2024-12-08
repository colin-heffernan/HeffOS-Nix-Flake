{
  config,
  lib,
  ...
}: {
  options.heffos.services.nix-gc.enable = lib.mkEnableOption "automatic garbage collection for Nix";

  config = lib.mkIf config.heffos.services.nix-gc.enable {
    nix.gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };
}
