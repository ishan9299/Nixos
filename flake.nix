{
  description = "NixOS Configuration";

  inputs = {
    flake-utils = { url = "github:numtide/flake-utils"; };
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "unstable";
    };
    master = { url = "github:NixOS/nixpkgs/master"; };
    neovim = { url = "github:neovim/neovim?dir=contrib"; };
    nix = { url = "github:nixos/nix"; };
    nixpkgs-wayland = {
      url = "github:colemickens/nixpkgs-wayland";
      inputs.nixpkgs.follows = "unstable";
    };
    stable = { url = "github:NixOS/nixpkgs/nixos-20.09"; };
    unstable = { url = "github:NixOS/nixpkgs/nixos-unstable"; };
    nur = { url = "github:nix-community/NUR"; };
  };

  outputs =
    { self
    , flake-utils
    , home-manager
    , master
    , neovim
    , nixpkgs-wayland
    , nur
    , stable
    , unstable
    , ...
    }@inputs:
    let
      inherit (builtins) attrNames attrValues readDir listToAttrs filter;
      inherit (master) lib;
      inherit (lib) removeSuffix hasSuffix;

      packagesOverlay = system: final: prev: {
        neovim = inputs.neovim.defaultPackage."x86_64-linux";
        nnn = prev.nnn.overrideAttrs (oldAttrs: {
          makeFlags = oldAttrs.makeFlags ++ [ "O_NERD=1" ];
        });
      };

      overlays = system: [
        nixpkgs-wayland.overlay
        nur.overlay
        (packagesOverlay system)
      ];
    in
    {
      homeConfigurations = {
        nixosHomeConfig = home-manager.lib.homeManagerConfiguration {
          configuration = { pkgs, ... }:
            {
              imports = [
                ./user/alacritty
                ./user/bat
                ./user/direnv
                ./user/fzf
                ./user/git
                ./user/kitty
                ./user/mpv
                ./user/musikcube
                ./user/neofetch
              ];
            };
          system = "x86_64-linux";
          homeDirectory = "/home/me";
          username = "me";
        };

        archHomeConfig = home-manager.lib.homeManagerConfiguration {
          configuration = { pkgs, ... }:
            {
              imports = [
                ./user/alacritty
                ./user/bat
                ./user/direnv
                ./user/fzf
                ./user/git
                ./user/kitty
                ./user/mpv
                ./user/musikcube
                ./user/neofetch
              ];
            };
          system = "x86_64-linux";
          homeDirectory = "/home/me";
          username = "me";
        };
      };

      nixosConfigurations = {
        X542URR = master.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            home-manager.nixosModules.home-manager
            ./hosts/X542URR/configuration.nix
            {
              nixpkgs.overlays = (overlays "x86_64-linux");
            }
          ];
          specialArgs = { inherit inputs; };
        };
      };

      X542URR = self.nixosConfigurations.X542URR.config.system.build.toplevel;
      nixosHomeConfig = self.homeConfigurations.nixosHomeConfig.activationPackage;
      archHomeConfig = self.homeConfigurations.archHomeConfig.activationPackage;

    };
}
