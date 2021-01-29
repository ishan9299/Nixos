{ pkgs, ... }: {
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
    nixfmt

    # neovim
    neovim-nightly
    neovim-remote

    # git
    gitAndTools.gitui # I still kinda need it for the root folder
  ];

  services.mysql = {
    enable = true;
    package = pkgs.mysql;
  };

  fonts.fonts = with pkgs; [
    (nerdfonts.override {
      fonts =
        [ "JetBrainsMono" "Hasklig" "Iosevka" "Go-Mono" ];
    })
  ];
}
