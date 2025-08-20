{
  config,
  lib,
  pkgs,
  ...
}: {
  options.heffos.shells.fish = {
    enable = lib.mkEnableOption "Fish Shell";
    default = lib.mkEnableOption "Fish as the default shell";
  };

  config = lib.mkIf config.heffos.shells.fish.enable {
    programs.fish = {
      enable = true;
      shellAbbrs = config.heffos.shells.aliases;
    };
    programs.bash.interactiveShellInit = lib.mkIf config.heffos.shells.fish.default ''
          if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
          then
            shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
            exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
          fi
    '';
  };
}
