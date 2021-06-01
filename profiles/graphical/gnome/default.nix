{ pkgs, config, ... }:
{
  services = {
    xserver = {
      enable = true;
      layout = "us"; # keyboard layout
      # Enable GDM
      desktopManager = {
        gnome.enable = true;
        xterm.enable = true;
      };
      displayManager = {
        gdm = {
          enable = true;
          # wayland = true;
          # nvidiaWayland = true;
        };
      };
      # Enable TouchInputs
      libinput.enable = true;
    };
    gnome = {
      gnome-keyring.enable = true;
      sushi.enable = true;
      gnome-user-share.enable = true;
      core-shell.enable = true;
      core-os-services.enable = true;
    };
    switcherooControl.enable = true;
  };

  environment.gnome.excludePackages = with pkgs; [
    gnome-connections
    gnome-photos
    gnome-tour
    gnome.gnome-software
    gnome3.baobab
    gnome3.cheese
    gnome3.eog
    gnome3.epiphany
    gnome3.geary
    gnome3.gedit
    gnome3.gnome-calendar
    gnome3.gnome-clocks
    gnome3.gnome-contacts
    gnome3.gnome-font-viewer
    gnome3.gnome-logs
    gnome3.gnome-maps
    gnome3.gnome-music
    gnome3.gnome-screenshot
    gnome3.gnome-system-monitor
    gnome3.gnome-weather
    gnome3.simple-scan
    gnome3.totem
    gnome3.yelp
  ];
}
