{ config, pkgs, lib, ... }:
{
  imports = [
    # ./plasma
    # ./gnome
    ./wm/sway
  ];

  hardware.pulseaudio = {
    enable = false;
  };

  environment = {
    systemPackages = with pkgs; [
      google-chrome-dev
      chrome-export
      torbrowser
      cool-retro-term
      foot
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
  xdg = {
    mime.enable = true;
    icons.enable = true;
    menus.enable = true;
    portal.enable = true;
  };
}
