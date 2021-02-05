{ config, pkgs, ... }: {
  programs.firefox = {
    enable = false;
    package = pkgs.firefox-bin;
    extensions = pkgs.lib.mkIf config.programs.firefox.enable
      (with pkgs.nur.repos.rycee.firefox-addons; [
        https-everywhere
        privacy-badger
        ublock-origin
        vimium
      ]);
  };
}
