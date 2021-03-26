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
    (nerdfonts.override {
      fonts =
        [
          "FiraCode"
          "Agave"
        ];
      })
    ];
}
