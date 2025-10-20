{
  lib,
  osConfig,
  ...
}: {
  config = lib.mkIf osConfig.heffos.environments.components.notifications.mako.enable {
    services.mako = {
      enable = true;
      settings = {
        font = "Iosevka Aile 12";
        default-timeout = 5000;
      };
    };
  };
}
