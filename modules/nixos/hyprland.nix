# Hyprland + NVIDIA configuration
{ flake, config, pkgs, lib, ... }:
let
  cfg = config.modules.hyprland;
in
{
  imports = [ flake.inputs.hyprland.nixosModules.default ];
  options.modules.hyprland = {
    enable = lib.mkEnableOption "Hyprland Wayland compositor with NVIDIA support";
    nvidiaBusId = lib.mkOption {
      type = lib.types.str;
      default = "PCI:1:0:0";
      description = "NVIDIA GPU bus ID for PRIME offload (run lspci | grep NVIDIA)";
    };
    amdgpuBusId = lib.mkOption {
      type = lib.types.str;
      default = "PCI:5:0:0";
      description = "AMD iGPU bus ID for PRIME offload (run lspci | grep AMD)";
    };
    enablePrime = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Enable PRIME offload for hybrid graphics";
    };
  };
  config = lib.mkIf cfg.enable {
    # Enable Hyprland
    programs.hyprland.enable = true;
    # NVIDIA configuration
    services.xserver.videoDrivers = [ "nvidia" ];
    hardware.nvidia = {
      modesetting.enable = true;
      open = false;
      nvidiaSettings = true;
      prime = lib.mkIf cfg.enablePrime {
        offload.enable = true;
        nvidiaBusId = cfg.nvidiaBusId;
        amdgpuBusId = cfg.amdgpuBusId;
      };
    };
    # Kernel parameter for NVIDIA DRM modeset
    boot.kernelParams = [ "nvidia-drm.modeset=1" ];
    # Wayland environment fixes for NVIDIA
    environment.sessionVariables = {
      WLR_NO_HARDWARE_CURSORS = "1";
      NIXOS_OZONE_WL = "1";
    };
    # SDDM display manager
    services.displayManager.sddm = {

     enable=true;
     wayland.enable=true;
};
    services.displayManager.defaultSession = "hyprland";
    # Essential Wayland/Hyprland packages
    environment.systemPackages = with pkgs; [
      waybar
      opencode
      wofi
      kitty
      dunst
      grim
      slurp
      wl-clipboard
      # Additional useful tools
      mako
      wlogout
      brightnessctl
      pamixer
      pavucontrol
      networkmanagerapplet
    ];
    # Enable pipewire for audio (if not already enabled)
  };
}
