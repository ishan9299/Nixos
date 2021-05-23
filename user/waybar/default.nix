{ config, pkgs, ... }:
{
  programs.waybar = {
    enable = true;
    settings = [{
      layer = "top";
      position = "top";
      modules-left = [
        "sway/mode"
        "sway/workspaces"
      ];
      modules-center = [ ];
      modules-right =
        [
          "idle_inhibitor"
          "tray"
          "network"
          "cpu"
          "memory"
          "backlight"
          "pulseaudio"
          "clock"
          "battery"
        ];

      modules =
        {
          "sway/workspaces" = {
            all-outputs = true;
            disable-scroll-wraparound = true;
            #enable-bar-scroll = true;
          };
          "sway/mode" = { tooltip = false; };

          idle_inhibitor = {
            format = "{icon}";
            format-icons = {
              activated = "unlocked";
              deactivated = "locking";
            };
          };
          pulseaudio = {
            format = "vol {volume}%";
            #on-click-middle = "${pkgs.sway}/bin/swaymsg exec \"${pkgs.alacritty}/bin/alacritty -e pulsemixer\"";
            on-click-middle = "${pkgs.sway}/bin/swaymsg exec \"${pkgs.pavucontrol}/bin/pavucontrol\"";
          };
          network = {
            format-wifi = "{essid} {signalStrength}% {bandwidthUpBits} {bandwidthDownBits}";
            format-ethernet = "{ifname} eth {bandwidthUpBits} {bandwidthDownBits}";
          };
          cpu.interval = 2;
          cpu.format = "cpu {load}% {usage}%";
          memory.format = "mem {}%";
          backlight = {
            format = "nit {percent}%";
            on-scroll-up = "${pkgs.brightnessctl}/bin/brightnessctl set 2%+";
            on-scroll-down = "${pkgs.brightnessctl}/bin/brightnessctl set 2%-";
          };
          tray.spacing = 10;
          clock.format = "{:%a %b %d %H:%M}";
          battery = {
            format = "bat {}";
            bat = "BAT0";
          };
        };
    }];
  };
}
