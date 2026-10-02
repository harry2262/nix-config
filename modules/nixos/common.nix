# Common NixOS settings
{
  nix = {
    settings.experimental-features = [ "nix-command" "flakes" ];
    settings.auto-optimise-store = true;
    gc.automatic = true;
    gc.options = "--delete-older-than 30d";
    optimise.automatic = true;
  };
  nixpkgs.config.allowUnfree = true;
}
