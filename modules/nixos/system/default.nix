{
  imports = [
    ./bootloader
    ./connectivity
    ./fonts.nix
    ./hardware-acceleration.nix
    ./pipewire.nix
    ./powersave.nix
    ./zram.nix
  ];

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
    earlySetup = true;
  };
}
