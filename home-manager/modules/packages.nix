{ config, pkgs, ... }:
{
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    # fonts
    (nerdfonts.override {
      fonts =
        [
          "Monofur"
          "FiraCode"
          "JetBrainsMono"
          "Mononoki"
          "VictorMono"
        ];
    })
    corefonts
    fira
    input-fonts
    iosevka-bin
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    open-sans
    recursive
    vistafonts

    # programs-cli
    acpi
    binutils
    catimg
    chrome-export
    coreutils
    curl
    dmidecode
    dosfstools
    fd
    ffmpeg
    file
    git
    git-crypt
    gitAndTools.gitui # I still kinda need it for the root folder
    gitui
    gnupg
    jq
    less
    lm_sensors
    lshw
    luaformatter
    luaformatter
    luajitPackages.luacheck
    mmv
    musikcube
    neofetch
    neovim
    neovim-remote
    nixpkgs-fmt
    nnn
    pciutils
    ripgrep
    ripgrep
    trash-cli
    tree
    tree-sitter
    unrar
    unzip
    usbutils
    wget
    whois
    wirelesstools
    wl-clipboard
    youtube-dl

    # programs-gui
    # firefox
    contrast
    qbittorrent
    vscode-fhs
    zathura
  ];
}
