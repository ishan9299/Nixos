# this is to only install packages for awesome
{ pkgs, ... }:
{
  home.packages = with pkgs; [
    lxappearance
    gnome.nautilus
    gnome.adwaita-icon-theme
    gnome.networkmanagerapplet
  ];
}
