{ config, pkgs, lib, ... }: {

  # Gnome default desktop
  services = {
    xserver = {
      enable = false;
      layout = "us"; # keyboard layout
      desktopManager = {
        gnome3.enable = false;
        xterm.enable = false;
      };
      # Enable GDM
      displayManager = {
        lightdm.enable = false;
        gdm.enable = false;
        gdm.wayland = false;
      };
      # Enable TouchInputs
      libinput.enable = true;
    };
    earlyoom.enable = true;
    qemuGuest.enable = true;
    tlp.enable = true;
    gnome3.gnome-remote-desktop.enable = false;
   };

  # Also add sway
  programs.sway = {
    enable = true;
    extraPackages = with pkgs; [
      swaylock # lockscreen
      swayidle
      xwayland # for legacy apps
      waybar # status bar
      mako # notification daemon
      kanshi # autorandr
      autotiling
    ];
  };

  environment = {
    etc = {
      # Put config files in /etc. Note that you also can put these in ~/.config, but then you can't manage them with NixOS anymore!
      "sway/config".source = ./sway/config;
      "xdg/waybar/config".source = ./waybar/config;
      "xdg/waybar/style.css".source = ./waybar/style.css;
    };
  };



  # Not strictly required but pipewire will use rtkit if it is present
  security.rtkit.enable = true;

  environment = {
    # Extra gui packages
    systemPackages = with pkgs; [

      # Browser
      google-chrome
      brave
      firefox-wayland

      # Music
      lollypop

      # Editors
      vscode
      gnvim-unwrapped # the default one comes with neovim-stable so avoid that

      # gnome
      gnome3.gnome-tweaks
      gnome3.dconf-editor
      gimp
      drawing
      shotwell
      contrast

      # launcher
      ulauncher
      waybar
      wofi
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
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  xdg.portal.gtkUsePortal = true;
}
