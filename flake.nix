{
  description = "NixOS Configuration";

  inputs = {
    master = { url = "github:NixOS/nixpkgs/nixpkgs-unstable"; };
    stable = { url = "github:NixOS/nixpkgs/nixos-20.09"; };
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "master";
    };
    neovim = {
      url = "github:neovim/neovim/master";
      flake = false;
    };
  };

  outputs = { self, master, stable, home-manager, neovim, ... }@inputs:
    let
      inherit (builtins) attrNames attrValues readDir listToAttrs filter;
      inherit (master) lib;
      inherit (lib) removeSuffix recursiveUpdate genAttrs filterAttrs;
    in {
      nixos = self.nixosConfigurations.nixos.config.system.build.toplevel;

      # Automatically source the overlays directory
      # got this from https://github.com/bqv/nixrc/blob/live/flake.nix#L538
      overlays = listToAttrs (map (name: {
        name = lib.removeSuffix ".nix" name;
        value = import (./overlays + "/${name}");
      }) (filter (file: lib.hasSuffix ".nix" file)
        (attrNames (readDir ./overlays))));

      nixosConfigurations = {
        nixos = lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            (import ./configuration.nix)
            (import ./nixpkgs/core.nix)
            (import ./nixpkgs/fish)
            (import ./nixpkgs/graphical)
            (import ./nixpkgs/nvidia)
            (import ./nixpkgs/tmux)
            (import ./nixpkgs/virtualization)

            # Home Manager
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users."me" = {
                # This automatically sources all the files in ./user/programs
                imports = (map (name: ./user/programs + "/${name}"))
                  (attrNames (readDir ./user/programs));
              };
            }

            # Overlays
            { nixpkgs.overlays = lib.attrValues self.overlays; }
          ];
        };
      };
    };
}
