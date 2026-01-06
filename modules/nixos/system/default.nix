{
  config,
  inputs,
  lib,
  ...
}: {
  imports = [
    ./bootloader
    ./connectivity
    ./fonts.nix
    ./hardware-acceleration.nix
    ./nix-gc.nix
    ./pipewire.nix
    ./polkit.nix
    ./powersave.nix
    ./printing.nix
    ./usb-automount.nix
    ./zram.nix
  ];

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
    earlySetup = true;
  };

  nix = {
    # package = pkgs.lix;
    registry = let
      flakeInputs = lib.filterAttrs (_: v: lib.isType "flake" v) inputs;
    in
      lib.mapAttrs (_: v: {flake = v;}) flakeInputs;
    nixPath = lib.mapAttrsToList (key: _: "${key}=flake:${key}") config.nix.registry;
    settings = {
      trusted-users = ["@wheel"];
      experimental-features = ["nix-command" "flakes"];
      accept-flake-config = false;
    };
  };

  services.dbus = {
    enable = true;
    implementation = "broker";
  };

  security.sudo = {
    enable = true;
    extraRules = [
      {
        commands = ["ALL"];
        groups = ["wheel"];
      }
    ];
  };
}
