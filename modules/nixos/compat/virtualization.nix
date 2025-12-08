{
  config,
  lib,
  pkgs,
  ...
}: {
  options.heffos.compat.virtualization.enable = lib.mkEnableOption "virtualization software";

  config = lib.mkIf config.heffos.compat.virtualization.enable {
    virtualisation = {
      libvirtd = {
        enable = true;
        qemu.swtpm.enable = true;
      };
      spiceUSBRedirection.enable = true;
    };
    programs.virt-manager.enable = true;
    environment.systemPackages = with pkgs; [
      virtio-win
    ];
    networking.firewall.trustedInterfaces = ["virbr0"];
  };
}
