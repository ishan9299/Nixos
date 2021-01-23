{ pkgs, inputs, config, lib, ... }:
let
  hostname = "X542URR";
  inherit (builtins) attrValues attrNames readDir;
in {
  imports = [
    ./hardware-configuration.nix
    ../../profiles/core
    ../../profiles/develop
    ../../profiles/graphical
    ../../profiles/laptop
    ../../profiles/network
    ../../profiles/virt
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
  boot.kernelPackages = pkgs.linuxPackages;
  boot.kernelModules = [ "kvm-intel" ];
  boot.kernelParams = [
    "zswap.enabled=1 quiet loglevel=3 rd.systemd.show_status=auto rd.udev.log_priority=3"
  ];
  boot.cleanTmpDir = true;

  nixpkgs.config.allowUnfree = true;

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
      catimg
      unzip
      nnn
      bpytop
      trash-cli
      ripgrep
      exa
      cava
      youtube-dl
      ffmpeg
      teams
      gimp
      krita
      shotwell
      contrast
      geany-with-vte
    ];
  };

  users.users.me = {
    isNormalUser = true;
    extraGroups = [ "wheel" "libvirtd" "networkmanager" "kvm" ];
    shell = pkgs.fish;
  };
}
