{
  config,
  lib,
  pkgs,
  ...
}: {
  options.heffos.communication.xmpp = {
    enable = lib.mkEnableOption "a XMPP client";
    package = lib.mkOption {
      type = lib.types.package;
      description = "XMPP client to use.";
      default = pkgs.profanity;
    };
  };

  config = lib.mkIf config.heffos.communication.xmpp.enable {
    environment.systemPackages = [config.heffos.communication.xmpp.package];
  };
}
