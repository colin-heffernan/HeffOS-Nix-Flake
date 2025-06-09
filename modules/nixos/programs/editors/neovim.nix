{
  config,
  lib,
  ...
}: {
  options.heffos.editors.neovim.enable = lib.mkEnableOption "Neovim";

  config = lib.mkIf config.heffos.editors.neovim.enable {
    programs.neovim.enable = true;
  };
}
