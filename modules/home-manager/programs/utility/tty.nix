{
  lib,
  osConfig,
  ...
}: {
  config = lib.mkIf osConfig.heffos.utility.tty.enable {
    home.file.".config/zellij" = {
      source = ./zellij;
      recursive = true;
    };
  };
}
