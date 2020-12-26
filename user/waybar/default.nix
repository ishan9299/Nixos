{
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings = [{
      layer = "top";
      position = "top";
      height = 30;
      output = [ "eDP-1" "HDMI-A-1" ];
      modules-left = [ "sway/workspaces" "sway/mode" "wlr/taskbar" ];
      modules-center = [ "sway/window" ];
      modules-right = [ "temperature" ];
      modules = {
        "sway/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
        };
      };
    }];
  };
}
