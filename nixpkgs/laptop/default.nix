{ config, pkgs, lib, ... }:

let
  nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    exec -a "$0" "$@"
  '';
in
  {
    # Gnome default desktop
    services = {
      xserver = {
        enable = true;
        layout = "us"; # keyboard layout
        desktopManager = {
          gnome3.enable = true;
          xterm.enable = false;
        };
        # Enable GDM
        displayManager = {
          lightdm.enable = false;
          gdm.enable = true;
          gdm.wayland = true;
        };
        # Enable TouchInputs
        libinput.enable = true;
      };
      earlyoom.enable = true;
      qemuGuest.enable = true;
      tlp.enable = true;
    };

    environment = {
      # Extra gui packages
      systemPackages = with pkgs; [
        google-chrome-dev
        lollypop
        tilix
        virt-manager
        vscode
        gnome3.gnome-tweaks
        gnome3.dconf-editor
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
        gnome-photos
      ];
    };

    hardware = {
      enableAllFirmware = true;
      pulseaudio.enable = true;
      nvidiaOptimus.disable = true;
      nvidia = {
        prime = {
          offload.enable = true;

          # Bus ID of the Intel GPU. You can find it using lspci, either under 3D or VGA
          intelBusId = "PCI:0:2:0";

          # Bus ID of the NVIDIA GPU. You can find it using lspci, either under 3D or VGA
          nvidiaBusId = "PCI:1:0:0";
        };
      };
    };

    environment.systemPackages = with pkgs; [
      nvidia-offload
    ];


    # NVIDIA stuff
    services.xserver.displayManager.gdm.nvidiaWayland = true;
    services.xserver.displayManager.gdm.wayland = true;
    hardware.nvidia.modesetting.enable = true; # To use wayland with nvidia
    services.xserver.videoDrivers = ["nvidia"];

    # Virtualization
    virtualisation.kvmgt.enable = true;
    virtualisation.libvirtd = {
      enable = true;
      qemuOvmf = true;
      qemuRunAsRoot = false;
      onBoot = "ignore";
      onShutdown = "shutdown";
    };

    # Flatpak
    services.flatpak.enable = true;
    xdg.portal.enable = true;
    xdg.portal.gtkUsePortal = true;
  }
