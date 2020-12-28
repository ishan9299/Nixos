{ pkgs, ... }: {
  imports = [ ./fish ./tmux ];

  environment.systemPackages = with pkgs; [
    # CLI
    file
    git-crypt
    gnupg
    less
    ncdu
    tokei
    wget
    dash
    # clang_10
    gcc10
    gdbgui
    clang-tools
    nixfmt
    neovim-nightly
    neovim-remote
    gitAndTools.gitui # I still kinda need it for the root folder
    nodejs

  ];

  fonts.fonts = with pkgs; [
    (nerdfonts.override {
      fonts =
        [ "FiraCode" "Iosevka" "JetBrainsMono" "Hasklig" "Monoid" ];
    })
  ];
}
