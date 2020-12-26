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
    # clang_10
    gcc10
    # clang-tools
    nixfmt
    neovim-nightly
    neovim-remote
    gitAndTools.gitui # I still kinda need it for the root folder
    nodejs

    #Editors
    vscode
    gnvim-unwrapped # the default one comes with neovim-stable so avoid that
  ];

  fonts.fonts = with pkgs; [
    (nerdfonts.override {
      fonts =
        [ "FiraCode" "Iosevka" "JetBrainsMono" "Hasklig" "Monoid" ];
    })
  ];
}
