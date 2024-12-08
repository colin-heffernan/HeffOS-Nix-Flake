{
  lib,
  osConfig,
  ...
}: {
  config = lib.mkIf osConfig.heffos.utility.no-tty.enable {
    home.file.".config/lf" = {
      source = ./df;
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
  };
}
