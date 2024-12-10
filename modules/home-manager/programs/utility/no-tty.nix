{
  lib,
  osConfig,
  ...
}: {
  config = lib.mkIf osConfig.heffos.utility.no-tty.enable {
    home.file.".config/lf" = {
      source = ./lf;
      recursive = true;
    };

    programs.pistol = {
      enable = true;
      associations = [
        {
          mime = "text/*";
          command = "cat %pistol-filename%";
        }
      ];
    };

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
