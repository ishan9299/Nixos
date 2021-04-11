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

    nixpkgs-fmt

    # neovim
    neovim-nightly
    neovim-remote

    # git
    gitAndTools.gitui # I still kinda need it for the root folder

    #cmake
    cmake

		tree-sitter
  ];

  fonts.fonts = with pkgs; [
    (nerdfonts.override {
      fonts =
        [
          "Go-Mono"
          "Hasklig"
          "InconsolataGo"
        ];
    })
  ];
}
