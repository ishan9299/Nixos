{ config, libs, pkgs, ... }:
{
  home.packages = with pkgs; [
    wofi
  ];
  wayland.windowManager.sway.enable = true;
}
