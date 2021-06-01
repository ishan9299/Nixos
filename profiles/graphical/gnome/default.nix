{
  services = {
    xserver.displayManager.gdm.enable = true;
    xserver.displayManager.defaultSession = "gnome";
    xserver.desktopManager = {
      gnome.enable = true;
    };
    gnome.gnome-keyring.enable = true;
  };
}
