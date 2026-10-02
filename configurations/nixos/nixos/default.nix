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

  # Standalone home-manager profile (activated via `nix run .`) on the
  # session PATH, so Hyprland/wofi find user-installed apps and desktop
  # entries after the home config is activated.
  environment.profiles = [ "$HOME/.local/state/nix/profiles/home-manager" ];

  # Boot loader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  system.stateVersion = "24.11";
}
