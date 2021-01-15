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
    boot.kernelParams = [ "intel_pstate=active zswap.enabled=1 quiet loglevel=3 rd.systemd.show_status=auto rd.udev.log_priority=3" ];
    boot.cleanTmpDir = true;

    nixpkgs.config.allowUnfree = true;

    nixpkgs.overlays = attrValues inputs.self.overlays
      ++ [ inputs.nixpkgs-wayland.overlay inputs.neovim.overlay inputs.iceberg.overlay ];

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
        dbeaver
        gimp
        krita
        shotwell
        contrast
        geany-with-vte
      ];
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
    system.stateVersion = "21.03"; # Did you read the comment?
  };
}
