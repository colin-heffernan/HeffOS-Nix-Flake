{pkgs ? import <nixpkgs> {} }:

let
	myEmacs = pkgs.emacsPgtkNativeComp;
	emacsWithPackages = (pkgs.emacsPackagesFor myEmacs).emacsWithPackages;
in
	emacsWithPackages (epkgs: (with epkgs.melpaPackages; [
		doom-themes
		evil
		evil-collection
	]) ++ (with epkgs.elpaPackages; [
		# idk
	]))
