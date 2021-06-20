{
  description = "NixOS Configuration";

  inputs = {
    stable = { url = "github:nixos/nixpkgs/nixos-21.05"; };
  };

  outputs =
    { self
    , ...
    }@inputs:
    let
      inherit (builtins) attrNames attrValues readDir listToAttrs filter;
      inherit (unstable) lib;
      inherit (lib) removeSuffix hasSuffix;

    {
      nixosConfigurations = {
        X542URR = stable.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/X542URR/configuration.nix
          ];
          specialArgs = { inherit inputs; };
        };
      };

      X542URR = self.nixosConfigurations.X542URR.config.system.build.toplevel;
    };
}
