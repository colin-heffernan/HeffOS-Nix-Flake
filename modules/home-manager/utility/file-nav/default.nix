{lib, ...}: {
  imports = [
    ./android-file-transfer.nix
    ./broot.nix
    ./zoxide.nix
  ];

  options.heffos-home.utility.file-nav.enable = lib.mkEnableOption "file navigation utilities";
}
