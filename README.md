# HeffOS
HeffOS is a Nix flake containing a number of system setups and packages.
It's designed to be modular, making it easier to add or remove programs or to create new systems.

## Libraries
HeffOS uses a number of libraries to achieve various features:
- Nixpkgs
  - This one is mostly obvious, but there are actually *three* branches of Nixpkgs in HeffOS: unstable, latest stable, and my personal fork
- Home Manager
  - This one is also pretty widely used; I use it to configure programs on a per-user basis
- Flake Parts
  - This one is for non-host derivations that can be used across architectures, such as packages or shells
- Sops-Nix
  - This one is to store secrets

## Hosts
| Host | Purpose |
|-|-|
| Hitori | My personal computer, which dualboots NixOS and Windows 11 |

(Yes, the systems are, and will continue to be, named after characters from [*Bocchi the Rock!*](https://en.wikipedia.org/wiki/Bocchi_the_Rock%21))

## To-Do
- Use `sops-nix` to store passwords and other secrets (WiFi credentials, system user passwords, etc.)
- Play nicer on Windows 11 dualboot setups
  - [x] Sync clock time across both systems
  - Fix volume issue
  - If possible, get Bluetooth devices to work on both systems
- Configure GRUB
- Configure programs through Home Manager
  - Browsers
    - Brave
    - Firefox
    - Vivaldi
  - Editors
    - Helix (add Nixd support)
    - Neovim
  - Environments
    - Hyprland
    - KDE Plasma 6
  - Terminal Emulators
    - Ghostty
  - Utility
    - Zellij
- Set up new features on drive re-format
  - Automate BTRFS snapshots with BTRBK
  - Set up impermanence (https://github.com/nix-community/impermanence)
  - Set up full-disk encryption
  - Set up UEFI Secure Boot with Lanzaboote (https://github.com/nix-community/lanzaboote)

### Programs to Try:
- Nixd
- Plymouth
- Greetd
- Some form of trash utility (`trash-cli` or some equivalent)
- Bottom (would replace Btop)
- Kvantum
- Fzf
- GH
- Nushell
- Atuin
- Ungoogled Chromium
- Vivaldi
- Aerc
- Ghostty (waiting for it to be packaged in Nixpkgs)
- COSMIC DE (waiting for 1.0 to release and be packaged in Nixpkgs)

## Credits
While I wrote all of the code in this repository, HeffOS draws from other repositories:
- Fufexan's dotfiles repo ([Link](https://github.com/fufexan/dotfiles))
- Several of Vimjoyer's YouTube videos ([Link](https://www.youtube.com/channel/UC_zBdZ0_H_jn41FDRG7q4Tw))

## License
HeffOS is licensed under the [MIT License](./LICENSE).
