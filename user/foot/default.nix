{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    foot
  ];
  xdg.configFile."foot/foot.ini".source = ./foot.ini;
}
