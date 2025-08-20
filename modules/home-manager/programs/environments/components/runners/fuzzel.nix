{
  lib,
  osConfig,
  ...
}: {
  config = lib.mkIf osConfig.heffos.environments.components.runners.fuzzel.enable {
    programs.fuzzel.enable = true;
  };
}
