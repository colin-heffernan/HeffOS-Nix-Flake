{
  config,
  lib,
  osConfig,
  pkgs,
  ...
}: {
  options.heffos-home.utility.multimedia.music-production.enable = lib.mkEnableOption "music production utilities";

  config = lib.mkIf config.heffos-home.utility.multimedia.music-production.enable {
    home.packages = lib.mkMerge [
      (with pkgs; [
        reaper
        sfizz-ui
        vital
        surge-XT
        cardinal
        carla
        paulxstretch
        neural-amp-modeler-lv2
        dexed
      ])
      (lib.mkIf osConfig.heffos.compat.translation.enable (with pkgs; [
        yabridge
        yabridgectl
        wineWow64Packages.yabridge
      ]))
    ];
  };
}
