{lib, ...}: {
  imports = [
    ./emacs.nix
    ./helix.nix
    ./neovim.nix
  ];

  options.heffos.editors.default = lib.mkOption {
    type = lib.types.enum ["helix" "neovim"];
    description = "Which text editor to use by default.";
    default = null;
  };
}
