{ config, pkgs, lib, ... }: {

  # Gnome default desktop
  services = {
    xserver = {
      enable = true;
      layout = "us"; # keyboard layout
      desktopManager = {
        gnome3.enable = true;
        xterm.enable = false;
      };
      # Enable GDM
      displayManager = {
        lightdm.enable = false;
        gdm.enable = true;
        gdm.wayland = true;
      };
      # Enable TouchInputs
      libinput.enable = true;
    };
    gnome3.gnome-remote-desktop.enable = false;
  };

  environment = {
    systemPackages = with pkgs; [
      # Browser
      google-chrome
      brave
      firefox-wayland

      # gnome
      gnome3.gnome-tweaks
      gnome3.dconf-editor
      gimp
      drawing
      shotwell
      contrast

      # Launcher
      ulauncher
    ];

    # Exclude some gnome packages
    gnome3.excludePackages = with pkgs; [
      gnome3.gnome-music
      gnome3.gnome-contacts
      gnome3.gnome-maps
      gnome3.totem
      gnome3.yelp
      gnome3.epiphany
      gnome3.eog
      gnome3.gedit
      gnome-photos
    ];
  };
}
