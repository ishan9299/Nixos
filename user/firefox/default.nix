{ config, pkgs, ... }: {
  nixpkgs.config.packageOverrides = pkgs: {
    nur = import (builtins.fetchTarball
      "https://github.com/nix-community/NUR/archive/master.tar.gz") {
        inherit pkgs;
      };
  };
  programs.firefox = {
    enable = true;
    package = pkgs.firefox-wayland;
    extensions = lib.mkIf config.programs.firefox.enable
      (with pkgs.nur.repos.rycee.firefox-addons; [
        https-everywhere
        privacy-badger
        ublock-origin
        vimium
      ]);
  };
}
