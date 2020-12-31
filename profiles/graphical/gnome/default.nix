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
        gdm.nvidiaWayland = true;
      };
      # Enable TouchInputs
      libinput.enable = true;
    };
    gnome3.gnome-remote-desktop.enable = true;
  };

  environment = {
    systemPackages = with pkgs; [
      gnome3.gnome-tweaks
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
      gnome3.gnome-software
      gnome-photos
    ];
  };
}
