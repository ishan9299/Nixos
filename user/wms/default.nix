{ pkgs, ... }: {

  home.packages = with pkgs; [
    dmenu
  ];

  xsession = {
    enable = true;
    windowManager = {
      awesome.enable = true;
      xmonad = {
        enable = true;
        enableContribAndExtras = true;
        config = ./xmonad.hs;
      };
    };
  };

  xdg.configFile."awesome/rc.lua".source = ./rc.lua;
  xdg.configFile."awesome/theme.lua".source = ./theme.lua;

}
