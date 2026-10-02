{ pkgs, lib, ... }:
{
  # Linux / Wayland desktop packages.
  # Self-guarding: contributes nothing on macOS.
  home.packages = with pkgs;
    lib.optionals pkgs.stdenv.isLinux [
      mako # notification daemon (keep exactly one; dunst dropped)
      waybar
      wofi
      grim
      slurp
      wl-clipboard
      wlogout
      brightnessctl
      pamixer
      pavucontrol
      networkmanagerapplet # tray frontend only; NetworkManager daemon stays in NixOS
    ];
}
