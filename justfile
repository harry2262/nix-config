# Like GNU `make`, but `just` rustier.
# https://just.systems/
# run `just` from this directory to see available commands

# Default command when 'just' is run without arguments
default:
  @just --list

# Update nix flake
[group('Main')]
update:
  nix flake update

# Lint nix files
[group('dev')]
lint:
  nix fmt

# Check nix flake
[group('dev')]
check:
  nix flake check

# Manually enter dev shell
[group('dev')]
dev:
  nix develop

# Activate home-manager configuration (current machine)
[group('Main')]
run:
  nix run

# Apply NixOS configuration (run on NixOS machine)
[group('NixOS')]
nixos-switch:
  sudo nixos-rebuild switch --flake .

# Build NixOS configuration without applying
[group('NixOS')]
nixos-build:
  nixos-rebuild build --flake .

# Apply NixOS configuration for specific host
[group('NixOS')]
nixos-switch-host host:
  sudo nixos-rebuild switch --flake .#{{host}}
