{
  config,
  lib,
  ...
}: {
  options.heffos.system.connectivity.wifi-networks.eduroam.enable = lib.mkEnableOption "Eduroam";

  config = lib.mkIf config.heffos.system.connectivity.wifi-networks.eduroam.enable {
    networking.wireless.networks."eduroam" = {
      auth = ''
        proto=RSN
        key_mgmt=WPA-EAP
        eap=PEAP
        phase1="peaplabel=0 tls_ext_cert_check=0"
        phase2="auth=MSCHAPV2"
        identity="colinheffernan@ufl.edu"
        password=ext:EDUROAM_PASSWORD
      '';
      authProtocols = ["WPA-EAP"];
    };
  };
}
