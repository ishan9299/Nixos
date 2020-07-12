# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix ./nvidia.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader = {
    systemd-boot.enable = true;
    systemd-boot.consoleMode = "max";
    efi.canTouchEfiVariables = true;
    systemd-boot.configurationLimit = 3;
    timeout = 2;
    systemd-boot.editor = false;
  };

  boot.initrd.luks.devices = {
    lvmcrypt = {
      device = "/dev/disk/by-uuid/{encrypted luks partition uuid}";
    };
  };

  networking.hostName = "nixos"; # Define your hostname.
  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp0s20f0u4.useDHCP = true;
  networking.interfaces.enp2s0.useDHCP = true;
  networking.interfaces.wlp3s0.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    earlySetup = "true";
    font = "ter-132n";
    keyMap = "us";
  };

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment = {
    systemPackages = with pkgs; [
      wget
      git
      fish
      ffmpeg
      flatpak
      chromium
      alacritty
    ];

    gnome3.excludePackages = with pkgs; [
      gnome3.gnome-music
      gnome3.gnome-contacts
      gnome3.gnome-maps
      gnome3.gnome-terminal
      gnome3.totem
      gnome3.yelp
      gnome3.epiphany
      gnome-photos
    ];
  }

  programs.fish.enable = true;

  fonts.fonts = with pkgs; [
    corefonts
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    source-code-pro
    source-sans-pro
    source-serif-pro
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  #   pinentryFlavor = "gnome3";
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = true;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  services = {
    # Enable X11
    xserver = {
      enable = true;
      layout = "us";

      # Swap caps and escape
      xkbOptions = "caps:swapescape";
      # Touchpad support
      libinput.enable = true;

      # Desktop to use
      displayManager = {
        lightdm.greeter.enable = false;
        gdm.enable = true;
      }
      desktopManager = {
        gnome3.enable = true;
      }
    }
  }

  # NVIDIA stuff
  # hardware.nvidiaOptimus.disable = true;
  # services.xserver.displayManager.gdm.nvidiaWayland = true;
  # services.xserver.displayManager.gdm.wayland = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.me = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  };

  users.users.guest = {
    isNormalUser = true;
  };

  users.defaultUserShell = pkgs.fish;
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "20.09"; # Did you read the comment?

}
