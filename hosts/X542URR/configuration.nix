{ pkgs, inputs, config, ... }:
let
  hostname = "X542URR";
  inherit (builtins) attrValues attrNames readDir;
in
{
  nixpkgs.config.allowUnfree = true;

  imports = [
    ./hardware-configuration.nix
    ../../profiles/core
    ../../profiles/develop
    ../../profiles/laptop
    ../../profiles/network
    ../../profiles/virt
    ../../profiles/graphical
  ];

  networking.hostName = hostname;

  # Use the systemd-boot EFI boot loader.
  boot.loader = {
    systemd-boot.enable = true;
    systemd-boot.consoleMode = "max";
    efi.canTouchEfiVariables = true;
    systemd-boot.configurationLimit = 5;
    timeout = 2;
    systemd-boot.editor = false;
  };

  boot.blacklistedKernelModules = [ "iTCO_wdt" ];
  boot.supportedFilesystems = [ "btrfs" ];
  boot.kernelPackages = pkgs.linuxPackages_latest;
  # intel_pstate for low performace fix
  boot.kernelParams = [
    "zswap.enabled=1"
    "intel_pstate=active"
  ];
  boot.cleanTmpDir = true;


  # Diable some services for faster boot
  systemd.services.systemd-udev-settle.enable = false;
  systemd.services.NetworkManager-wait-online.enable = false;
  # settings for journalctl as it can reduce the boot speed by alot upto 20secs in my case
  services.journald.extraConfig = ''
    Storage=volatile
    SystemMaxFileSize=50M
    SystemMaxFiles=5
  '';

  # microcode
  hardware.cpu.intel.updateMicrocode = true;

  environment = {
    systemPackages = with pkgs; [
      tree
      lshw
      dmidecode
      catimg
      unzip
      nnn
      cmatrix
      bottom
      trash-cli
      ripgrep
      exa
      cava
      emacs
      youtube-dl
      ffmpeg
      teams
      gimp
      bless
      # krita
      kid3
      shotwell
      steam
      qbittorrent
      unrar
      steam-run
      gzdoom
    ];
  };


  users.users.me = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "audio" "video" ];
    shell = pkgs.fish;
  };

  services.earlyoom.enable = true;

  system.stateVersion = "21.03";
}
