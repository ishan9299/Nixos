{ pkgs, ... }: {
  home.packages = with pkgs; [
    dmenu
  ];
  xsession = {
    enable = false;
    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      config = ./xmonad.hs;
    };
  };
}
