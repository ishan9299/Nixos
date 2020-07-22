{config, pkgs, ...}:

{
  # Desktop Gnome3
  services.xserver.desktopManager.gnome3.enable = true;
  services.xserver.displayManager = {
    lightdm.enable = false;
    gdm.enable = true;
  };
  
  # Touchpad
  services.xserver.libinput.enable = true;

  # Some packages for desktop use
  environment.systemPackages = with pkgs; [
    chromium
    blender
    ffmpeg
  ];

  #Excludepackages for gnome
  environment.gnome3.excludePackages = with pkgs; [
    gnome3.gnome-music
    gnome3.gnome-contacts
    gnome3.gnome-maps
    gnome3.totem
    gnome3.yelp
    gnome3.epiphany
    gnome3.eog
    gnome-photos
  ];

  # Fonts to install 
  fonts.fonts = with pkgs; [
    corefonts
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    source-code-pro
    source-sans-pro
    source-serif-pro
  ];

  # opengl for hardware acceleration for intel processors make chages accordingly for amd
  hardware = {
    opengl = {
      enable = true;
      extraPackages = with pkgs; [
        intel-media-driver
      ];
    };
  };

  # You will have to enable the flathub repo
  services.flatpak.enable = true ;
}
