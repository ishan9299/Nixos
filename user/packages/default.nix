{ config, pkgs, ... }:
{
  home.packages = with pkgs; [
    source-code-pro
  ];
}
