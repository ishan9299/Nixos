{ pkgs, ... }: {

  home.packages = with pkgs; [
    dmenu
  ];

  xsession = {
    enable = true;
    windowManager = {
      awesome.enable = false;
      xmonad = {
        enable = true;
        enableContribAndExtras = true;
        config = ./xmonad/xmonad.hs;
      };
    };
  };

  xdg.configFile."awesome/rc.lua".source = ./awesome/rc.lua;
  xdg.configFile."awesome/theme.lua".source = ./awesome/theme.lua;

}
