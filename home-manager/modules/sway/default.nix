{ pkgs, ... }:
let
  terminal = "foot";
  wofi = "${pkgs.wofi}/bin/wofi -Iim";
  drun = "${wofi} --show drun";
  nwggrid = "${pkgs.nwg-launchers}/bin/nwggrid";
  swayworkspace = pkgs.writeShellScriptBin "swayworkspace" ''
    ${builtins.readFile ./scripts/swayworkspace.sh}
  '';
  chromeWaylandFlags = "--enable-features=UseOzonePlatform --ozone-platform=wayland";
  wl-color-picker = pkgs.writeShellScriptBin "wl-color-picker" ''
    ${builtins.readFile ./scripts/wl-color-picker.sh}
  '';
in
{
  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraSessionCommands = ''
      export SDL_VIDEODRIVER=wayland
      export QT_QPA_PLATFORM=wayland
      export QT_QPA_PLATFORMTHEME=qt5ct
      export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
      export _JAVA_AWT_WM_NONREPARENTING=1
      export STUDIO_JDK=/nix/store/x6whbg1l2bxnlmv5kya7yw5lgc5797xd-openjdk-11.0.9+11/lib/openjdk/bin/java
      export MOZ_DBUS_REMOTE=1
      export MOZ_ENABLE_WAYLAND=1
    '';
    xwayland = true;
    config = rec {
      modifier = "Mod4";
      inherit terminal;
      window.border = 4;
      gaps = {
        inner = 12;
        smartBorders = "on";
        smartGaps = true;
      };
      keybindings = {
        "${modifier}+t" = "exec ${terminal}";
        "${modifier}+Shift+r" = "reload";
        "${modifier}+Shift+q" = "kill";

        "${modifier}+Left" = "focus left";
        "${modifier}+Down" = "focus down";
        "${modifier}+Up" = "focus up";
        "${modifier}+Right" = "focus right";

        "${modifier}+Shift+Left" = "move left";
        "${modifier}+Shift+Down" = "move down";
        "${modifier}+Shift+Up" = "move up";
        "${modifier}+Shift+Right" = "move right";

        "${modifier}+h" = "focus left";
        "${modifier}+j" = "focus down";
        "${modifier}+k" = "focus up";
        "${modifier}+l" = "focus right";

        "${modifier}+Shift+h" = "move left";
        "${modifier}+Shift+j" = "move down";
        "${modifier}+Shift+k" = "move up";
        "${modifier}+Shift+l" = "move right";

        "${modifier}+1" = "workspace number 1";
        "${modifier}+2" = "workspace number 2";
        "${modifier}+3" = "workspace number 3";
        "${modifier}+4" = "workspace number 4";
        "${modifier}+5" = "workspace number 5";
        "${modifier}+6" = "workspace number 6";
        "${modifier}+7" = "workspace number 7";
        "${modifier}+8" = "workspace number 8";
        "${modifier}+9" = "workspace number 9";
        "${modifier}+0" = "workspace number 10";

        "${modifier}+Shift+1" = "move container to workspace number 1";
        "${modifier}+Shift+2" = "move container to workspace number 2";
        "${modifier}+Shift+3" = "move container to workspace number 3";
        "${modifier}+Shift+4" = "move container to workspace number 4";
        "${modifier}+Shift+5" = "move container to workspace number 5";
        "${modifier}+Shift+6" = "move container to workspace number 6";
        "${modifier}+Shift+7" = "move container to workspace number 7";
        "${modifier}+Shift+8" = "move container to workspace number 8";
        "${modifier}+Shift+9" = "move container to workspace number 9";
        "${modifier}+Shift+0" = "move container to workspace number 10";

        "${modifier}+d" = "exec '${swayworkspace}/bin/swayworkspace navigate next'";
        "${modifier}+a" = "exec '${swayworkspace}/bin/swayworkspace navigate prev'";

        "${modifier}+Shift+d" = "exec '${swayworkspace}/bin/swayworkspace move next'";
        "${modifier}+Shift+a" = "exec '${swayworkspace}/bin/swayworkspace move prev'";

        "${modifier}+p" = "exec ${drun}";

        "XF86MonBrightnessUp" = "exec ${pkgs.brightnessctl}/bin/brightnessctl set +10%";
        "XF86MonBrightnessDown" = "exec ${pkgs.brightnessctl}/bin/brightnessctl set 10%-";
        "XF86AudioLowerVolume" = "exec ${pkgs.pulsemixer}/bin/pulsemixer --change-volume -2";
        "XF86AudioRaiseVolume" = "exec ${pkgs.pulsemixer}/bin/pulsemixer --change-volume +2";
        "XF86AudioMute" = "exec ${pkgs.pulsemixer}/bin/pulsemixer --toggle-mute";
        "XF86AudioPlay" = "exec playerctl play-pause";
        "XF86AudioNext" = "exec playerctl next";
        "XF86AudioPrev" = "exec playerctl previous";

        "${modifier}+Shift+minus" = "move scratchpad";
        "${modifier}+minus" = "scratchpad show";

        "${modifier}+f" = "fullscreen toggle";
        "${modifier}+Shift+space" = "floating toggle";
        "${modifier}+space" = "focus mode_toggle";

        "${modifier}+b" = "bar mode toggle";

        "${modifier}+Shift+e" = "exec swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -b 'Yes, exit sway' 'swaymsg exit'";

        "${modifier}+Print" = "exec grim -o (swaymsg -t get_outputs | jq -r '.[] | select(.focused) | .name') (xdg-user-dir PICTURES)/(date +'%Y-%m-%d-%H%M%S_grim.png')";
        "${modifier}+Shift+Print" = "exec grim -g '(slurp)' (xdg-user-dir PICTURES)/(date +'%Y-%m-%d-%H%M%S_grim.png')";

        "${modifier}+Return" = "mode 'management'";
        "${modifier}+o" = "mode 'launcher'";

        "${modifier}+Shift+p" = "exec grim -g '(slurp -p)' -t ppm - | convert - -format '%[pixel:p{0,0}]' txt:- | tail -n 1 | cut -d ' ' -f 4 | wl-copy";
      };

      modes = {
        launcher = {
          b = "exec google-chrome-unstable ${chromeWaylandFlags}, mode 'default'";
          t = "exec flatpak run com.microsoft.Teams, mode 'default'";
          f = "exec firefox, mode 'default'";
          Return = "mode 'default'";
          Escape = "mode 'default'";
        };
      };

      output = {
        "*" = {
          background = "/home/me/Documents/Repositories/mine/nix-configs/wallpapers/912058.jpg fill";
        };
      };

      startup = [
        { command = "${pkgs.autotiling}/bin/autotiling"; always = true; }
        { command = "gsettings set org.gnome.desktop.interface font-name 'Fira Sans 11'"; always = true; }
        { command = "gsettings set org.gnome.desktop.interface icon-theme 'Adwaita'"; always = true; }
        { command = "gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita'"; always = true; }
        { command = "gsettings set org.gnome.desktop.interface cursor-theme 'Adwaita'"; always = true; }
        { command = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"; }
        { command = "swaymsg workspace 1"; } # make sure to start at workspace 1
      ];

      # bars = [{
      #   mode = "dock";
      #   hiddenState = "hide";
      #   position = "top";
      #   fonts = { names = [ "VictorMono Nerd Font" ]; size = 11.00; };
      #   workspaceButtons = true;
      #   workspaceNumbers = true;
      #   statusCommand = "i3status-rs ~/.config/i3status-rust/config-top.toml";
      #   trayOutput = "primary";
      #   extraConfig = ''
      #     height 30
      #   '';
      #   colors = {
      #     background = "#2E3440";
      #     statusline = "#839496";
      #     separator = "#777777";
      #     focusedWorkspace = {
      #       border = "#285577";
      #       background = "#285577";
      #       text = "#D8DEE9";
      #     };
      #     activeWorkspace = {
      #       border = "#333333";
      #       background = "#4C7899";
      #       text = "#D8DEE9";
      #     };
      #     inactiveWorkspace = {
      #       border = "#2E3440";
      #       background = "#2E3440";
      #       text = "#888888";
      #     };
      #     urgentWorkspace = {
      #       border = "#2F343A";
      #       background = "#900000";
      #       text = "#D8DEE9";
      #     };
      #     bindingMode = {
      #       border = "#2F343A";
      #       background = "#900000";
      #       text = "#D8DEE9";
      #     };
      #   };
      # }];

      bars = [{
        command = "waybar";
      }]; # remove the bar

    };
    extraConfig = ''
      mode 'management' {

        bindsym h resize shrink width 10px
        bindsym j resize grow width 10px
        bindsym k resize shrink width 10px
        bindsym l resize grow width 10px

        bindsym Left resize shrink width 10px
        bindsym Down resize grow height 10px
        bindsym Up resize shrink height 10px
        bindsym Right resize grow width 10px

        bindsym Ctrl+h mark --add "_swap", focus left, swap container with mark "_swap", focus left, unmark "_swap"
        bindsym Ctrl+j mark --add "_swap", focus down, swap container with mark "_swap", focus down, unmark "_swap"
        bindsym Ctrl+k mark --add "_swap", focus up, swap container with mark "_swap", focus up, unmark "_swap"
        bindsym Ctrl+l mark --add "_swap", focus right, swap container with mark "_swap", focus right, unmark "_swap"

        # Return to default mode
        bindsym Return mode "default"
        bindsym Escape mode "default"
      }
    '';
  };

  #### i3status-rust ####
  programs.i3status-rust.enable = true;
  programs.i3status-rust.bars.top = {
    settings = {
      theme = {
        name = "slick";
        overrides = {
          idle_bg = "#2e3440";
          idle_fg = "#839496";
          separator = "";
        };
      };
      icons = {
        name = "awesome5";
      };
    };
    blocks = [
      # {
      #   block = "memory";
      #   display_type = "memory";
      #   format_mem = "{mem_used}/{mem_total}({mem_used_percents})";
      #   format_swap = "{swap_used}/{swap_total}({swap_used_percents})";
      # }
      {
        block = "sound";
        on_click = "pavucontrol";
      }
      {
        block = "music";
        buttons = [ "play" "next" ];
        interface_name_exclude = [ ".*kdeconnect.*" "mpd" ];
        hide_when_empty = true;
      }
      {
        block = "networkmanager";
        on_click = "alacritty -e nmtui";
        interface_name_exclude = [ "br\\-[0-9a-f]{12}" "lxdbr\\d+" "lxcbr\\d+" ];
        ap_format = "";
      }
      {
        block = "time";
        interval = 60;
        format = "%a %d/%m %R";
      }
      {
        block = "battery";
        interval = 10;
        format = "{percentage} {time}";
      }
    ];
  };
  ########

  home.packages = with pkgs; [
    bemenu
    capitaine-cursors
    font-awesome
    glib
    gnome.adwaita-icon-theme
    gnome.nautilus
    gnome.networkmanagerapplet
    gnome.zenity
    grim
    imagemagick
    nwg-launchers
    nwg-menu
    nwg-panel
    papirus-icon-theme
    pavucontrol
    playerctl
    slurp
    sway-contrib.grimshot
    swayidle
    waybar
    wl-clipboard
    wl-color-picker
    xdg-user-dirs
  ];
}
