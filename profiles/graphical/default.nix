{ pkgs, ... }:
{
  imports = [
    ./gnome
    # ./wm/sway
    ./wm/awesome
  ];

  hardware.pulseaudio = {
    enable = false;
  };

  environment = {
    systemPackages = with pkgs; [
      google-chrome-dev
      brave
    ];
  };

  services.flatpak.enable = true;
  xdg = {
    mime.enable = true;
    icons.enable = true;
    menus.enable = true;
    portal.enable = true;
    portal.extraPortals = [ pkgs.xdg-desktop-portal-wlr ];
  };

  hardware.bluetooth.enable = true;

  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
    extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];
  };

  security.rtkit.enable = true;
  # To use this disable pulseaudio and make sure
  # the user is in the audio group.
  services.pipewire = {
    enable = true;
    socketActivation = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    jack.enable = true;
    pulse.enable = true;
  };
}
