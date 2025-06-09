{
  config,
  lib,
  pkgs,
  ...
}: {
  options.heffos.system.pipewire.enable = lib.mkEnableOption "PipeWire";

  config = lib.mkIf config.heffos.system.pipewire.enable {
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
      jack.enable = true;
      pulse.enable = true;
    };
    environment.systemPackages = with pkgs; [
      alsa-utils
    ];
  };
}
