{config, pkgs, ...}:

{

  programs.fish.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.me = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager"]; # Enable ‘sudo’ for the user.
    shell = pkgs.fish;
  };

  users.users.guest = {
    isNormalUser = true;
    extraGroups = [ "networkmanager" ];
    shell = pkgs.fish;
  };


  # Desktop Gnome3
  services.xserver.desktopManager.gnome3.enable = true;
  services.xserver.desktopManager.xterm.enable = false;
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
    lollypop
    ffmpeg
    gnome3.gnome-tweaks
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
    noto-fonts-emoji
    liberation_ttf
    google-fonts
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
