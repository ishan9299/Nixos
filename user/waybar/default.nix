{
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings = [{
      layer = "top";
      position = "top";
      height = 30;

      modules-left = [
        "sway/mode"
        "sway/workspaces"
      ];

      modules-center = [
      ];

      modules-right = [
      ];

      modules = {
        "sway/mode" = { tooltip = false; };
        "sway/workspaces" = {
          "persistent_workspaces" = {
            "1" = [];
            "2" = [];
            "3" = [];
            "4" = [];
          };
        };
      };
    }];
  };
}
