{ flake, pkgs, lib, config, ... }:
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

  # Work Mac (Kandji MDM): patch Zen's bundle ID (app.zen-browser.zen ->
  # app.zen-browser.zen-oss) so the enterprise profile targeting the official
  # bundle ID doesn't match, preventing extension blocking on this
  # nix-managed browser. (adapted from ndots: hosts/darwin/jp-mbp)
  #
  # The zen HM module skips policies when unwrappedPackage is set, so we
  # re-wrap manually and pass them through the wrapper. Also works around a
  # nixpkgs 26.05 wrapFirefox bug where "Zen Browser (Beta)" is left unquoted
  # in buildCommand (parentheses break bash eval).
  programs.zen-browser = lib.mkIf pkgs.stdenv.isDarwin {
    unwrappedPackage =
      flake.inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.beta-unwrapped.overrideAttrs
        (oldAttrs: {
          postInstall = (oldAttrs.postInstall or "") + ''
            /usr/libexec/PlistBuddy -c "Set :CFBundleIdentifier app.zen-browser.zen-oss" \
              "$out/Applications/Zen Browser (Beta).app/Contents/Info.plist"
            ln -sf zen "$out/Applications/Zen Browser (Beta).app/Contents/MacOS/zen-beta"
          '';
        });
    package =
      (pkgs.wrapFirefox config.programs.zen-browser.unwrappedPackage {
        inherit (config.programs.zen-browser) extraPrefs extraPrefsFiles nativeMessagingHosts;
        extraPolicies = config.programs.zen-browser.policies;
        icon = "zen-browser";
      }).overrideAttrs
        (old: {
          # Fix nixpkgs wrapFirefox bug: unquoted "Zen Browser (Beta)" in buildCommand.
          buildCommand =
            builtins.replaceStrings
              [ "touch $out/Applications/Zen Browser (Beta).app" ]
              [ "touch \"$out/Applications/Zen Browser (Beta).app\"" ]
              old.buildCommand;
        });
  };
}
