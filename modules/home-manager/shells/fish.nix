{
  config,
  lib,
  pkgs,
  ...
}: {
  options.heffos-home.shells.fish = {
    enable = lib.mkEnableOption "Fish Shell";
    default = lib.mkEnableOption "Fish as the default shell";
  };

  config = lib.mkIf config.heffos-home.shells.fish.enable {
    programs.fish = {
      enable = true;
      functions.fish_greeting = "";
      shellAbbrs = config.heffos-home.shells.aliases;
    };

    # TODO: Make this generic
    programs.bash.initExtra = lib.mkIf config.heffos.shells.fish.default ''
      if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
      then
        shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
        exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
      fi
    '';
  };
}
