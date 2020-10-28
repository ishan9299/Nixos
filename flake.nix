{
  description = "NixOS Configuration";

  inputs = {
    unstable = {
      url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "unstable";
    };
    neovim-overlay = {
      url = "github:neovim/neovim";
      flake = false;
    };
  };

  outputs = { self, unstable, home-manager, neovim-overlay, ... }@inputs:
    let
      inherit (builtins) attrNames attrValues readDir listToAttrs filter;
      inherit (unstable) lib;
      inherit (lib) removeSuffix recursiveUpdate genAttrs filterAttrs;

      pkgImport = pkgs:
        import pkgs {
          inherit system;
          overlays = attrValues self.overlays;
          config = { allowUnfree = true; };
        };

      pkgset = {
        pkgs = pkgImport unstable;
      };

      system = "x86_64-linux";
    in
    with pkgset;
  {
    nixos = self.nixosConfigurations.nixos.config.system.build.toplevel;

    # Automatically source the overlays directory
    # got this from https://github.com/bqv/nixrc/blob/live/flake.nix#L538
    overlays = listToAttrs (map (name: {
      name = lib.removeSuffix ".nix" name;
      value = import (./overlays + "/${name}");
    }) (filter (file: lib.hasSuffix ".nix" file) (attrNames (readDir ./overlays))));

    # Not Sure why is this required but the
    # template for nrdxp seems to do this
    # https://github.com/nrdxp/nixflk/blob/template/flake.nix#L57

    # packages."${system}" =
    #   let
    #     overlays = lib.filterAttrs (n: v: n != "pkgs") self.overlays;
    #     overlayPkgs =
    #       lib.genAttrs
    #         (attrNames overlays)
    #         (name: (overlays."${name}" pkgs pkgs)."${name}");
    #   in
    #   overlayPkgs;

    nixosConfigurations = {
      nixos = lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          (import ./hosts/x542ur/configuration.nix)
	  # (import ./home/profiles/neovim.nix)

	  # Home Manager
	  home-manager.nixosModules.home-manager
	  {
	    home-manager.useGlobalPkgs = true;
	    home-manager.useUserPackages = true;
	    home-manager.users.me = import ./home/home.nix;
	  }

	  # Overlays
	  {
	    nixpkgs.overlays = lib.attrValues self.overlays;
	  }
        ];
      };
    };
  };
}
