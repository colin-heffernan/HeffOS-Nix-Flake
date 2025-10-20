{
  config,
  lib,
  osConfig,
  ...
}: {
  imports = [
    ./fish.nix
  ];

  options.heffos-home.shells.aliases = lib.mkOption {
    type = lib.types.attrs;
    description = "List of shell aliases to use.";
    default = {
      sup = "sudo nixos-rebuild switch --flake ${osConfig.heffos.config-dir}#${osConfig.networking.hostName}";
      fup = "nix flake update";
    };
  };

  config = lib.mkIf (config.heffos-home.shells.fish.enable) {
    programs.starship = {
      enable = true;
      enableTransience =
        if config.heffos-home.shells.fish.enable
        then true
        else false;
      settings = {
        add_newline = false;
        format = lib.concatStrings [
          "$line_break"
          "$nix_shell"
          "$line_break"
          "$directory"
          "$shell"
          "$character"
        ];
        nix_shell = {
          format = "In [$state]($style)[Nix Shell.]($style)";
          impure_msg = "impure ";
          pure_msg = "pure ";
          unknown_msg = "";
        };
        shell = {
          disabled = false;
          bash_indicator = "Bash";
          fish_indicator = "Fish";
          style = "blue bold";
          format = "via [$indicator]($style) ";
        };
      };
    };
  };
}
