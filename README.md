# NixOS Configuration

NixOS configuration using flakes.

# Installation

To build this config you will need 8GB or more space on the hard drive or the live disk.
The commands to do so are :-
```nix
nix-shell -p nixUnstable --run "nix build /mnt/etc/nixos#nixosConfigurations.X542URR.config.system.build.toplevel"
sudo nixos-install --root /mnt --system ./result
```
NOTE:
+ X542URR is my hostname change it accordingly.
+ If you have less space than 8GB in the live disk consider disabling some modules and commenting out some packages to reduce the size.

# TODO
1. Add Dconf in home manager
Have gnome with same settings every time.

2. May be add the Neovim configuration in the NixOS configuration.
The system will use my Neovim configuration by default.
