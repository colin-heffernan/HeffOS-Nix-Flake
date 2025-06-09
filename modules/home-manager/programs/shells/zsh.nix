{
  lib,
  osConfig,
  ...
}: {
  config = lib.mkIf osConfig.heffos.shells.zsh.enable {
    programs.zsh.enable = true;
  };
}
