{
  # Gnome default desktop
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
          wayland = true;
          nvidiaWayland = true;
        };
      };
      # Enable TouchInputs
      libinput.enable = true;
    };
    gnome = {
      gnome-remote-desktop.enable = true;
      gnome-keyring.enable = true;
      sushi.enable = true;
      gnome-user-share.enable = true;
      # core-shell.enable = true;
    };
    switcherooControl.enable = true;
  };

  environment = {
    systemPackages = with pkgs; [
      gnome.gnome-tweaks
      dconf
    ];
    # Exclude some gnome packages
    gnome.excludePackages = with pkgs; [
      gnome.gnome-music
      gnome.gnome-contacts
      gnome.gnome-maps
      gnome.totem
      gnome.yelp
      gnome.epiphany
      gnome.eog
      gnome.gedit
      gnome.geary
      gnome.gnome-software
      gnome-photos
    ];
  };
}
