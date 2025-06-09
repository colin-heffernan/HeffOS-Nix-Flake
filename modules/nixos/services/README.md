# `modules/nixos/services`
This directory contains modules.
- `default.nix` contains the module to control services I will always use
- `mpd.nix` contains the module to control the Music Player Daemon (MPD)
  - This module is currently deprecated, and I am only porting it to bring over my old configuration
- `nix-gc.nix` contains the module to control Nix automatic garbage collection
- `polkit.nix` contains the module to control Polkit
