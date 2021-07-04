{
  description = "NixOS Configuration";

  inputs = {
    stable = { url = "github:nixos/nixpkgs/nixos-21.05"; };
    nixpkgs-wayland = { url = "github:colemickens/nixpkgs-wayland"; };
  };

  outputs =
    { self
    , stable
    , nixpkgs-wayland
    , ...
    }@inputs:
    {
      nixosConfigurations = {
        X542URR = stable.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            {
              nixpkgs.overlays = [ inputs.nixpkgs-wayland.overlay ];
            }
            ./hosts/X542URR/configuration.nix
          ];
          specialArgs = { inherit inputs; };
        };
      };

      X542URR = self.nixosConfigurations.X542URR.config.system.build.toplevel;
    };
}
