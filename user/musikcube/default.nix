{ config, pkgs, libs, ... }:
{
  home.packages = with pkgs;[
    musikcube
  ];
  xdg.configFile."musikcube/hotkeys.json".source = ./hotkeys.json;
}
