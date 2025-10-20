{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.heffos-home.utility.multimedia.enable {
    programs.beets = {
      enable = true;
      settings = {
        directory = "${config.home.homeDirectory}/Music";
        library = "${config.home.homeDirectory}/beets.db";
      };
    };
  };
}
