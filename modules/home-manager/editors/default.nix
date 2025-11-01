{
  config,
  lib,
  ...
}: {
  imports = [
    ./emacs
    ./helix.nix
  ];

  options.heffos-home.editors.default = lib.mkOption {
    description = "Which editor to set as the default.";
    default = null;
    type = lib.types.nullOr (lib.types.enum ["helix" "emacs"]);
  };

  config = lib.mkMerge [
    (lib.mkIf (config.heffos-home.editors.default
      == "helix") {
      programs.helix.defaultEditor = true;
    })
    (lib.mkIf (config.heffos-home.editors.default
      == "emacs") {
      services.emacs.defaultEditor = true;
    })
  ];
}
