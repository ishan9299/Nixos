{
  programs.zsh = {
    enable = true;
    enableAutosuggestion = true;
    enableCompletion = true;
    autocd = true;
    defaultKeymaps = "viins";
    dotDir = ".config/zsh";
    history.ignoreDups = true;
    history.path = "${config.xdg.dataHome}/zsh/zsh_history";
    shellAliases = {
      "grep" = "rg";
    };
  };
}
