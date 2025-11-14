{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.heffos-home.utility.multimedia.enable {
    programs.beets = {
      enable = true;
      mpdIntegration.enableUpdate = true;
      settings = {
        directory = "${config.home.homeDirectory}/Music";
        library = "${config.home.homeDirectory}/beets.db";
        plugins = [
          "fetchart"
          "embedart"
          "convert"
          "musicbrainz"
        ];
        fetchart = {
          auto = "yes";
        };
        embedart = {
          auto = "yes";
        };
      };
    };
  };
}
