{ lib, pkgs, ... }:
let inherit (builtins) readFile;
in {
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    keyMode = "vi";
    escapeTime = 0;
    customPaneNavigationAndResize = true;
    terminal = "screen-256color";
    extraConfig = ''
      ${readFile ./tmux.conf}
    '';
  };
}
