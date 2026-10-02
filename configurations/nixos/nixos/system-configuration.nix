{ config, pkgs, ... }:

{
  # Placeholder - replace with your actual config
  environment.systemPackages = with pkgs; [
    vim
    wget
    git
  ];

  networking.networkmanager.enable = true;
  time.timeZone = "Asia/Kolkata";
  i18n.defaultLocale = "en_US.UTF-8";

  # Sound
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };

  # Hyprland + NVIDIA
  modules.hyprland.enable = true;

  # Base user (home-manager handles the rest)
  users.users.batth = {
    isNormalUser = true;
    description = "Jashanpreet Singh";
    extraGroups = [ "networkmanager" "wheel" ];
  };
}


