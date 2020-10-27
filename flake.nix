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
  };

  outputs = { self, unstable, home-manager, ... }@inputs: {
    nixos = self.nixosConfigurations.nixos.config.system.build.toplevel;

    nixosConfigurations = {
      nixos = inputs.unstable.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/x542ur/configuration.nix
	  home-manager.nixosModules.home-manager
	  {
	    home-manager.useGlobalPkgs = true;
	    home-manager.useUserPackages = true;
	    home-manager.users.me = import ./home/home.nix;
	  }
	  unstable.nixosModules.notDetected
        ];
      };
    };
  };
}
