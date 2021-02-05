{ config, pkgs, lib, ... }: {

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
        lightdm = {
          enable = true;
          greeters.enso.enable = true;
          greeters.enso.blur = true;
          #  greeters.enso.cursorTheme.package = "pkgs.capitaine-cursor";
          #  greeters.enso.cursorTheme.name = "capitaine-cursor";
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
}
