{ pkgs, ... }:
{
  programs.chromium = {
    enable = true;
    package = pkgs.chromium;
    extensions = [
      { id = "dbepggeogbaibhgnhhndojpepiihcmeb"; } # vimium
      { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # ublock-origin
      { id = "gcbommkclmclpchllfjekcdonpmejbdp"; } # https-everywhere
      { id = "ebamaffgiechnomghfojkmlkaipoadni"; } # hide-likes
    ];
  };
}
