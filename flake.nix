{
  description = "NixOS Configuration";

  inputs = {
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "unstable";
    };
    master = { url = "github:NixOS/nixpkgs/master"; };
    neovim = { url = "github:mjlbach/neovim-nightly-overlay"; };
    nix = { url = "github:nixos/nix"; };
    nixpkgs-wayland = {
      url = "github:colemickens/nixpkgs-wayland";
      inputs.nixpkgs.follows = "unstable";
    };
    stable = { url = "github:NixOS/nixpkgs/nixos-20.09"; };
    unstable = { url = "github:NixOS/nixpkgs/nixos-unstable"; };
    nur = { url = "github:nix-community/NUR"; };
  };

  outputs = { self, home-manager, master, neovim, nixpkgs-wayland, nur, stable
    , unstable, ... }@inputs:
    let
      inherit (builtins) attrNames attrValues readDir listToAttrs filter;
      inherit (unstable) lib;
      inherit (lib) removeSuffix recursiveUpdate genAttrs filterAttrs;
    in {
      X542URR = self.nixosConfigurations.X542URR.config.system.build.toplevel;

      # Automatically source the overlays directory
      # got this from https://github.com/bqv/nixrc/blob/live/flake.nix#L538
      overlays = listToAttrs (map (name: {
        name = lib.removeSuffix ".nix" name;
        value = import (./overlays + "/${name}");
      }) (filter (file: lib.hasSuffix ".nix" file)
        (attrNames (readDir ./overlays))));
      # Output
      ## { nnn = <<lambda>> @ /etc/nixos/overlays/nnn.nix; }

      overlay = import ./pkgs;

      nixosConfigurations = {
        X542URR = unstable.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/X542URR/configuration.nix
            {
              nixpkgs.overlays = attrValues self.overlays
                ++ [ neovim.overlay nixpkgs-wayland.overlay nur.overlay ]
                ++ [ (self.overlay) ];

              system.configurationRevision =
                unstable.lib.mkIf (self ? rev) self.rev;
            }
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users."me" = {
                # This automatically sources all the files in ./user
                imports = (map (name: ./user + "/${name}"))
                  (attrNames (readDir ./user));
              };
            }
          ];
        };
      };
    };
}
