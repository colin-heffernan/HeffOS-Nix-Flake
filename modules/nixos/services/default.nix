{
  imports = [
    ./mpd.nix
    ./nix-gc.nix
    ./polkit.nix
    ./usb-automount.nix
  ];

  # Enable DBus
  services.dbus = {
    enable = true;
    implementation = "broker";
  };

  # Enable and configure Sudo
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
