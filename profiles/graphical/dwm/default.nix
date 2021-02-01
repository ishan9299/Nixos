{ config, pkgs, lib, ... }:
{
  services.xserver.windowManager.dwm.enable = true;
  services.dwm-status.enable = true;
}
