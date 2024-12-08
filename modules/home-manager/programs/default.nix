{
  imports = [
    ./editors
    ./shells
    ./terminal-emulators
    ./utility
  ];

  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    userName = "Colin Heffernan";
    userEmail = "colinpheffernan@gmail.com";
  };
}
