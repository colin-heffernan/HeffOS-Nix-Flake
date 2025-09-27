{
  lib,
  ...
}: {
  imports = [
    ./programs
    ./services
    ./system
    ./theme
  ];
  
  options.heffos.config-dir = lib.mkOption {
    type = lib.types.path;
    description = "The directory that contains the HeffOS flake.";
  };
}
