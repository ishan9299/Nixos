{ pkgs, inputs, config, lib, ... }:
let
  hostname = "X542URR";
  inherit (builtins) attrNames readDir;
in {
  imports = [
    ./hardware-configuration.nix
    ../../profiles/core
    ../../profiles/develop
    ../../profiles/graphical
    ../../profiles/laptop
    ../../profiles/network
    ../../profiles/virt
    inputs.home-manager.nixosModules."home-manager"
  ];
  config = {

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
    boot.kernelModules = [ "kvm-intel" ];
    boot.cleanTmpDir = true;

    nixpkgs.config.allowUnfree = true;

    nixpkgs.overlays =
      [
        inputs.nixpkgs-wayland.overlay
        inputs.neovim.overlay
      ];

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

    # Using Zram will switch to zswap when I reinstall the system
    zramSwap = {
      enable = true;
      memoryPercent = 25;
    };

    users.users.me = {
      isNormalUser = true;
      extraGroups = [
        "wheel"
        "networkmanager"
        "libvirtd"
        "kvm"
      ]; # Enable ‘sudo’ for the user.
      shell = pkgs.fish;
    };

    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;
    home-manager.users."me" = {
      # This automatically sources all the files in ../../user
      imports =
        (map (name: ../../user + "/${name}")) (attrNames (readDir ../../user));
    };

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "20.09"; # Did you read the comment?
  };
}
