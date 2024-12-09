{
  lib,
  osConfig,
  ...
}: {
  imports = [
    ./helix.nix
  ];

  config = lib.mkMerge [
    (lib.mkIf (osConfig.heffos.editors.default == "helix") {
      programs.helix.defaultEditor = true;
    })
    (lib.mkIf (osConfig.heffos.editors.default == "neovim") {
      programs.neovim.defaultEditor = true;
    })
  ];
}
