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
      torbrowser
    ];
  };

  services.flatpak.enable = true;
  xdg = {
    mime.enable = true;
    icons.enable = true;
    menus.enable = true;
    portal.enable = true;
  };
}
