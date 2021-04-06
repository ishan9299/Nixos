{ config, pkgs, lib, ... }:
{
  imports = [
    /* ./gnome */
		./plasma
  ];

  hardware.pulseaudio = {
    enable = false;
  };

  environment = {
    systemPackages = with pkgs; [
      brave
      vivaldi
      vivaldi-widevine
      vivaldi-ffmpeg-codecs
      dconf
      lagrange
    ];
  };

  fonts.fonts = with pkgs; [
    corefonts
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    fira
  ];

  programs.qt5ct.enable = true;
  services.flatpak.enable = true;
  services.flatpak.guiPackages = lib.mkForce [ ]; # don't install gnome-software
  xdg = {
    mime.enable = true;
    icons.enable = true;
    menus.enable = true;
    portal.enable = true;
    portal.extraPortals = with pkgs; [
      xdg-desktop-portal-wlr
    ];
  };
}
