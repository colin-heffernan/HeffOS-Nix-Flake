{
  config,
  lib,
  pkgs,
  ...
}: {
  options.heffos-home.utility.ai.ollama.enable = lib.mkEnableOption "Ollama";

  config = lib.mkIf config.heffos-home.utility.ai.ollama.enable {
    services.ollama = {
      enable = true;
      package = pkgs.ollama-vulkan;
    };
  };
}
