{
  xsession.windowManager.xmonad = {
    enable = true;
    enableContribAndExtras = true;
    config = pkgs.writeText "xmonad.hs" ''
      import XMonad
      main = xmonad defaultConfig
      { terminal = "urxvt"
      , modMask = mod4Mask
      , borderWidth = 3
      }
      ''
  }
}
