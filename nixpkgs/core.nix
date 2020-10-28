{ config, pkgs, ... }:

{
  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
        experimental-features = nix-command flakes ca-references
    '';
  };

  # Network Manager
  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.enable = true;

   environment = {
     shellAliases = {
       "ls" = "exa -GB1 --icons";
       "ll" = "exa -abghHliS --icons";
     };

     shellInit = ''
       export PATH=$HOME/.local/bin:$HOME/.local/npm/bin:$HOME/.cargo/bin:/var/
 lib/flatpak/exports/bin:$PATH

  #---- NNN settings
       export NNN_OPTS="eRHdF"
       export NNN_TRASH=1
       export NNN_FIFO=/tmp/nnn.fifo
       export NNN_ARCHIVE="\\.(7z|a|ace|alz|arc|arj|bz|bz2|cab|cpio|deb|gz|jar|lha|lz|lzh|lzma|lzo|rar|rpm|rz|t7z|tar|tbz|tbz2|tgz|tlz|txz|tZ|tzo|war|xpi|xz|Z|zip)"
     '';

     systemPackages = with pkgs; [
  #---- CLI
        neofetch
        wget
        file
        nnn
        trash-cli
        atool
        neovim-nightly

  #---- Rust Programs
        ripgrep
        fd
        exa
        hyperfine
        du-dust # dust
        procs # procs
        tealdeer # tldr
        gitAndTools.gitui

  #---- Music
        musikcube
        cava
        youtube-dl
     ];
   };




  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    keyMap = "us";
  };

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";
}
