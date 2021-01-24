{ config, pkgs, lib, ... }: {

  programs.sway = {
    enable = true;
    wrapperFeatures = { gtk = true; };
    extraSessionCommands = ''
      export SDL_VIDEODRIVER=wayland
      # needs qt5.qtwayland in systemPackages
      export QT_QPA_PLATFORM=wayland
      export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
      # Fix for some Java AWT applications (e.g. Android Studio),
      # use this if they aren't displayed properly:
      export _JAVA_AWT_WM_NONREPARENTING=1
    '';
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
      wlogout
      pavucontrol

      evince

      font-awesome
    ];
  };

  environment = {
    etc = {
      # Put config files in /etc. Note that you also can put these in ~/.config, but then you can't manage them with NixOS anymore!
      "sway/config".source = ./dotfiles/sway/config;
      "sway/scripts/swayworkspace".source = ./dotfiles/sway/scripts/swayworkspace;
      "xdg/waybar/config".source = ./dotfiles/waybar/config;
      "xdg/waybar/style.css".source = ./dotfiles/waybar/style.css;

      "xdg/gtk-3.0/settings.ini" = {
        text = ''
          [Settings]
          gtk-icon-theme-name=Adwaita
          gtk-theme-name=Adwaita
          gtk-cursor-theme-name=Adwaita
        '';
        mode = "444";
      };
    };
  };

  # needed for redshift
  location.provider = "geoclue2";

  systemd.user.targets.sway-session = {
    description = "sway compositor session";
    documentation = [ "man:systemd.special(7)" ];
    bindsTo = [ "graphical-session.target" ];
    wants = [ "graphical-session-pre.target" ];
    after = [ "graphical-session-pre.target" ];
    requiredBy = [ "graphical-session.target" "graphical-session-pre.target" ];
  };

  services.redshift = {
    enable = true;
    package = pkgs.redshift-wlr;
  };

  systemd.user.services.kanshi = {
    enable = true;
    description = "Kanshi output autoconfig ";
    wantedBy = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];
    serviceConfig = {
      ExecStart = ''
        ${pkgs.kanshi}/bin/kanshi
      '';
      RestartSec = 5;
      Restart = "always";
    };
  };

}
