{ pkgs, lib, ... }:
let inherit (builtins) readFile;
in
{
  users.defaultUserShell = pkgs.fish;

  programs.fish = {
    enable = true;

    vendor = {
      functions.enable = true;
      completions.enable = true;
    };

    interactiveShellInit = ''

      #------------ Disable the greeting -----------+
      set fish_greeting

      #---- NNN settings ---------------------------+
      export NNN_OPTS="eRHdF"
      export NNN_TRASH=1
      export NNN_FIFO=/tmp/nnn.fifo
      export NNN_ARCHIVE="\\.(7z|a|ace|alz|arc|arj|bz|bz2|cab|cpio|deb|gz|jar|lha|lz|lzh|lzma|lzo|rar|rpm|rz|t7z|tar|tbz|tbz2|tgz|tlz|txz|tZ|tzo|war|xpi|xz|Z|zip)"
      export NNN_PLUG="p:preview-tui"

      #------------ cd on quit for nnn -------------+
      ${readFile ./functions/n.fish}

      #----------- my prompt for fish --------------+
      ${readFile ./functions/fish_prompt.fish}

      #----------- my fish colorsceheme ------------+
      ${readFile ./functions/_my_colors.fish}

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
      "ls" = "exa -GB1";
      "ll" = "exa -abghHliSG";
      "grep" = "rg";
    };
  };
}
