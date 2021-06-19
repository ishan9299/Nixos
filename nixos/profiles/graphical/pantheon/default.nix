{ pkgs, config, ... }:
{
  services = {
    xserver = {
      enable = true;
      layout = "us"; # keyboard layout
      # Enable GDM
      desktopManager = {
        pantheon.enable = true;
        xterm.enable = false;
      };
      displayManager = {
        lightdm = {
          enable = true;
	  greeters.pantheon.enable = true;
        };
      };
      # Enable TouchInputs
      libinput.enable = true;
    };
    switcherooControl.enable = true;
  };
}
