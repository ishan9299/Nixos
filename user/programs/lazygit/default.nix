{ config, pkgs, libs, ... }:
{
  home.packages = with pkgs;[
    lazygit
  ];
  xdg.configFile."jesseduffield/lazygit/config.yml".source = ./config.yml;
}
