{
  lib,
  osConfig,
  ...
}: {
  config = lib.mkIf osConfig.heffos.utility.no-tty.enable {
    programs.eza = {
      enable = true;
      colors = "always";
      extraOptions = [
        "-la"
        "--group-directories-first"
      ];
      icons = "always";
    };
  };
}
