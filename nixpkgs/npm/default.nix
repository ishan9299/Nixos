{ lib, pkgs, ... }:
{
  programs.npm = {
    enable = true;
    npmrc = "prefix = $(HOME)/.local/npm/bin\n";
  };
}
