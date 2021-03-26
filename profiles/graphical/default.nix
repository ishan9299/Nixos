{ config, pkgs, lib, ... }:
{
  imports = [
    ./gnome
  ];

  hardware.pulseaudio = {
    enable = false;
    # support32Bit = true;
    # package = pkgs.pulseaudioFull;
  };

  environment = {
    systemPackages = with pkgs; [
      brave
      vivaldi
      vivaldi-widevine
      vivaldi-ffmpeg-codecs
      dconf
      yaru-theme
      vanilla-dmz
      lagrange
    ];
  };

  fonts.fonts = with pkgs; [
    corefonts
    cantarell-fonts
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    fira
    lato
    source-han-sans
    source-sans-pro
    source-serif-pro
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
