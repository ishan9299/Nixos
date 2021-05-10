{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    alacritty
  ];
  xdg.configFile."foot/foot.ini".source = ./foot.ini;
}
