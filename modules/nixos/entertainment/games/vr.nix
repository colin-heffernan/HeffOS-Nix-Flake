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
        wlx-overlay-s
      ];
    }
    (lib.mkIf (!config.heffos.entertainment.games.vr.wireless) {
      services.monado = {
        enable = true;
        defaultRuntime = true;
        highPriority = true;
      };
      systemd.user.services.monado.environment = {
        STEAMVR_LH_ENABLE = "1";
        XRT_COMPOSITOR_COMPUTE = "1";
      };
    })
    (lib.mkIf config.heffos.entertainment.games.vr.wireless {
      services.wivrn = {
        enable = true;
        defaultRuntime = true;
      };
    })
  ]);
}
