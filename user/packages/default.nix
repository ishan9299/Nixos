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
  ];
}
