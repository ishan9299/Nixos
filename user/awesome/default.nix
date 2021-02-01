{ pkgs, ... }: {
  home.packages = with pkgs; [
    dmenu
  ];
  xsession = {
    enable = false;
    windowManager.awesome = {
      enable = true;
    };
  };
  xdg.configFile."awesome/rc.lua".source = ./rc.lua;
  xdg.configFile."awesome/theme.lua".source = ./theme.lua;
}
