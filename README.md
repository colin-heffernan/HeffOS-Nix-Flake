# HeffOS
HeffOS is a Nix flake containing a number of system setups and packages.
It's designed to be modular, making it easier to add or remove programs or to create new systems.

## Libraries
HeffOS uses a number of libraries to achieve various features:
- Nixpkgs
  - This one is mostly obvious, but there are actually *three* branches of Nixpkgs in HeffOS: latest stable, unstable, and my personal fork
  - There is also the NUR, in the case that I need something that's not in Nixpkgs
- Home Manager
  - This one is also pretty widely used; I use it to configure programs on a per-user basis
  - There is also Plasma Manager, which allows for KDE Plasma to be configured via Home Manager
- Flake Parts
  - This one is for non-host derivations that can be used across architectures, such as packages or shells
- Catppuccin
  - This one themes a *ton* of programs

## Hosts
| Host   | Purpose                                                    |
|--------|------------------------------------------------------------|
| Hitori | My personal computer, which dualboots NixOS and Windows 11 |

(Yes, the systems are, and will continue to be, named after characters from [*Bocchi the Rock!*](https://en.wikipedia.org/wiki/Bocchi_the_Rock%21))

## To-Do
- Play nicer on Windows 11 dualboot setups
  - Fix volume issue
- Set up new features on drive re-format
  - Automate BTRFS snapshots with BTRBK
  - Set up impermanence?
  - Set up full-disk encryption?
  - Set up UEFI Secure Boot?
- Establish new system configurations
  - Raspberry Pi 3B+ "Ikuyo"
  - WSL2 on tower "Futari"
  - WSL2 on laptop "Ryo"
- Support my Quest 3
- Enable building ISOs and WSL images
- Replace SDDM
- Migrate to GNU GuixSD?

## Credits
While I wrote all of the code in this repository, some code is adapted (and many concepts are borrowed) from other repositories:
- Fufexan's dotfiles repo ([Link](https://github.com/fufexan/dotfiles))
- Several of Vimjoyer's YouTube videos ([Link](https://www.youtube.com/channel/UC_zBdZ0_H_jn41FDRG7q4Tw))

## License
HeffOS is licensed under the [MIT License](./LICENSE).
