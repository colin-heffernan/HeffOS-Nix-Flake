{
  lib,
  osConfig,
  ...
}: {
  imports = [
    ./fish.nix
    ./zsh.nix
  ];

  config = lib.mkIf (osConfig.heffos.shells.fish.enable || osConfig.heffos.shells.zsh.enable) {
    programs.starship = {
      enable = true;
      enableTransience =
        if osConfig.heffos.shells.fish.enable
        then true
        else false;
      settings = {
        add_newline = false;
        format = lib.concatStrings [
          "$line_break"
          "$nix_shell"
          "$line_break"
          "$directory"
          "$character"
        ];
        nix_shell = {
          format = "In [$state]($style)[Nix Shell.]($style)";
          impure_msg = "impure ";
          pure_msg = "pure ";
          unknown_msg = "";
        };
      };
    };
  };
}
