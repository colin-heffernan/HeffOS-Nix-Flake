{
  config,
  lib,
  ...
}: {
  options.heffos.shells.zsh.enable = lib.mkEnableOption "Z Shell";

  config = lib.mkIf config.heffos.shells.zsh.enable {
    programs.zsh = {
      enable = true;
      autosuggestions.enable = true;
      histFile = "$HOME/.config/zsh/histfile";
      shellAliases = config.heffos.shells.aliases;
      syntaxHighlighting.enable = true;
      vteIntegration = true;
    };
  };
}
