{ config, lib, pkgs, ... }:
let inherit (lib) fileContents;

in {
  # Network Manager
  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;

  environment = {
    shellAliases = {
      "ls" = "exa -GB1 --icons";
      "ll" = "exa -abghHliS --icons";
      "cat" = "bat";
      "grep" = "rg";
    };

    shellInit = ''
           export PATH=$HOME/.local/bin:$HOME/.local/npm/bin:$HOME/.cargo/bin:/var/lib/flatpak/exports/bin:$PATH

           export EDITOR="nvim"
           export VISUAL="nvim"

      #---- NNN settings
           export NNN_OPTS="eRHdF"
           export NNN_TRASH=1
           export NNN_FIFO=/tmp/nnn.fifo
           export NNN_ARCHIVE="\\.(7z|a|ace|alz|arc|arj|bz|bz2|cab|cpio|deb|gz|jar|lha|lz|lzh|lzma|lzo|rar|rpm|rz|t7z|tar|tbz|tbz2|tgz|tlz|txz|tZ|tzo|war|xpi|xz|Z|zip)"
           export NNN_PLUG="p:preview-tui"

      #+---- Starship Config ------+#
      export STARSHIP_CONFIG=${
        pkgs.writeText "starship.toml" (fileContents ./starship.toml)
      }
    '';

    systemPackages = with pkgs; [
      #---- CLI
      wget
      file
      tree
      catimg
      unzip
      nnn
      bpytop
      trash-cli
      atool
      freerdp

      #---- Rust Programs
      ripgrep
      fd
      exa
      hyperfine
      du-dust # dust
      procs # procs
      tealdeer # tldr

      #---- Music
      cava
      youtube-dl

      #---- Programming
      clang_10
      gcc10
      clang-tools
      nixfmt
      neovim-nightly
      neovim-remote
      gitAndTools.gitui # I still kinda need it for the root folder
      nodejs
    ];
  };

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = { keyMap = "us"; };

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";
}
