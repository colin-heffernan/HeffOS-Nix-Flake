{
  config,
  lib,
  pkgs,
  ...
}: {
  options.heffos.system.connectivity.tailscale.enable = lib.mkEnableOption "Tailscale";

  config = lib.mkIf config.heffos.system.connectivity.tailscale.enable {
    services.tailscale.enable = true;
    environment.systemPackages = with pkgs; [
      tailscale
    ];
    systemd.services.tailscale-autoconnect = {
      description = "Automatic connection to Tailscale";
      after = ["network-pre.target" "tailscale.service"];
      wants = ["network-pre.target" "tailscale.service"];
      wantedBy = ["multi-user.target"];
      serviceConfig.Type = "oneshot";
      script = with pkgs; ''
        sleep 2
        status="$(${tailscale}/bin/tailscale status -json | ${jq}/bin/jq -r .BackendState)"
        if [ $status = "Running" ]; then
          exit 0
        fi
        ${tailscale}/bin/tailscale up -authkey "$(cat ${config.sops.secrets.tailscale_key.path})"
      '';
    };
    networking.firewall = {
      enable = true;
      trustedInterfaces = ["tailscale0"];
      allowedUDPPorts = [config.services.tailscale.port];
    };
  };
}
