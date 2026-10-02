{ pkgs, lib, ... }:
{
  # macOS-only packages.
  # Self-guarding: contributes nothing on Linux.
  home.packages = with pkgs;
    lib.optionals pkgs.stdenv.isDarwin [
      # Add macOS-specific packages here
    ];
}
