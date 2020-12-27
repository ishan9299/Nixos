{ config, pkgs, lib, ... }: {
  environment.systemPackages = with pkgs; [
    acpi
    lm_sensors
    wirelesstools
    pciutils
    usbutils
  ];

  hardware.bluetooth.enable = true;

  # power management features
  services.tlp.enable = true;
  services.tlp.settings = {
    CPU_SCALING_GOVERNOR_ON_AC = "performance";
    CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
    CPU_HWP_ON_AC = "performance";
  };

  security.rtkit.enable = true;
  # services.pipewire = {
  #   enable = true;
  #   alsa.enable = true;
  #   alsa.support32Bit = true;
  #   jack.enable = true;
  #   pulse.enable = true;
  # };
  # services.logind.lidSwitch = "suspend";
}
