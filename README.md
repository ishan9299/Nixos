# NixOS Configuration

NixOS configuration using flakes.

# Installation

To build this config you will need 8GB or more space on the hard drive or the live disk.
The commands to do so are :-
```nix
nix-shell -p nixUnstable
nix build /mnt/etc/nixos#nixosConfigurations.<HOSTNAME>.config.system.build.toplevel --experimental-features "flakes nix-command" --store "/mnt" --impure
nixos-install --root /mnt --system ./result
```

To use home-manager
```nix
nix build /etc/nixos#homeConfigurations.nixosHomeConfig.activationPackage
./result/activate

or

nix build /etc/nixos#homeConfigurations.archHomeConfig.activationPackage
./result/activate
```

# Repository Layout
+ `user` - contains the home-manager configs all the configuration is automatically sourced to nixos config.
+ `overlays` - contains overlays for some packages.
+ `profiles`
  - `core` - aliases and settings for nix.
  - `develop` - packages I need for programming.
  - `graphical` - all the graphical packages that I use in my system.
    + `gnome`
  - `laptop` - stuff I need for my laptop.
  - `network` - networking stuff.
  - `virt` - kvm.

NOTE:
+ X542URR is my hostname change it accordingly.
+ If you have less space than 8GB in the live disk consider disabling some modules and commenting out some packages to reduce the size (I recommend disabling the graphical one in hosts/<HOSTNAME>/configuration.nix). Don't worry you can enable it after install.

# Other Nix configuration using flakes
- [nixcfg](https://github.com/colemickens/nixpkgs-wayland)
- [nixflk](https://github.com/nrdxp/nixflk)
- [nixrc](https://github.com/bqv/nixrc)
