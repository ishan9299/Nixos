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
    ../../profiles/graphical
    # ../../profiles/nvidia
    ../../profiles/virt
  ];


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
  # boot.supportedFilesystems = [ "btrfs" ];
  boot.kernelPackages = pkgs.linuxPackages_latest;
  # intel_pstate for low performace fix
  boot.kernelParams = [
    "zswap.enabled=1"
    "intel_pstate=active"
  ];
  boot.cleanTmpDir = true;


  # Disable some services for faster boot
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
  # firmware
  hardware.enableAllFirmware = true;

  environment = {
    systemPackages = with pkgs; [
      alacritty
      bottles
      gimp
      gnome.dconf-editor
      gzdoom
      kid3
      lutris
      steam
      steam-run
      teams
      wine-staging
    ];
  };

  users.mutableUsers = false;
  users.users.me = {
    hashedPassword = "$6$CMk7rbvPy$hOhqC9C2Ud4JhH3SfCcHvqGzJja4vrONMU6fFDK62IeOJsAp5jR84kqcnDbkOGiZBjSCPvKGC8rss/wym47fz0";
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.fish;
  };

  i18n.defaultLocale = "en_US.UTF-8";
  time.timeZone = "Asia/Kolkata";

  services.postgresql.enable = true;

  # disable the wifi powersaving it is causes a lot of issus in the newer kernels
  networking = {
    hostName = hostname;
    wireless.iwd.enable = true;
    networkmanager = {
      enable = true;
      wifi.backend = "iwd";
      wifi.powersave = false;
    };
  };
  system.stateVersion = "21.05";
}
