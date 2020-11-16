{ config, pkgs, libs, ... }:
{
  home.packages = with packages;[
    musikcube
  ];
  xdg.configFile."musikcube/hotkeys.json".source = ./hotkeys.json;
}
