{ config, pkgs, lib, ... }:
{

  imports = [ ../../local/locale.nix ];

  environment = {

    shellAliases =
      let ifSudo = lib.mkIf config.security.sudo.enable;
      in
      {
        # quick cd
        ".." = "cd ..";
        "..." = "cd ../..";
        "...." = "cd ../../..";
        "....." = "cd ../../../..";

        # grep
        grep = "rg";
      };
  };

  nix = {
    maxJobs = 8;
    buildCores = 8;

    useSandbox = true;
    autoOptimiseStore = true;
    allowedUsers = [ "@wheel" ];
    trustedUsers = [ "root" "@wheel" ];
    extraOptions = ''
      experimental-features = nix-command flakes ca-references
      min-free = 536870912
      keep-outputs = true
      keep-derivations = true
      binary-caches-parallel-connections = 3
      connect-timeout = 5
    '';
    binaryCachePublicKeys = [
      "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
    binaryCaches = [
      "https://nixpkgs-wayland.cachix.org"
      "https://nix-community.cachix.org"
    ];
    package = pkgs.nixUnstable;
  };

  users.defaultUserShell = pkgs.fish;
  programs.fish = {
    enable = true;
  };
}
