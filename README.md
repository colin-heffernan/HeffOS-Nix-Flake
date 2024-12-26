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
- [ ] Use `sops-nix` to store passwords and other secrets
  - [ ] WiFi credentials
  - [ ] System user passwords
- [ ] Play nicer on Windows 11 dualboot setups
  - [ ] Show Windows 11 in the bootloader
  - [x] Sync clock time across both systems
  - [ ] Fix volume issue
  - [ ] If possible, get Bluetooth devices to work on both systems
- [ ] Configure programs through Home Manager
  - Browsers
    - [ ] Firefox
  - Editors
    - [x] Helix
    - [ ] Neovim
  - Environments
    - [ ] Hyprland
    - [ ] KDE Plasma 6
  - Terminal Emulators
    - [x] Kitty
    - [x] WezTerm
  - Utility
    - [x] Eza
    - [x] LF 
    - [ ] Zellij
- On drive re-format:
  - [ ] Automate BTRFS snapshots with BTRBK
  - [ ] Set up impermanence
  - [ ] Set up full-disk encryption
  - [ ] Set up UEFI Secure Boot with Lanzaboote

### Programs to Try:
- [ ] Nixd
- [ ] GRUB
- [ ] Plymouth
- [ ] Kvantum
- [x] Yazi
- [ ] Fzf
- [ ] GH
- [ ] Nushell
- [ ] Atuin
- [ ] Vivaldi
- [ ] Aerc
- [ ] Ghostty
  - Waiting for 1.0 release
- [ ] COSMIC DE
  - Waiting for 1.0 release

## Credits
While I wrote all of the code in this repository, HeffOS draws from other repositories:
- Fufexan's dotfiles repo ([Link](https://github.com/fufexan/dotfiles))
- Several of Vimjoyer's YouTube videos ([Link](https://www.youtube.com/channel/UC_zBdZ0_H_jn41FDRG7q4Tw))

## License
HeffOS is licensed under the [MIT License](./LICENSE).
