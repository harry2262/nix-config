{ flake, pkgs, ... }:
let
  inherit (flake) inputs;
  inherit (inputs) self;
in
{
  imports = [
    self.homeModules.default
  ];

  # Defined by /modules/home/me.nix
  # And used all around in /modules/home/*
  me = {
    username = "batth";
    fullname = "Jashanpreet Singh";
    email = "jashanbath608@gmail.com";
  };

  home.stateVersion = "24.11";
	#  home.packages = with pkgs; [
	#  ];
}
