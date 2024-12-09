{lib, ...}: {
  imports = [
    ./helix.nix
    ./neovim.nix
  ];

  options.heffos.editors.default = lib.mkOption {
    type = lib.types.str;
    description = "Which text editor to use by default.";
    default = null;
  };
}
