{ config, pkgs, lib, ... }: {

  programs.sway = {
    enable = true;
    wrapperFeatures = { gtk = true; };
    extraSessionCommands = ''
      export SDL_VIDEODRIVER=wayland
      export QT_QPA_PLATFORM=wayland
      export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"
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
      font-awesome # waybar icons
      nwg-launchers # launcher
      wofi # launcher
      grim # screenshot
      slurp # screenshot
      polkit_gnome
      waybar # bar
      wlogout
    ];
  };

  environment = {
    etc = {
      # Put config files in /etc. Note that you also can put these in ~/.config, but then you can't manage them with NixOS anymore!
      "sway/config".source = ./configs/sway/config;
      "sway/scripts/swayworkspace".source = ./configs/sway/scripts/swayworkspace;
      "xdg/waybar/config".source = ./configs/waybar/config;
      "xdg/waybar/style.css".source = ./configs/waybar/style.css;
      };

    systemPackages = with pkgs; [
      gnome3.nautilus
      gnome3.nautilus-python
      gnome3.sushi
      gtk-engine-murrine
      gtk_engines
      gsettings-desktop-schemas
      pavucontrol
    ];
  };

  # needed for redshift
  location.provider = "geoclue2";
}
