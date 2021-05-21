{ pkgs, lib, ... }: {
  imports = [ ./fish ];

  environment.systemPackages = with pkgs; [
    file
    ripgrep
    emacsPgtk
    tree
    git-crypt
    nnn
    bless
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
    # neovim-remote
    tree-sitter

    # vscodium
    vscodium-fhs

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
