{
	description = "Obsi's system configuration";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		hyprland = {
			url = "github:hyprwm/hyprland";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		eww = {
			url = "github:elkowar/eww";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		discord = {
			type = "tarball";
			url = "https://discord.com/api/download/stable?platform=linux&format=tar.gz";
			flake = false;
		};
		nvcode = {
			url = "github:colin-heffernan/NVCode-Flake";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		emcore = {
			url = "github:colin-heffernan/EMCore";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		# emacs-overlay = {
		# 	url = "github:nix-community/emacs-overlay";
		# 	inputs.nixpkgs.follows = "nixpkgs";
		# };
	};

	outputs = { self, nixpkgs, home-manager, hyprland, eww, discord, nvcode, emcore, ... }@inputs:
		let
			system = "x86_64-linux";
			pkgs = import nixpkgs {
				inherit system;
				config.allowUnfree = true;
				overlays = [
					nvcode.overlays.default
					emcore.overlays.default
					# emacs-overlay.overlay
					(final: prev: {
						nix-direnv = prev.nix-direnv.override { enableFlakes = true; };
						eww-wayland = eww.packages.${prev.system}.eww-wayland;
						discord = prev.discord.overrideAttrs (
							_: { src = inputs.discord; }
						);
						# lmms = prev.lmms.overrideAttrs (
						# 	oldAttrs: {
						# 		buildInputs = oldAttrs.buildInputs ++ [ pkgs.wine ];
						# 		cmakeFlags = oldAttrs.cmakeFlags ++ [ "-DWANT_VST=ON" "-DWANT_VST_32=ON" "-DWANT_VST_64=ON" ];
						# 	}
						# );
					})
				];
			};
			lib = nixpkgs.lib;
		in {
			nixosConfigurations = {
				heffos-obsidian = lib.nixosSystem {
					inherit system pkgs;
					modules = [
						hyprland.nixosModules.default
						./configuration.nix
						home-manager.nixosModules.home-manager
						{
							home-manager.useGlobalPkgs = true;
							home-manager.useUserPackages = false;
							home-manager.users.obsi = import ./home.nix;
						}
					];
				};
			};
		};
}
