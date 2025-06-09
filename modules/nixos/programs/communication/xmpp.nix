{
  config,
  lib,
  pkgs,
  ...
}: {
  options.heffos.communication.xmpp.enable = lib.mkEnableOption "a XMPP client";

  config = lib.mkIf config.heffos.communication.xmpp.enable {
    environment.systemPackages = with pkgs; [
      profanity
    ];
  };
}
