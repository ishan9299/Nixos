{ config, pkgs, ... }:
{
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    keyMode = "vi";
    escapeTime = 0;
    customPaneNavigationAndResize = true;
    terminal = "tmux-256color";
    extraConfig = ''
      ${builtins.readFile ./tmux.conf}
    '';
  };
}
