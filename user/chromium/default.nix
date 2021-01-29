{ pkgs, ... }:
{
  programs.chromium = {
    enable = false;
    package = pkgs.chromium;
    extensions = [
      { id = "dbepggeogbaibhgnhhndojpepiihcmeb"; } # vimium
      { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # ublock-origin
      { id = "gcbommkclmclpchllfjekcdonpmejbdp"; } # https-everywhere
      { id = "ebamaffgiechnomghfojkmlkaipoadni"; } # hide-likes
    ];
  };
}
