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
    username = "jashanpreet.singh";
    fullname = "Jashanpreet Singh";
    email = "jashanpreet.singh@juspay.in";
  };

  home.stateVersion = "24.11";
	#  home.packages = with pkgs; [
	#  ];
}
