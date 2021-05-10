{ pkgs, lib, ... }: {
  imports = [ ./fish ];

  environment.systemPackages = with pkgs; [
    file
    git-crypt
    gnupg
    less
    ncdu
    tokei
    luaformatter
    wget
    dash

    nixpkgs-fmt

    # neovim
    neovim
    luajitPackages.luacheck
    luaformatter
    neovim-remote

    # git
    gitAndTools.gitui # I still kinda need it for the root folder

    #cmake
    cmake
  ];

  fonts.fonts = with pkgs; [
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
  ];
}
