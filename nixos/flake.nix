{
  description = "NixOS Configuration";

  inputs = {
    stable = { url = "github:nixos/nixpkgs/nixos-21.05"; };
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "master";
    };
    neovim = {
      url = "github:neovim/neovim?dir=contrib";
      inputs.nixpkgs.follows = "unstable";
    };
    emacs = { url="github:nix-community/emacs-overlay/master"; };
    master = { url = "github:NixOS/nixpkgs/master"; };
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
      inherit (unstable) lib;
      inherit (lib) removeSuffix hasSuffix;

      packagesOverlay = system: final: prev: {
        nnn = prev.nnn.overrideAttrs (oldAttrs: {
          makeFlags = oldAttrs.makeFlags ++ [ "O_NERD=1" ];
        });
      };

      overlays =
        system: [
          nur.overlay
          inputs.neovim.overlay
          inputs.emacs.overlay
          (packagesOverlay system)
        ];
    in
    {
      nixosConfigurations = {
        X542URR = stable.lib.nixosSystem {
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
    };
}
