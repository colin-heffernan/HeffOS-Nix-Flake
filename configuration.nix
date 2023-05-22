# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, lib, nixpkgs, ... }:

let
	configure-gtk = pkgs.writeTextFile {
		name = "configure-gtk";
		destination = "/bin/configure-gtk";
		executable = true;
		text = let
			schema = pkgs.gsettings-desktop-schemas;
			datadir = "${schema}/share/gsettings-schemas/${schema.name}";
		in "export XDG_DATA_DIRS=${datadir}:$XDG_DATA_DIRS";
	};

	update-dbus-env = pkgs.writeTextFile {
		name = "update-dbus-env";
		destination = "/bin/update-dbus-env";
		executable = true;
		text = ''
			dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=Hyprland
			systemctl --user stop pipewire pipewire-pulse wireplumber xdg-desktop-portal xdg-desktop-portal-hyprland
			systemctl --user start xdg-desktop-portal xdg-desktop-portal-hyprland
			systemctl --user start pipewire pipewire-pulse wireplumber
		'';
	};

	startw = pkgs.writeTextFile {
		name = "startw";
		destination = "/bin/startw";
		executable = true;
		text = ''
			# export WAYLAND_DISPLAY
			# export XDG_CURRENT_DESKTOP=Hyprland
			# export GTK_THEME=Arc-Tokyo-Night
			# export MUSESAMPLER_PATH=/usr/lib/libMuseSamplerCoreLib.so
			# export MUSESAMPLER_INSTRUMENT_FOLDER=/srv/muse-hub/downloads/Instruments/
			# export WINEPREFIX=/home/obsi/.local/share/bottles/bottles/VSTs/
			# export WINELOADER=/home/obsi/.local/share/bottles/runners/soda-7.0-8/bin/wine64
			# export WINEDLLPATH=/home/obsi/.local/share/bottles/runners/soda-7.0-8/lib/wine/x86_64-unix/
			exec Hyprland
		'';
	};
in
{
	imports = [ # Include the results of the hardware scan.
		./hardware-configuration.nix
	];

	# Add Flake support
	nix = {
		package = pkgs.nixVersions.stable;
		extraOptions = ''
			experimental-features = nix-command flakes
			keep-outputs = true
			keep-derivations = true
		'';
		registry.nixpkgs.flake = nixpkgs;
		nixPath = [ "nixpkgs=${nixpkgs}" ];
	};

	# Enable suupport for Nix-Direnv
	environment.pathsToLink = [
		"/share/nix-direnv"
	];

	# Use the systemd-boot EFI boot loader.
	boot.loader.systemd-boot.enable = true;
	boot.loader.efi.canTouchEfiVariables = true;
	
	# Kernel stuff
	# boot.kernelPackages = pkgs.linuxKernel.packages.linux_6_1;
	boot.initrd.kernelModules = [ "amdgpu" ];
	boot.extraModulePackages = with config.boot.kernelPackages; [
		v4l2loopback
	];

	# Hostname
	networking.hostName = "heffos-obsidian"; # Define your hostname.

	/* # Wired connectivity
	networking = {
		networkmanager = {
			enable = true;
			logLevel = "DEBUG";
		};
		supplicant = {
			"enp42s0" = {
				# bridge = "virbr0";
				driver = "wired";
				extraCmdArgs = "-u -W -dd";
				extraConf = ''
					network={
						phase1="tls_disable_tlsv1_0=0 tls_disable_tlsv1_1=0 tls_disable_tlsv1_2=0 tls_ext_cert_check=0"
					}
				'';
			};
		};
	}; */

	# Wireless connectivity
	networking.wireless = {
		enable = true;
		userControlled.enable = true;
		environmentFile = "/home/obsi/Repos/HeffOS-Nix-Flake/secrets/wireless.env";
		networks = {
			"eduroam" = {
				auth = ''
					eap=PEAP
					phase1="peaplabel=auto tls_disable_tlsv1_0=0 tls_disable_tlsv1_1=0 tls_disable_tlsv1_2=0 tls_ext_cert_check=0"
					phase2="auth=MSCHAPV2"
					identity="@EDUROAM_IDENTITY@"
					password="@EDUROAM_PASSWORD@"
				'';
				authProtocols = [ "WPA-EAP" ];
			};
			"a12" = {
				psk = "@ATWELVE_PASSWORD@";
			};
		};
	};

	# Add udev rules
	services.udev = {
		packages = with pkgs; [
			qmk
			qmk-udev-rules
			via
		];
	};

	# Set your time zone.
	time.timeZone = "America/New_York";

	# Prevent suspend.
	powerManagement.enable = false;
	systemd = {
		targets = {
			sleep.enable = false;
			suspend.enable = false;
			hibernate.enable = false;
			hybrid-sleep.enable = false;
		};
	};

	# Enable Polkit.
	security.polkit.enable = true;

	# Select internationalisation properties.
	i18n.defaultLocale = "en_US.UTF-8";
	console = {
		font = "Lat2-Terminus16";
		keyMap = "us";
	};

	# Enable the X11 windowing system.
	services.xserver = {
		enable = true;
		windowManager = {
			awesome = {
				enable = true;
			};
		};
		displayManager = {
			startx = {
				enable = true;
			};
			# gdm = {
			# 	enable = true;
			# };
		};
		layout = "us";
		videoDrivers = [ "amdgpu" ];
	};
	services.picom.enable = true;

	# Enable the Hyprland compositor.
	disabledModules = [
		"programs/hyprland.nix"
	];
	programs.hyprland = {
		enable = true;
		xwayland = {
			enable = true;
			hidpi = true;
		};
	};

	# Enable graphics stuff.
	hardware.opengl = {
		enable = true;
		driSupport = true;
		driSupport32Bit = true;
		# extraPackages = with pkgs; [
		# 	rocm-opencl-icd
		# 	rocm-opencl-runtime
		# ];
		# extraPackages32 = with pkgs.pkgsi686Linux; [
		# 	libva
		# ];
	};

	# Enable virtualization
	virtualisation = {
		libvirtd.enable = true;
		spiceUSBRedirection.enable = true;
	};

	# Enable Gnome keyring.
	# services.gnome.gnome-keyring.enable = true;

	# Start the SSH agent on login
	programs.ssh = {
		startAgent = true;
	};

	# Enable CUPS to print documents.
	# services.printing.enable = true;

	# Enable PipeWire.
	sound.enable = false;
	hardware.pulseaudio.enable = false;
	security.rtkit.enable = true;
	services.pipewire = {
		enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
		audio.enable = true;
		pulse.enable = true;
		jack.enable = true;
		# config = {
		# 	pipewire = {
		# 		default.clock.rate = 48000;
		# 		resample.quality = 10;
		# 	};
		# };
		wireplumber.enable = true;
	};

	# Enable Wayland screen-sharing.
	xdg.portal = {
		enable = true;
		# wlr.enable = true;
		# extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
	};

	# Enable Dconf.
	programs.dconf.enable = true;

	# Enable MPD.
	services.mpd = {
		enable = true;
		dataDir = "/home/obsi/.config/mpd";
		musicDirectory = "/home/obsi/Music/Music";
		playlistDirectory = "/home/obsi/Music/Playlists";
		extraConfig = ''
			state_file	"/home/obsi/.config/mpd/state"
			sticker_file	"/home/obsi/.config/mpd/sticker.sql"

			bind_to_address	"127.0.0.1"
			restore_paused	"yes"
			auto_update	"yes"

			audio_output {
				type	"pipewire"
				name	"PipeWire Sound Server"
			}

			audio_output {
				type	"fifo"
				name	"Visualizer"
				path	"/tmp/mpd.fifo"
				format	"44100:16:2"
			}
		'';
		startWhenNeeded = true;
		user = "obsi";
	};
	systemd.services.mpd.environment = {
		XDG_RUNTIME_DIR = "/run/user/1000";
	};

	# Enable SyncThing.
	# services.syncthing = {
	# 	enable = true;
	# 	dataDir = "/home/obsi";
	# 	configDir = "/home/obsi/.config/syncthing";
	# 	devices = {
	# 		# "OldLaptop" = {
	# 		# 	id = "ENJMHOW-XLCN5VN-S3HIFPM-N7W76PA-TOAHXBU-RG7UOSM-ZC73H2P-FYQCZQ2";
	# 		# };
	# 	};
	# 	folders = {
	# 		"Music" = {
	# 			id = "";
	# 			path = "/home/obsi/Music/Music";
	# 			devices = [  ];
	# 		};
	# 	};
	# 	user = "obsi";
	# };

	# Enable Zsh.
	programs.zsh = {
		enable = true;
		autosuggestions.enable = true;
		syntaxHighlighting.enable = true;
		promptInit = "source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
		interactiveShellInit = ''
			source ${pkgs.zsh-vi-mode}/share/zsh-vi-mode/zsh-vi-mode.plugin.zsh
			source ${pkgs.zsh-autopair}/share/zsh/zsh-autopair/autopair.zsh
		'';
	};

	# Enable Steam.
	programs.steam = {
		enable = true;
	};

	# Enable Java.
	programs.java.enable = true;

	# Enable Flatpak support.
	# services.flatpak.enable = true;

	# Enable Qt5 support and make it match GTK2.
	qt.enable = true;
	qt.platformTheme = "gtk2";
	qt.style = "gtk2";

	# Install fonts.
	fonts = {
		fonts = with pkgs; [
			emacs-all-the-icons-fonts
			iosevka
			(nerdfonts.override { fonts = [ "Iosevka" ]; })
			liberation_ttf
			lmodern
			noto-fonts
			noto-fonts-extra
			victor-mono
		];
		fontconfig = {
			enable = true;
			antialias = true;
			hinting = {
				enable = true;
				style = "hintfull";
			};
		};
	};

	# Define a user account. Don't forget to set a password with ‘passwd’.
	users.users.obsi = {
		home = "/home/obsi";
		description = "obsi";
		isNormalUser = true;
		extraGroups = [ "wheel" "storage" "video" "audio" "libvirtd" "kvm" ];
		# shell = pkgs.zsh;
		shell = pkgs.nushell;
	};

	# Allow unfree packages.
	nixpkgs.config = {
		allowUnfree = true;
		allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
			"steam"
			"steam-original"
			"steam-runtime"
		];
	};

	# List of shells
	environment.shells = with pkgs; [
		bash
		zsh
		nushell
	];

	# List packages installed in system profile. To search, run:
	# $ nix search wget
	environment.systemPackages = with pkgs; [
		# FS utilities
		mtools
		dosfstools
		ntfs3g

		# Compatibility tools
		bottles
		wineWowPackages.waylandFull
		yabridge
		yabridgectl

		# Shell stuff
		bash
		zsh
		nushell
		starship

		# Compositor
		# hyprland

		# WM/DE integration
		xdg-user-dirs
		xdg-utils
		lxqt.lxqt-policykit
		waybar
		eww-wayland
		swaybg
		configure-gtk
		update-dbus-env
		startw
		qt6.qtwayland

		# Themes
		gnome.adwaita-icon-theme
		papirus-icon-theme
		arc-theme

		# CLI programs
		xclip
		git
		yt-dlp
		ffmpeg
		man-pages
		man-db
		wmname
		mpc-cli
		lsof
		ripgrep
		pulseaudio
		alsa-utils
		zip
		unzip
		p7zip
		socat
		fd
		direnv
		nix-direnv
		wego
		mongosh
		(texlive.combine {
			inherit (texlive) collection-basic
			# collection-binextra collection-langenglish
			chktex
			collection-langenglish
			collection-fontsextra collection-fontsrecommended collection-fontutils
			collection-latex collection-latexextra collection-latexrecommended
			collection-mathscience collection-pictures
			collection-plaingeneric collection-publishers
			collection-xetex;
		})
		file
		zk
		pandoc
		clipboard-jh
		fzf
		zoxide

		# TUI programs
		vim
		lazygit
		neofetch
		pfetch
		ncmpcpp
		btop
		nvcode
		# neovim-unwrapped
		helix
		qmk

		# GUI programs
		firefox
		brave
		ungoogled-chromium
		qpwgraph
		slurp
		grim
		rofi-wayland
		kitty
		wezterm
		thunderbird
		lxappearance
		easyeffects
		mpv
		virt-manager
		gnome.zenity
		# emcore
		famistudio
		godot
		obs-studio
		remmina
		# via
		# lmms
		reaper
		musescore
		# carla

		# VSTs
		distrho

		# Chat
		discord
		element-desktop

		# Content creation tools
		audacity
		gimp
		# krita
		inkscape
		libsForQt5.kdenlive

		# Language servers
		# haskell-language-server
		# lua-language-server
		marksman
		nodePackages.bash-language-server
		# nodePackages.dockerfile-language-server-nodejs
		# nodePackages.graphql-language-service-cli
		# nodePackages.pyright
		# nodePackages.svelte-language-server
		# nodePackages.typescript-language-server
		# nodePackages.vscode-css-languageserver-bin
		# nodePackages.vscode-html-languageserver-bin
		# nodePackages.vscode-json-languageserver
		rnix-lsp
		# rust-analyzer
		# texlab

		# Linters
		# hlint
		# html-tidy
		# nodePackages.eslint
		# nodePackages.jsonlint
		# nodePackages.stylelint
		# lua53Packages.luacheck
		# pylint
		# shellcheck
		# statix

		# Debug Adapters
		# haskellPackages.haskell-debug-adapter
		# lldb
		# python310Packages.debugpy

		# Just for fun :)
		# cmatrix
		prismlauncher
		freetube
		protontricks
		mpd-discord-rpc
	];

	# Overlays
	# nixpkgs.overlays = [
	# 	(self: super: {
	# 		waybar = super.waybar.overrideAttrs(oldAttrs: {
	# 			mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
	# 		});
	# 	})
	# ];

	# Some programs need SUID wrappers, can be configured further or are
	# started in user sessions.
	# programs.mtr.enable = true;
	# programs.gnupg.agent = {
	#   enable = true;
	#   enableSSHSupport = true;
	# };

	# Enable the OpenSSH daemon.
	services.openssh = {
		enable = false;
		# passwordAuthentication = false;
		# permitRootLogin = "no";
		# ports = [ 17701 ];
	};

	# Open ports in the firewall.
	# networking.firewall.allowedTCPPorts = [ ... ];
	# networking.firewall.allowedUDPPorts = [ ... ];

	# Copy the NixOS configuration file and link it from the resulting system
	# (/run/current-system/configuration.nix). This is useful in case you
	# accidentally delete configuration.nix.
	# system.copySystemConfiguration = true;

	# This value determines the NixOS release from which the default
	# settings for stateful data, like file locations and database versions
	# on your system were taken. It‘s perfectly fine and recommended to leave
	# this value at the release version of the first install of this system.
	# Before changing this value read the documentation for this option
	# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
	system.stateVersion = "22.11"; # Did you read the comment?

}

