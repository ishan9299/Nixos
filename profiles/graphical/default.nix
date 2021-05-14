{ config, pkgs, lib, ... }:
{
  imports = [
    # ./plasma
    ./gnome
    ./river
  ];

  hardware.pulseaudio = {
    enable = false;
  };

  environment = {
    systemPackages = with pkgs; [
      vivaldi
      vivaldi-widevine
      vivaldi-ffmpeg-codecs
      cool-retro-term
      foot
      firefox
      lagrange
    ];
  };

  fonts.fonts = with pkgs; [
    corefonts
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    ibm-plex
    fira
    open-sans
  ];

  services.flatpak.enable = true;
  services.flatpak.guiPackages = lib.mkForce [ ]; # don't install gnome-software
  xdg = {
    mime.enable = true;
    icons.enable = true;
    menus.enable = true;
    portal.enable = true;
  };
}
