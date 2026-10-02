# NixOS configuration for batth
{ flake, ... }:
let
  inherit (flake) inputs;
  inherit (inputs) self;
in
{
  imports = [
    # Your existing configs (copy these from /etc/nixos/ on the machine)
    ./hardware-configuration.nix
    ./system-configuration.nix

    # Our shared NixOS modules
    self.nixosModules.default
  ];

  networking.hostName = "nixos";

  # Boot loader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  system.stateVersion = "24.11";
}
