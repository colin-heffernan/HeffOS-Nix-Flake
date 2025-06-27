{
  config,
  lib,
  pkgs,
  ...
}: {
  options.heffos.utility.fuzzy.enable = lib.mkEnableOption "fuzzy-finder utilities";

  config = lib.mkIf config.heffos.utility.fuzzy.enable {
    environment.systemPackages = with pkgs; [
      fzf
      television
    ];
  };
}
