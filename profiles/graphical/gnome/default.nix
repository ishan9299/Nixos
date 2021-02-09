{ config, pkgs, ... }: {

  # Gnome default desktop
  services = {
    xserver = {
      enable = true;
      layout = "us"; # keyboard layout
      # Enable GDM
      desktopManager = {
        gnome3.enable = true;
        xterm.enable = false;
      };
      displayManager = {
        gdm = {
          enable = true;
          #  wayland = true;
          #  nvidiaWayland = true;
        };
      };
      # Enable TouchInputs
      libinput.enable = true;
    };
    gnome3 = {
      gnome-remote-desktop.enable = true;
      gnome-keyring.enable = true;
      sushi.enable = true;
      gnome-user-share.enable = true;
      core-shell.enable = true;
    };
  };

  environment = {
    systemPackages = with pkgs; [
      gnome3.gnome-tweaks
      switcheroo-control
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
      gnome3.geary
      gnome3.gnome-software
      gnome-photos
    ];
  };

  security.hideProcessInformation = false;

  # switcheroo-control stuff
  services.dbus.packages = [ pkgs.switcheroo-control ];
  environment.systemPackages = [ pkgs.switcheroo-control ];
  systemd.packages = [ pkgs.switcheroo-control ];
  systemd.targets.multi-user.wants = [ "switcheroo-control.service" ];
}
