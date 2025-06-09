{
  config,
  lib,
  pkgs,
  ...
}: {
  options.heffos.browsers.vivaldi = {
    enable = lib.mkEnableOption "Vivaldi";
    enablePlasma6Support = lib.mkEnableOption "KDE Plasma 6 support for Vivaldi";
  };

  config = let
    mkIfElse = p: y: n:
      lib.mkMerge [
        (lib.mkIf p y)
        (lib.mkIf (!p) n)
      ];
  in
    lib.mkIf config.heffos.browsers.vivaldi.enable (mkIfElse config.heffos.browsers.vivaldi.enablePlasma6Support {
        environment.systemPackages = with pkgs; [
          (vivaldi.overrideAttrs (oldAttrs: {
            dontWrapQtApps = false;
            dontPatchELF = true;
            nativeBuildInputs = oldAttrs.nativeBuildInputs ++ [pkgs.kdePackages.wrapQtAppsHook];
          }))
        ];
      } {
        environment.systemPackages = with pkgs; [
          vivaldi
        ];
      });
}
