{
  description = "NixOS Configuration";

  inputs = {
    unstable = {
      url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
    };
  };

  outputs = { self, unstable, ... }@inputs: {
    nixosConfigurations = {
      nixos = lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/x542ur/configuration.nix
          inputs.unstable.lib.home-manager.nixosModules.home-manager
          (import ./hosts/x542ur/home/home.nix)
        ];
      };
    };
  };
}
