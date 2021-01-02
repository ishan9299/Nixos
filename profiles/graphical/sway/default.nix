{ config, pkgs, lib, ... }: {

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraPackages = with pkgs; [
      swaylock # lockscreen
      swayidle
      xwayland # for legacy apps
      mako # notification daemon
      kanshi # autorandr
      wl-clipboard # clipboard
      autotiling # dynamic tiling in sway
      brightnessctl # brightness control
      nwg-launchers # launcher
      wofi
      grim
      slurp
      polkit_gnome
      waybar
    ];
  };

  environment = {
    etc = {
      # Put config files in /etc. Note that you also can put these in ~/.config, but then you can't manage them with NixOS anymore!
      "sway/config".source = ./dotfiles/sway/config;
      "sway/scripts/swayworkspace".source = ./dotfiles/sway/scripts/swayworkspace;
      "xdg/waybar/config".source = ./dotfiles/waybar/config;
      "xdg/waybar/style.css".source = ./dotfiles/waybar/style.css;
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
            systemctl --user start sway-session.target
          # then start the service
            exec systemctl --user start sway.service
        '';
      })
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
    # environment.PATH = lib.mkForce null;
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
    package = pkgs.redshift-wlr;
  };

  systemd.user.services.waybar = {
    description = "Waybar as systemd service";
    wantedBy = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];
    script = "${pkgs.waybar}/bin/waybar";
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

}
