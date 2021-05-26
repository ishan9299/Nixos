{ config, pkgs, ... }:
{
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    # fonts
    corefonts
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    ibm-plex
    fira
    office-code-pro
    # input-fonts
    open-sans
    (nerdfonts.override {
      fonts =
        [
          "Hack"
          "FiraMono"
          "Iosevka"
          "VictorMono"
        ];
    })
    # programs-cli
    musikcube
    neofetch
    gitui
    trash-cli
    youtube-dl
    file
    ripgrep
    tree
    ffmpeg
    nnn
    nixpkgs-fmt
    tree-sitter
    luaformatter
    less
    luajitPackages.luacheck
    gitAndTools.gitui # I still kinda need it for the root folder
    wget
    unrar
    git-crypt
    catimg
    lshw
    luaformatter
    neovim
    gnupg
    wl-clipboard
    htop
    dmidecode
    unzip
    binutils
    coreutils
    curl
    dosfstools
    mmv
    fd
    git
    jq
    ripgrep
    whois
    acpi
    lm_sensors
    wirelesstools
    pciutils
    usbutils
    chrome-export
    # programs-gui
    contrast
    vscodium-fhs
    bless
    emacsPgtk
    qbittorrent
  ];
}
