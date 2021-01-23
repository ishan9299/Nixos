{ config, pkgs, lib, ... }:
{
  imports = [
    # ./gnome
    ./sway
    # ./plasma
  ];

  hardware.pulseaudio = {
    enable = true;
    support32Bit = true;
    package = pkgs.pulseaudioFull;
  };

  environment = {
    systemPackages = with pkgs; [

      # Browser
      google-chrome
      # brave
      firefox-wayland

    ];
  };

  fonts.fonts = with pkgs; [
    corefonts
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    lato
    source-han-sans
    source-sans-pro
    source-serif-pro
  ];

  qt5.platformTheme = "gnome";
  programs.dconf.enable = true;
  services.flatpak.enable = true;
  xdg.portal.enable = true;
  xdg.portal.gtkUsePortal = true;
  xdg.portal.extraPortals = with pkgs; [
    xdg-desktop-portal-gtk
    xdg-desktop-portal-wlr
  ];
}
