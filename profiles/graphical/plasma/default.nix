{ config, pkgs, ... }: {
  services.xserver = {
    enable = true;
    desktopManager.plasma5.enable = true;
    displayManager.sddm.enable = true;
  };

  environment = {
    systemPackages = with pkgs; [
      zathura
    ];
  };
}
