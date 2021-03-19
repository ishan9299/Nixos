{
  description = "NixOS Configuration";

  inputs = {
    emacs = { url = "github:nix-community/emacs-overlay/master"; };
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "master";
    };
    master = { url = "github:NixOS/nixpkgs/master"; };
    neovim = { url = "github:neovim/neovim?dir=contrib"; };
    # nix = { url = "github:nixos/nix"; };
    stable = { url = "github:NixOS/nixpkgs/nixos-20.09"; };
    unstable = { url = "github:NixOS/nixpkgs/nixos-unstable"; };
    nur = { url = "github:nix-community/NUR"; };
  };

  outputs =
    { self
    , emacs
    , home-manager
    , master
    , neovim
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
        nur.overlay
        emacs.overlay
        (packagesOverlay system)
      ];
    in
    {
      homeConfigurations = {
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
              home.stateVersion = "20.09";
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
            ./hosts/X542URR/configuration.nix
            {
              nixpkgs.overlays = (overlays "x86_64-linux");
            }
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.me = {
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
            }
          ];
          specialArgs = { inherit inputs; };
        };
      };

      X542URR = self.nixosConfigurations.X542URR.config.system.build.toplevel;
      archHomeConfig = self.homeConfigurations.archHomeConfig.activationPackage;

    };
}
