{ pkgs, inputs, config, lib, ... }:
let
  hostname = "X542URR";
  inherit (builtins) attrValues attrNames readDir;
in {
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
  boot.kernelPackages = pkgs.linuxPackages_zen;
  # boot.kernelModules = [ "kvm-intel" ];
  boot.kernelParams = [
    "zswap.enabled=1 quiet loglevel=3 rd.systemd.show_status=auto rd.udev.log_priority=3"
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

  nix = {
    binaryCachePublicKeys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
    binaryCaches = [
      "https://cache.nixos.org"
      "https://nixpkgs-wayland.cachix.org"
      "https://nix-community.cachix.org"
    ];
    extraOptions = ''
     binary-caches-parallel-connections = 3
     connect-timeout = 5
    '';
  };
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
      # krita
      shotwell
      contrast
      geany-with-vte
    ];
  };

  users.users.me = {
    isNormalUser = true;
    extraGroups = [ "wheel" "libvirtd" "networkmanager" "kvm" "audio" ];
    shell = pkgs.fish;
  };
}
