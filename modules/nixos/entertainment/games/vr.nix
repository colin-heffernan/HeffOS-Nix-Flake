{
  config,
  lib,
  pkgs,
  ...
}: {
  options.heffos.entertainment.games.vr = {
    enable = lib.mkEnableOption "VR support";
    wireless = lib.mkEnableOption "wireless VR support";
  };

  config = lib.mkIf config.heffos.entertainment.games.vr.enable (lib.mkMerge [
    {
      environment.systemPackages = with pkgs; [
        opencomposite
        wayvr
        android-tools
      ];
      services.monado = {
        enable = true;
        defaultRuntime = !config.heffos.entertainment.games.vr.wireless;
        highPriority = true;
      };
      systemd.user.services.monado.environment = {
        STEAMVR_LH_ENABLE = "1";
        XRT_COMPOSITOR_COMPUTE = "1";
      };
    }
    (lib.mkIf config.heffos.entertainment.games.vr.wireless {
      services.wivrn = {
        enable = true;
        defaultRuntime = true;
      };
    })
  ]);
}
