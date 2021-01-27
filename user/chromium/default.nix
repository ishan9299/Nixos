{ pkgs, ... }:
{
  programs.chromium = {
    enable = true;
    package = pkgs.ungoogled-chromium;
    extensions = [
      { id = "dbepggeogbaibhgnhhndojpepiihcmeb"; } # vimium
      { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # ublock-origin
      { id = "gcbommkclmclpchllfjekcdonpmejbdp"; } # https-everywhere
      { id = "ebamaffgiechnomghfojkmlkaipoadni"; } # hide-likes
    ];
  };
}
