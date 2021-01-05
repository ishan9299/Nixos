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

# Repository Layout
+ `user` - contains the home-manager configs all the configuration is automatically sourced to nixos config.
+ `overlays` - contains overlays for some packages.
+ `profiles`
  - `core` - aliases and settings for nix.
  - `develop` - packages I need for programming.
  - `graphical` - all the graphical packages that I use in my system.
    + `gnome`
    + `sway`
    + `plasma`
  - `laptop` - stuff I need for my laptop.
  - `network` - networking stuff.
  - `virt` - kvm.

NOTE:
+ X542URR is my hostname change it accordingly.
+ If you have less space than 8GB in the live disk consider disabling some modules and commenting out some packages to reduce the size (I recommend disabling the graphical one in hosts/<HOSTNAME>/configuration.nix). Don't worry you can enable it after install.

# TODO
1. Add Dconf in home manager
Have gnome with same settings every time.

2. May be add the Neovim configuration in the NixOS configuration.
The system will use my Neovim configuration by default.

# Other Nix configuration using flakes
- [nixcfg](https://github.com/colemickens/nixpkgs-wayland)
- [nixflk](https://github.com/nrdxp/nixflk)
- [nixrc](https://github.com/bqv/nixrc)
