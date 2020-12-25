{ lib, pkgs, ... }:
let inherit (builtins) readFile;
in {
  users.defaultUserShell = pkgs.fish;

  programs.fish = {
    enable = true;
    promptInit = ''
      ${pkgs.starship}/bin/starship init fish | source
    '';
    interactiveShellInit = ''

      #------------ Disable the greeting -----------+
      set fish_greeting

      #------------ cd on quit for nnn -------------+
      ${readFile ./functions/n.fish}

      #------------ neovim-remote configuration ----+
      if test -n "$NVIM_LISTEN_ADDRESS"
        alias nvim "nvr -cc split --remote-wait +'set bufhidden=wipe'"
        export VISUAL="nvr -cc split --remote-wait +'set bufhidden=wipe'"
        export EDITOR="nvr -cc split --remote-wait +'set bufhidden=wipe'"
      else
        export VISUAL="nvim"
        export EDITOR="nvim"
      end
    '';
    shellAliases = {
      "ls" = "exa -GB1 --icons";
      "ll" = "exa -abghHliS --icons";
      "cat" = "bat";
      "grep" = "rg";};
  };
}
