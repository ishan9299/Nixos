# NixOS Configuration

This my NixOS configuration.

### IMPORTANT

If you use Nvidia then until NixOS 20.09 is released it is recommended to use `nixos-unstable`.

# DEFAULTS

The default settings in this configuration is :-

## DESKTOP
Default is Gnome. If you want to change it then you can :-  
```
services.xserver.desktopManager.gnome3.enable = false;
# For KDE
services.xserver.desktopManager.plasma5.enable = true;
services.xserver.displayManager.sddm.enable = true;
```
You can also use the pantheon desktop but if you want pantheon use stable as it possible pantheon would break in unstable and it won't be fixed until next stable is released.

## Browser
Default browser is Chrome. If you want privacy use tor.

## Virtualization
This configuration provides the KVM and virt-manager configured by default if you are a fan of window-manager you will need to enable dconf.
```
programs.dconf.enable = true;
```

## GPU
By default I disable the Nvidia optimus you can add the `prime-offload` to have get the power-saving with the proprietary driver. For the people coming from ubuntu and fedora, Nix doesn't have the swithcheroo package so you will have to use the command line `nvidia-offload glxgears` to use an application with Nvidia.  
To enable it :-
```
# ./configuration.nix
imports =
[ 
  # Include the results of the hardware scan.
  ./hardware-configuration.nix ./desktop.nix ./nvidia-optimus.nix
];
```

You can also use Wayland with nvidia you will need the `modesetting` parameter to do so.
#### NOTE
XWayland won't work so no gaming and X11 applications.
To enable it :-
```
./nvidia-optimus.nix
# For Gnome
services.xserver.displayManager.gdm.nvidiaWayland = true;
hardware.nvidia.modesetting.enable = true; # To use wayland with nvidia
services.xserver.displayManager.gdm.wayland = true;
```

# Important Links
- [Nvidia](https://nixos.wiki/wiki/Nvidia)
- [Hardware Acceleration](https://nixos.wiki/wiki/Accelerated_Video_Playback)
- [Virt-manager issue](https://github.com/NixOS/nixpkgs/issues/42433)
- [Learn nix & NixOS](https://nixos.org/learn.html)
