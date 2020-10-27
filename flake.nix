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
    neovim = {
      url = "github:neovim/neovim";
      flake = false;
    };
  };

  outputs = { self, unstable, home-manager, neovim, ... }@inputs:
  {
    nixos = self.nixosConfigurations.nixos.config.system.build.toplevel;

    overlays = {
      neovim = import ./overlays/neovim.nix;
    };

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
	  {nixpkgs.overlays = [self.overlays.neovim];}
	  unstable.nixosModules.notDetected
        ];
      };
    };
  };
}
