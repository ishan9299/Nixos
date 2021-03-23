{ config, pkgs, ... }:
let
  prime-run = pkgs.writeShellScriptBin "prime-run" ''
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    exec -a "$0" "$@"
  '';
in
{
  environment.systemPackages = with pkgs; [
    prime-run
    acpi
    lm_sensors
    wirelesstools
    pciutils
    usbutils
  ];

  # services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidiaOptimus.disable = true;
  hardware.nvidia = {
  #   nvidiaPersistenced = true;
  #   prime = {
  #     offload.enable = true;
  #     # Bus ID of the Intel GPU. You can find it using lspci, either under 3D or VGA
  #     intelBusId = "PCI:0:2:0";
  #     # Bus ID of the NVIDIA GPU. You can find it using lspci, either under 3D or VGA
  #     nvidiaBusId = "PCI:1:0:0";
  #   };
  #   powerManagement.finegrained = true;
    modesetting.enable = true;
  };

  hardware.bluetooth.enable = true;

  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
    extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];
  };

  security.rtkit.enable = true;
  # To use this disable pulseaudio and make sure
  # the user is in the audio group.
  services.pipewire = {
    enable = true;
    socketActivation = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    jack.enable = true;
    pulse.enable = true;
  };
}
