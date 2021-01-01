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
    gcc10
    gdbgui
    nixfmt

    # neovim
    neovim-nightly
    neovim-remote

    # git
    gitAndTools.gitui # I still kinda need it for the root folder
  ];

  fonts.fonts = with pkgs; [
    (nerdfonts.override {
      fonts =
        [ "FiraCode" "Iosevka" "JetBrainsMono" "Hasklig" "Monoid" ];
    })
  ];
}
