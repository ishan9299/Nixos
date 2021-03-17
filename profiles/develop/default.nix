{ pkgs, lib, ... }: {
  imports = [ ./fish ./tmux ];

  environment.systemPackages = with pkgs; [
    file
    git-crypt
    gnupg
    less
    ncdu
    tokei
    wget
    dash

    # C/C++
    gdbgui
    nixpkgs-fmt
    qtcreator

    # neovim
    neovim
    neovim-remote

    # git
    gitAndTools.gitui # I still kinda need it for the root folder

    #cmake
    cmake
    cmakeWithGui
  ];

  fonts.fonts = with pkgs; [
    sudo-font
    nanum-gothic-coding
    (nerdfonts.override {
      fonts =
        [
          "FiraCode"
          "Hasklig"
          "UbuntuMono"
          "Agave"
          "Terminus"
          "VictorMono"
        ];
      })
    ];
}
