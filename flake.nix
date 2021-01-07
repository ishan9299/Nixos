{
  description = "NixOS Configuration";

  inputs = {
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "unstable";
    };
    master = { url = "github:NixOS/nixpkgs/master"; };
    neovim = { url = "github:mjlbach/neovim-nightly-overlay"; };
    nixpkgs-wayland = {
      url = "github:colemickens/nixpkgs-wayland";
      inputs.nixpkgs.follows = "unstable";
    };
    stable = { url = "github:NixOS/nixpkgs/nixos-20.09"; };
    unstable = { url = "github:NixOS/nixpkgs/nixos-unstable"; };
    iceberg.url = "github:icebox-nix/iceberg";
  };

  outputs = { self, home-manager, master, neovim, nixpkgs-wayland, stable
    , unstable, iceberg, ... }@inputs:
    let
      inherit (builtins) attrNames attrValues readDir listToAttrs filter;
      inherit (unstable) lib;
      inherit (lib) removeSuffix recursiveUpdate genAttrs filterAttrs;

      mkSystem = sys: pkgs_: hostname:
        pkgs_.lib.nixosSystem {
          system = sys;
          modules = [ (./. + "/hosts/${hostname}/configuration.nix") ];
          specialArgs = { inherit inputs; };
        };
    in {
      X542URR = self.nixosConfigurations.X542URR.config.system.build.toplevel;

      # Automatically source the overlays directory
      # got this from https://github.com/bqv/nixrc/blob/live/flake.nix#L538
      overlays = listToAttrs (map (name: {
        name = lib.removeSuffix ".nix" name;
        value = import (./overlays + "/${name}");
      }) (filter (file: lib.hasSuffix ".nix" file)
        (attrNames (readDir ./overlays))));

        # overlay = import ./pkgs;

      nixosConfigurations = {
        X542URR = mkSystem "x86_64-linux" unstable "X542URR";
      };
    };
}
