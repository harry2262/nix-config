{ config, ... }:
{
  home.shellAliases = {
    g = "git";
    lg = "lazygit";
  };

  # https://nixos.asia/en/git
  programs = {
    git = {
      enable = true;
      settings = {
        user.name = config.me.fullname;
        user.email = config.me.email;
        aliases = {
          ci = "commit";
        };
      };
      ignores = [ "*~" "*.swp" ];
    };
    lazygit.enable = true;
  };

}
