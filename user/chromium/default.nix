{ pkgs, ... }:
{
  programs.chromium = {
    enable = true;
    package = pkgs.chromiumDev;
    extensions = [
      { id = "dbepggeogbaibhgnhhndojpepiihcmeb"; } # vimium
      { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # ublock-origin
      { id = "gcbommkclmclpchllfjekcdonpmejbdp"; } # https-everywhere
      { id = "ebamaffgiechnomghfojkmlkaipoadni"; } # hide-likes
    ];
  };
}
