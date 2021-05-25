{ config, pkgs, ... }:
let
  terminal = "foot";
  wofi = "${pkgs.wofi}/bin/wofi -Iim";
  drun = "${wofi} --show drun";
  nwggrid = "${pkgs.nwg-launchers}/bin/nwggrid";
  swaylock = "${pkgs.swaylock}/bin/swaylock";
  swayworkspace = pkgs.writeShellScriptBin "swayworkspace" ''
    navigate(){
      currentWorkspace=$(swaymsg -t get_workspaces |jq ".[] | select(.focused).num")
      case $1 in
        "next")
          num=$((currentWorkspace+1))
          [ $num -ge 11 ] && num=1
          swaymsg workspace number $num;;
        "prev")
          num=$((currentWorkspace-1))
          [ $num -le 0 ] && num=10
          swaymsg workspace number $num;;
      esac
    }

    move(){
      currentWorkspace=$(swaymsg -t get_workspaces |jq ".[] | select(.focused).num")
      case $1 in
        "next")
          num=$((currentWorkspace+1))
          [ $num -ge 11 ] && num=1
          swaymsg move container to workspace number $num && navigate $1;;
        "prev")
          num=$((currentWorkspace-1))
          [ $num -le 0 ] && num=10
          swaymsg move container to workspace number $num && navigate $1;;
      esac
    }

    case $1 in
      "navigate")
        case $2 in
          "next")
            navigate next;;
          "prev")
            navigate prev;;
        esac;;
      "move")
        case $2 in
          "next")
            move next;;
          "prev")
            move prev;;
        esac;;
    esac

  '';

in
{
  xresources.properties = {
    "Xft.dpi" = 96;
  };
  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    xwayland = true;
    config = rec {
      modifier = "Mod4";
      inherit terminal;
      window.border = 4;
      gaps = {
        inner = 12;
      };
      keybindings = {
        "${modifier}+t" = "exec ${terminal}";
        "${modifier}+r" = "reload";
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
        "XF86AudioPlay" = "exec ${pkgs.playerctl}/bin/playerctl play-pause";
        "XF86AudioNext" = "exec ${pkgs.playerctl}/bin/playerctl next";
        "XF86AudioPrev" = "exec ${pkgs.playerctl}/bin/playerctl previous";

        "${modifier}+Shift+minus" = "move scratchpad";
        "${modifier}+minus" = "scratchpad show";

        "${modifier}+f" = "fullscreen toggle";
        "${modifier}+Shift+space" = "floating toggle";
        "${modifier}+space" = "focus mode_toggle";

        "${modifier}+b" = "bar mode toggle";

        "${modifier}+Shift+e" = "exec swaynag -t warning -m 'You pressed the exit shortcut. Do you really want to exit sway? This will end your Wayland session.' -b 'Yes, exit sway' 'swaymsg exit'";
      };

      output = {
        "*" = {
          background = "/etc/nixos/wallpapers/1140673.jpg fill";
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
      bars = [{
        mode = "dock";
        hiddenState = "hide";
        position = "top";
        fonts = { names = [ "monospace" ]; size = 9.00; };
        workspaceButtons = true;
        workspaceNumbers = true;
        statusCommand = "i3status-rs ~/.config/i3status-rust/config-top.toml";
        trayOutput = "primary";
        colors = {
          background = "#2E3440";
          statusline = "#839496";
          separator = "#777777";
          focusedWorkspace = {
            border = "#4C7899";
            background = "#285577";
            text = "#D8DEE9";
          };
          activeWorkspace = {
            border = "#333333";
            background = "#4C7899";
            text = "#D8DEE9";
          };
          inactiveWorkspace = {
            border = "#3B4252";
            background = "#2E3440";
            text = "#888888";
          };
          urgentWorkspace = {
            border = "#2F343A";
            background = "#900000";
            text = "#D8DEE9";
          };
          bindingMode = {
            border = "#2F343A";
            background = "#900000";
            text = "#D8DEE9";
          };
        };
      }];

    };
  };

  programs.i3status-rust.enable = true;
  programs.i3status-rust.bars.top = {
    settings = {
      theme = "slick";
      overrides = {
        idle_bg = "#2e3440";
        idle_fg = "#839496";
        separator = "";

      };
    };
    icons = "awesome5";
    blocks = [
      {
        block = "memory";
        display_type = "memory";
        format_mem = "{mem_used_percents}";
        format_swap = "{swap_used_percents}";
      }
      {
        block = "cpu";
        format = "{utilization} {frequency}";
      }
      {
        block = "temperature";
        collapsed = false;
        interval = 1;
        format = "{max}";
        chip = "k10temp-*";
        idle = 70;
        info = 75;
        warning = 80;
      }
      {
        block = "sound";
        on_click = "pavucontrol";
      }
      {
        block = "music";
        buttons = [ "play" "next" ];
        interface_name_exclude = [ "mpd" ];
      }
      {
        block = "networkmanager";
        on_click = "alacritty -e nmtui";
        interface_name_exclude = [ "br\\-[0-9a-f]{12}" "lxdbr\\d+" "lxcbr\\d+" ];
      }
      {
        block = "time";
        interval = 60;
        format = "%a %d/%m %R";
      }
    ];
  };

  home.packages = with pkgs; [
    swayidle
    glib
    capitaine-cursors
    pavucontrol
    bemenu
    gnome.nautilus
    gnome.networkmanagerapplet
    gnome.adwaita-icon-theme
    wl-clipboard
  ];
}
