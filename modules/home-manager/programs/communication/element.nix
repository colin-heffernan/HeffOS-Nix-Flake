{
  config,
  lib,
  ...
}: {
  options.heffos-home.communication.element.enable = lib.mkEnableOption "Element, a Matrix client";

  config = lib.mkIf config.heffos-home.communication.element.enable {
    programs.element-desktop.enable = true;
  };
}
