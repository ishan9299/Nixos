{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    yambar
    font-awesome
  ];
  xdg.configFile."yambar/config.yml".source = ./config.yml;
}
