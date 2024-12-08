{
  config,
  lib,
  ...
}: {
  options.heffos.services.pipewire.enable = lib.mkEnableOption "PipeWire";

  config = lib.mkIf config.heffos.services.pipewire.enable {
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
  };
}
