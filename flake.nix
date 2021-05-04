{
  description = "NixOS Configuration";

  inputs = {
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "unstable";
    };
    neovim = { url = "github:neovim/neovim?dir=contrib"; };
    unstable = { url = "github:NixOS/nixpkgs/nixos-unstable"; };
    nur = { url = "github:nix-community/NUR"; };
  };

  outputs =
    { self
    , home-manager
    , neovim
    , nur
    , unstable
    , ...
    }@inputs:
    let
      inherit (builtins) attrNames attrValues readDir listToAttrs filter;
      inherit (unstable) lib;
      inherit (lib) removeSuffix hasSuffix;

      packagesOverlay = system: final: prev: {
        nnn = prev.nnn.overrideAttrs (oldAttrs: {
          makeFlags = oldAttrs.makeFlags ++ [ "O_NERD=1" ];
        });

        vivaldi = prev.vivaldi.overrideAttrs (oldAttrs: rec {
          pname = "vivaldi";
          version = "3.8.2259.37-1";

          src = prev.fetchurl {
            url = "https://downloads.vivaldi.com/stable/vivaldi-stable_${version}_amd64.deb";
            sha256 = "sha256-RwR/+OLf7G88Ie1/vYTgoxiLhOZwFp7h2l5QU+VQ8dI=";
          };
        });
      };

      overlays =
        system: [
          nur.overlay
          inputs.neovim.overlay
          (packagesOverlay system)
        ];
    in
    {
      homeConfigurations = {
        archHomeConfig = inputs.home-manager.lib.homeManagerConfiguration {
          configuration = { pkgs, ... }:
            {
              imports = [
                ./user/bat
                ./user/direnv
                ./user/fzf
                ./user/git
                ./user/kitty
                ./user/mpv
                ./user/musikcube
                ./user/neofetch
                ./user/qutebrowser
              ];
              xdg.configFile."alacritty/alacritty.yml".source = ./user/alacritty/alacritty.yml;
              xdg.configFile."gitui/key_config.ron".source = ./user/gitui/key_config.ron;
              home.stateVersion = "20.09";
            };
          system = "x86_64-linux";
          homeDirectory = "/home/me";
          username = "me";
        };

        nixosHomeConfig = inputs.home-manager.lib.homeManagerConfiguration {
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
                ./user/qutebrowser
              ];
              xdg.configFile."gitui/key_config.ron".source = ./user/gitui/key_config.ron;
              home.stateVersion = "20.09";
            };
          system = "x86_64-linux";
          homeDirectory = "/home/me";
          username = "me";
        };
      };

      nixosConfigurations = {
        X542URR = unstable.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/X542URR/configuration.nix
            {
              nixpkgs.overlays = (overlays "x86_64-linux");
            }
          ];
          specialArgs = { inherit inputs; };
        };
      };

      X542URR = self.nixosConfigurations.X542URR.config.system.build.toplevel;
      archHomeConfig = self.homeConfigurations.archHomeConfig.activationPackage;
      nixosHomeConfig = self.homeConfigurations.nixosHomeConfig.activationPackage;
    };
}
