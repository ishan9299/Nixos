{ config, pkgs, lib, ... }:
{
  imports = [
    ./gnome
    #  ./sway
    ./dwm
    # ./plasma
  ];

  hardware.pulseaudio = {
    enable = true;
    support32Bit = true;
    package = pkgs.pulseaudioFull;
  };

  environment = {
    systemPackages = with pkgs; [
      brave
      google-chrome-dev
    ];
  };

  fonts.fonts = with pkgs; [
    corefonts
    cantarell-fonts
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
  services.flatpak.guiPackages = lib.mkForce []; # don't install gnome-software
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
