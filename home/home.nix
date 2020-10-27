{ config, pkgs, ... }:

{
# Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  home.packages = [

# Applications
      pkgs.hexchat
      pkgs.qbittorrent

#CLI
      pkgs.neofetch
      pkgs.nnn
      pkgs.imagemagick
      pkgs.optipng
      pkgs.trash-cli
      pkgs.poppler_utils
      pkgs.atool

# Rust Programs
      pkgs.ripgrep
      pkgs.fd
      pkgs.exa
      pkgs.hyperfine
      pkgs.du-dust # dust
      pkgs.procs # procs
      pkgs.tealdeer # tldr
      pkgs.gitAndTools.gitui

#Music
      pkgs.musikcube
      pkgs.cava
      pkgs.youtube-dl

      ];

  home.username = "me";
  home.homeDirectory = "/home/me";

  home.sessionVariables = {
    EDITOR="nvim";
    MOZ_ENABLE_WAYLAND=1;
  };

  home.sessionVariables = {
    LANG = "en_US.UTF-8";
  };

# Programs and their configurations
  programs.mpv = {
    enable = false;
  };

  programs.bat = {
    enable = true;
    config = {
      theme = "Solarized (light)";
    };
  };

  programs.direnv = {
    enable = true;
    enableFishIntegration = true;
    enableBashIntegration = true;
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    enableBashIntegration = true;
  };

  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
    enableBashIntegration = true;
    defaultCommand = "fd --type file --hidden --follow --no-ignore-vcs";
    defaultOptions = [ "--layout=reverse" "--info=inline" ];
# ALT-C
    changeDirWidgetCommand = "fd --type d -H ";
# CTRL-T
    fileWidgetCommand = "fd . --type f";
# CTRL-R
    historyWidgetOptions = [ "--sort" "--exact" ];
  };

  programs.nushell = {
    enable = true;
  };

  programs.tmux = {
    enable = true;
    baseIndex = 1;
    keyMode = "vi";
    escapeTime = 0;
    customPaneNavigationAndResize = true;
    sensibleOnTop = false;
    terminal = "screen-256color";
    extraConfig = ''
#+--------- Random Config -------+
      set-option -g mouse on
      set-option -sa terminal-overrides ',xterm-256color*:Tc'
      set -g status-left ""
      set -g status-right ""

#+------- Split Windows -------+
      bind-key | split-window -h -c '#{pane_current_path}' # normally prefix-%
      bind-key '\' split-window -h -c '#{pane_current_path}' # normally prefix-%
      bind-key - split-window -v -c '#{pane_current_path}' # normally prefix-"

#+------- Automatically set window title ---------+
      set-window-option -g automatic-rename on
      set-option -g set-titles on
      set-option -g renumber-windows on

#+------- Setting a quick way to reload config ---------+
      bind r source-file ~/.tmux.conf \; display-message "Config reloaded..."

#+------- Vim keys for navigating panes ----------+
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

#+---------- Alignment ----------+
      set -g status-style bg=default
      set -g status-style fg=white
      set-window-option -g window-status-current-style fg=green
      set-option -g status-justify centre
      set -g window-status-current-format "[#I:#W]"
      set -g window-status-format "[#I:#W]"
      '';
  };

  programs.fish = {
    enable = true;
    shellAliases = {
      "ls" = "exa -GB1 --icons";
      "ll" = "exa -abghHliS --icons";
      "htop" = "btm";
    };
    shellInit = ''
      set PATH $HOME/.local/bin $HOME/.local/npm/bin $HOME/.local/Goneovim $HOME/.cargo/bin $PATH
      set PATH /var/lib/flatpak/exports/bin $PATH

#--- nix
      #if test -e /home/me/.nix-profile/etc/profile.d/nix.sh
      #  bass source /home/me/.nix-profile/etc/profile.d/nix.sh
      #end

      #export NIX_PATH=$HOME/.nix-defexpr/channels:$NIX_PATH

#---- For nixpkgs make sure glibcLocales is installed with the nixpkgs or home manager (for non Nixos)
      # export LOCALE_ARCHIVE=$HOME/.nix-profile/lib/locale/locale-archive

#---- NNN settings
      export NNN_OPTS="eRHdF"
      export NNN_TRASH=1
      export NNN_FIFO=/tmp/nnn.fifo
      export NNN_ARCHIVE="\\.(7z|a|ace|alz|arc|arj|bz|bz2|cab|cpio|deb|gz|jar|lha|lz|lzh|lzma|lzo|rar|rpm|rz|t7z|tar|tbz|tbz2|tgz|tlz|txz|tZ|tzo|war|xpi|xz|Z|zip)"
          '';

    functions = {

      n = {
        description = "support nnn quit and change directory";
        wraps = "nnn";
        body = ''
          if test -n "$NNNLVL"
            if [ (expr $NNNLVL + 0) -ge 1 ]
              echo "nnn is already running"
                return
            end
          end

          if test -n "$XDG_CONFIG_HOME"
            set -x NNN_TMPFILE "$XDG_CONFIG_HOME/nnn/.lastd"
          else
            set -x NNN_TMPFILE "$HOME/.config/nnn/.lastd"
          end


          nnn $argv

          if test -e $NNN_TMPFILE
            source $NNN_TMPFILE
            rm $NNN_TMPFILE
          end
                        '';
      };

    };

    plugins = [
    {
      name = "bass";
      src = pkgs.fetchFromGitHub {
        owner = "edc";
        repo = "bass";
        rev = "50eba266b0d8a952c7230fca1114cbc9fbbdfbd4";
        sha256 = "0ppmajynpb9l58xbrcnbp41b66g7p0c9l2nlsvyjwk6d16g4p4gy";
      };
    }
    ];
  };

  programs.bash.enable = true;

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };

# This value determines the Home Manager release that your
# configuration is compatible with. This helps avoid breakage
# when a new Home Manager release introduces backwards
# incompatible changes.
#
# You can update Home Manager without changing this value. See
# the Home Manager release notes for a list of state version
# changes in each release.
  home.stateVersion = "20.09";
}
