{
  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
    enableBashIntegration = true;
    defaultCommand = "fd --type file --hidden --follow --no-ignore-vcs";
    defaultOptions = [ "--layout=reverse" "--info=inline" ];
    #-- ALT-C
    changeDirWidgetCommand = "fd --type d -H ";
    #-- CTRL-T
    fileWidgetCommand = "fd . --type f";
    #-- CTRL-R
    historyWidgetOptions = [ "--sort" "--exact" ];
  };
}
