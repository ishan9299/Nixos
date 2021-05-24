{ config, pkgs, ... }:
{
  fonts.fontconfig.enable = true;
  home.packages = with pkgs; [
    # fonts
    (nerdfonts.override {
      fonts =
        [
          "Go-Mono"
          "Hack"
          "Hasklig"
          "Hermit"
          "InconsolataGo"
          "Iosevka"
          "Meslo"
          "VictorMono"
        ];
    })
    # programs
    musikcube
    neofetch
    gitui

    trash-cli
    contrast
    youtube-dl
    ffmpeg
    qbittorrent
    unrar
    catimg
    lshw
    wl-clipboard
    htop
    dmidecode
    unzip
  ];
}
