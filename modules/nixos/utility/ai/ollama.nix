{
  config,
  lib,
  pkgs,
  ...
}: {
  options.heffos.utility.ai.ollama.enable = lib.mkEnableOption "Ollama";

  config = lib.mkIf config.heffos.utility.ai.ollama.enable {
    services.ollama = {
      enable = true;
      acceleration = "rocm";
      rocmOverrideGfx = "10.3.0";
    };
  };
}
