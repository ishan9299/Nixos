{
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings = [{
      layer = "top";
      position = "top";
      height = 30;

      modules-left = [ "sway/mode" "sway/workspaces" ];

      modules-center = [ "clock" ];

      modules-right = [ "pulseaudio" "network" "battery" ];

      modules = {
        "sway/mode" = { "format" = ''<span style="italic">{}</span>''; };
        "sway/workspaces" = {
          "disable-scroll" = true;
          "all-outputs" = true;
          "persistent_workspaces" = {
            "1" = [ ];
            "2" = [ ];
            "3" = [ ];
            "4" = [ ];
            "5" = [ ];
          };
          "format-icons" = {
            "1" = "𑁧";
            "2" = "𑁨";
            "3" = "𑁩";
            "4" = "𑁪";
            "5" = "𑁫";
            "focused" = "";
            "urgent" = "";
            "default" = "";
          };
          "icon-size" = 15;
        };
        "clock" = {
          "tooltip-format" = ''
            <big>{:%Y %B}</big>
            <tt><small>{calendar}</small></tt>'';
          "format-alt" = "{:%Y-%m-%d}";
        };

        "pulseaudio" = {
          "scroll-step" = 1; # %; can be a float
          "format" = "{icon}";
          "format-bluetooth" = "{volume}% {icon} {format_source}";
          "format-bluetooth-muted" = " {icon} {format_source}";
          "format-muted" = " {format_source}";
          "format-source" = "{volume}% ";
          "format-source-muted" = "";
          "format-icons" = {
            "headphone" = "";
            "hands-free" = "";
            "headset" = "";
            "phone" = "";
            "portable" = "";
            "car" = "";
            "default" = [
              ""
              "   -"
              "   --"
              "   ---"
              "   ----"
              "   -----"
              "   ------"
              "   -------"
              "   --------"
              "   ---------"
              "   ----------"
              "   -----------"
              "   ------------"
              "   -------------"
              "   --------------"
            ];
          };
          "on-click" = "pavucontrol";
        };

        "network" = {
          "format-wifi" = "{essid} ({signalStrength}%) ";
          "format-ethernet" = "{ifname} = {ipaddr}/{cidr} ";
          "format-linked" = "{ifname} (No IP) ";
          "format-disconnected" = "Disconnected ⚠";
          "format-alt" = "{ifname} = {ipaddr}/{cidr}";
        };

        "battery" = {
          "states" = {
            "good" = 95;
            "warning" = 30;
            "critical" = 15;
          };
          "format" = "{capacity}% {icon}";
          "format-charging" = "{capacity}% ";
          "format-plugged" = "{capacity}% ";
          "format-alt" = "{time} {icon}";
          "format-icons" = [ "" "" "" "" "" ];
        };

      };
    }];
  };
}
