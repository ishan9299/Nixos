{ pkgs, lib, ... }:
let inherit (builtins) readFile;
in
{
  programs.tmux = {
    enable = true;
    baseIndex = 1;
    keyMode = "vi";
    escapeTime = 0;
    customPaneNavigationAndResize = true;
    terminal = "tmux";
    extraConfig = ''
      ${readFile ./tmux.conf}
    '';
  };
}
