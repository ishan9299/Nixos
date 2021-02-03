{ pkgs, ... }: {

  home.packages = with pkgs; [
    dmenu
  ];

  xsession = {
    enable = false;
    windowManager = {
      awesome.enable = false;
      xmonad = {
        enable = false;
        enableContribAndExtras = false;
        config = ./xmonad/xmonad.hs;
      };
    };
  };

  xdg.configFile."awesome/rc.lua".source = ./awesome/rc.lua;
  xdg.configFile."awesome/theme.lua".source = ./awesome/theme.lua;

}
