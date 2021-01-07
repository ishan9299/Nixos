{ config, pkgs, lib, ... }: {
  services.xserver = {
    desktopManager.plasma5.enable = true;
    displayManager.sddm.enable = true;
  };
}
