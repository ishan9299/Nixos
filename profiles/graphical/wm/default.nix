{ config, pkgs, ... }: {
  environment = {
    systemPackages = with pkgs; [
      river
      swaybg
      light
      pamixer
      playerctl
      wofi
      waybar
    ];
  };
}
