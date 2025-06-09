{pkgs, ...}: {
  imports = [
    ./direnv.nix
    ./multimedia.nix
    ./no-tty.nix
    ./obsidian.nix
    ./tty.nix
  ];

  environment.systemPackages = with pkgs; [
    ripgrep
    fd
  ];
}
