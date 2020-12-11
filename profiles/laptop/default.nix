{ config, pkgs, lib, ... }: {
  environment.systemPackages = with pkgs; [
    acpi
    lm_sensors
    wirelesstools
    pciutils
    usbutils
  ];

  hardware.bluetooth.enable = true;

  # better timesync for unstable internet connections
  services.chrony.enable = true;
  services.timesyncd.enable = false;

  # power management features
  services.tlp.enable = true;
  services.tlp.settings = {
    CPU_SCALING_GOVERNOR_ON_AC = "performance";
    CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
    CPU_HWP_ON_AC = "performance";
  };
  # services.logind.lidSwitch = "suspend";
}
