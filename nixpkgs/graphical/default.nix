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
    gnome3.gnome-remote-desktop.enable = true;
  };

  # Also add sway
  programs.sway = {
    enable = true;
    extraPackages = with pkgs; [
      swaylock # lockscreen
      swayidle
      jq # json parser
      xwayland # for legacy apps
      waybar # status bar
      mako # notification daemon
      kanshi # autorandr
      wl-clipboard # clipboard
      autotiling # dynamic tiling in sway
      brightnessctl # brightness control
      ulauncher # launcher
      nwg-launchers # launcher
      polkit_gnome
    ];
  };

  programs.waybar.enable = true;

  # Not strictly required but pipewire will use rtkit if it is present
  security.rtkit.enable = true;

  environment = {
    etc = {
      # Put config files in /etc. Note that you also can put these in ~/.config, but then you can't manage them with NixOS anymore!
      "sway/config".source = ./sway/config;
      "sway/scripts/swayworkspace".source = ./sway/scripts/swayworkspace;
      "xdg/waybar/config".source = ./waybar/config;
      "xdg/waybar/style.css".source = ./waybar/style.css;
    };

    # Extra gui packages
    systemPackages = with pkgs; [

      (pkgs.writeTextFile {
        name = "startsway";
        destination = "/bin/startsway";
        executable = true;
        text = ''
          #! ${pkgs.bash}/bin/bash

          # first import environment variables from the login manager
            systemctl --user import-environment
          # then start the service
            exec systemctl --user start sway.service
        '';
      })

      # Browser
      google-chrome
      brave
      firefox-wayland

      # Music
      lollypop

      # Editors
      vscode
      umlet
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

  # needed for redshift
  location.provider = "geoclue2";

  systemd.user.targets.sway-session = {
    description = "Sway compositor session";
    documentation = [ "man:systemd.special(7)" ];
    bindsTo = [ "graphical-session.target" ];
    wants = [ "graphical-session-pre.target" ];
    after = [ "graphical-session-pre.target" ];
  };

  systemd.user.services.sway = {
    description = "Sway - Wayland window manager";
    documentation = [ "man:sway(5)" ];
    bindsTo = [ "graphical-session.target" ];
    wants = [ "graphical-session-pre.target" ];
    after = [ "graphical-session-pre.target" ];
    # We explicitly unset PATH here, as we want it to be set by
    # systemctl --user import-environment in startsway
    environment.PATH = lib.mkForce null;
    serviceConfig = {
      Type = "simple";
      ExecStart = ''
        ${pkgs.dbus}/bin/dbus-run-session ${pkgs.sway}/bin/sway --debug
      '';
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };

  services.redshift = {
    enable = true;
    # Redshift with wayland support isn't present in nixos-19.09 atm. You have to cherry-pick the commit from https://github.com/NixOS/nixpkgs/pull/68285 to do that.
    package = pkgs.redshift-wlr;
  };

  systemd.user.services.kanshi = {
    description = "Kanshi output autoconfig ";
    wantedBy = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];
    serviceConfig = {
      # kanshi doesn't have an option to specifiy config file yet, so it looks
      # at .config/kanshi/config
      ExecStart = ''
        ${pkgs.kanshi}/bin/kanshi
      '';
      RestartSec = 5;
      Restart = "always";
    };
  };

  systemd.user.services.ulauncher = {
    description = "Linux Application Launcher";
    documentation = [ "https://ulauncher.io/" ];
    after = [ "graphical-session-pre.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = ''
        ${pkgs.ulauncher}/bin/ulauncher --hide-window
      '';
      Restart = "always";
      RestartSec = 1;
    };
    wantedBy = [ "graphical.target" ];
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
      fonts =
        [ "FiraCode" "Iosevka" "JetBrainsMono" "Hasklig" "Monoid"];
    })
  ];

  # Qt Stuff
  programs.qt5ct.enable = true;

  # Flatpak
  services.flatpak.enable = true;
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  xdg.portal.gtkUsePortal = true;
}
