{
	description = "Obsi's system configuration";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		hyprland = {
			url = "github:hyprwm/hyprland?rev=06244555915339967864292dd0b83cd9732516d8";
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
		# neovim-nightly = {
		# 	url = "github:neovim/neovim?dir=contrib";
		# 	inputs.nixpkgs.follows = "nixpkgs";
		# };
		# emcore = {
		# 	url = "github:colin-heffernan/EMCore";
		# 	inputs.nixpkgs.follows = "nixpkgs";
		# };
		# helix = {
		# 	url = "github:helix-editor/helix";
		# 	inputs.nixpkgs.follows = "nixpkgs";
		# };
		# emacs-overlay = {
		# 	url = "github:nix-community/emacs-overlay";
		# 	inputs.nixpkgs.follows = "nixpkgs";
		# };
	};

	outputs = { self, nixpkgs, home-manager, hyprland, eww, discord, nvcode, ... }@inputs:
		let
			system = "x86_64-linux";
			pkgs = import nixpkgs {
				inherit system;
				config.allowUnfree = true;
				overlays = [
					nvcode.overlays.default
					# emcore.overlays.default
					# emacs-overlay.overlay
					(final: prev: {
						nix-direnv = prev.nix-direnv.override { enableFlakes = true; };
						inherit (eww.packages.${prev.system}) eww-wayland;
						# helix-unwrapped = helix.packages.${prev.system}.helix-unwrapped;
						discord = prev.discord.overrideAttrs (
							_: { src = inputs.discord; }
						);
						# neovim-unwrapped = neovim-nightly.packages.${prev.system}.neovim;
						# lmms = prev.lmms.overrideAttrs (
						# 	oldAttrs: {
						# 		buildInputs = oldAttrs.buildInputs ++ [ pkgs.wine ];
						# 		cmakeFlags = oldAttrs.cmakeFlags ++ [ "-DWANT_VST=ON" "-DWANT_VST_32=ON" "-DWANT_VST_64=ON" ];
						# 	}
						# );
					})
				];
			};
			inherit (nixpkgs) lib;
		in {
			nixosConfigurations = {
				heffos-obsidian = lib.nixosSystem {
					inherit system pkgs;
					specialArgs = { inherit nixpkgs; };
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
			devShells.${system}.default = pkgs.mkShell {
					buildInputs = with pkgs; [
						lua-language-server
						# marksman
						# nodePackages.bash-language-server
						nodePackages.vscode-langservers-extracted
						# rnix-lsp
					];
			};
		};
}
