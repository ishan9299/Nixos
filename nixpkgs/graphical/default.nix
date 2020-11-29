{ config, pkgs, lib, ... }: {
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

      # Browser
      google-chrome-dev
      brave
      firefox

      # Music
      lollypop

      # Editors
      vscode
      gnvim-unwrapped # the default one comes with neovim-stable so avoid that

      # gnome
      gnome3.gnome-tweaks
      gnome3.dconf-editor
      gimp
      shotwell
      contrast

      # launcher
      ulauncher
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
      gnome3.gedit
      gnome-photos
    ];
  };

  hardware = {
    enableAllFirmware = true;
    pulseaudio.enable = true;
    opengl = {
      enable = true;
      extraPackages = with pkgs; [ intel-media-driver ];
    };
  };

  # Fonts to install
  fonts.fonts = with pkgs; [
    corefonts
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    lato
    source-han-sans
    source-sans-pro
    source-serif-pro
    (nerdfonts.override {
      fonts = [ "CascadiaCode" "FiraCode" "Overpass" "Iosevka" "JetBrainsMono" ];
    })
  ];

  # Flatpak
  services.flatpak.enable = true;
  xdg.portal.enable = true;
  xdg.portal.gtkUsePortal = true;
}
