{ config, pkgs, ... }:
let
  prime-run = pkgs.writeShellScriptBin "prime-run" ''
    __NV_PRIME_RENDER_OFFLOAD=1 __VK_LAYER_NV_optimus=NVIDIA_only __GLX_VENDOR_LIBRARY_NAME=nvidia "$@"
  '';
in {
  environment.systemPackages = with pkgs; [
    prime-run
    acpi
    lm_sensors
    wirelesstools
    pciutils
    usbutils
  ];

  #  hardware.nvidiaOptimus.disable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    prime = {
      offload.enable = true;
      # Bus ID of the Intel GPU. You can find it using lspci, either under 3D or VGA
      intelBusId = "PCI:0:2:0";
      # Bus ID of the NVIDIA GPU. You can find it using lspci, either under 3D or VGA
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  hardware.bluetooth.enable = true;

  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
    extraPackages = with pkgs;
      [
        intel-media-driver # LIBVA_DRIVER_NAME=iHD
      ];
  };

  security.rtkit.enable = true;
  # To use this disable pulseaudio and make sure
  # the user is in the audio group.
  # services.pipewire = {
  #   enable = true;
  #   socketActivation = true;
  #   alsa.enable = true;
  #   alsa.support32Bit = true;
  #   jack.enable = true;
  #   pulse.enable = true;
  # };
}
