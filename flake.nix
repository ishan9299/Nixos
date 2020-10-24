{
  description = "NixOS Configuration";

  inputs = {
    unstable = {
      url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    };
  };

  outputs = { self, unstable, ... }@inputs: {
    nixosConfigurations = {
      nixos = lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/x542ur/configuration.nix
          inputs.home-manager.nixosModules.home-manager
          (import ./hosts/x542ur/home/home.nix)
        ];
      };
    };
  };
}
