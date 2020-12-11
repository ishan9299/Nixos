{ pkgs, inputs, ... }:
let
  hostname = "VivoBook";
in
{
  imports = [
    ./hardware-configuration.nix
    ../../profiles/core
    ../../profiles/develop
    ../../profiles/graphical
    ../../profiles/laptop
    ../../profiles/network
    ../../profiles/virt
  ];
}
