{
  imports = [
    ./editors
    ./shells
    ./terminal-emulators
    ./utility
  ];

  programs.home-manager.enable = true;

  catppuccin = {
    accent = "blue";
    flavor = "mocha";
    btop.enable = true;
  };

  programs.git = {
    enable = true;
    userName = "Colin Heffernan";
    userEmail = "colinpheffernan@gmail.com";
  };
}
