{ config, pkgs, lib, ... }:
# let
#   nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
#     export __NV_PRIME_RENDER_OFFLOAD=1
#     export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
#     export __GLX_VENDOR_LIBRARY_NAME=nvidia
#     export __VK_LAYER_NV_optimus=NVIDIA_only
#     exec -a "$0" "$@"
#   '';
# in
{
  #  services.xserver.displayManager.gdm.nvidiaWayland = true;
  #  services.xserver.videoDrivers = [ "nvidia" ];

  #  hardware = {
  #    nvidia = {
  #      modesetting.enable = true;
  #      prime = {
  #        offload.enable = true;
  #        # Bus ID of the Intel GPU. You can find it using lspci, either under 3D or VGA
  #        intelBusId = "PCI:0:2:0";
  #        # Bus ID of the NVIDIA GPU. You can find it using lspci, either under 3D or VGA
  #        nvidiaBusId = "PCI:1:0:0";
  #      };
  #    };
  #  };

  #  environment.systemPackages = with pkgs; [ nvidia-offload ];

  imports = [
    # ./gnome
    ./sway
    ./plasma
  ];

  hardware.nvidiaOptimus.disable = true;
  hardware.pulseaudio = {
    enable = true;
    support32Bit = true;
    package = pkgs.pulseaudioFull;
  };

  environment = {
    systemPackages = with pkgs; [
      # Browser
      google-chrome
      brave
      firefox-wayland

      # Image Editors
      gimp
      drawing
      shotwell
      contrast

      # Editor
      geany-with-vte

      # Theme
      plasma5.breeze-qt5
      paper-icon-theme
      gnome3.adwaita-icon-theme
    ];
  };

  fonts.fonts = with pkgs; [
    corefonts
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    lato
    source-han-sans
    source-sans-pro
    source-serif-pro
  ];

  # qt5.platformTheme = "gnome";
  services.flatpak.enable = true;
  xdg.portal.enable = true;
  xdg.portal.gtkUsePortal = true;
  xdg.portal.extraPortals = with pkgs; [
    xdg-desktop-portal-kde
    # xdg-desktop-portal-wlr
    # xdg-desktop-portal-gtk
  ];
}
