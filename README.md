# NixOS Configuration

This my NixOS configuration.

### IMPORTANT

If you use Nvidia then until NixOS 20.09 is released it is recommended to use `nixos-unstable`.

# DEFAULTS

The default settings in this configuration is :-

## Boot Loader
I use the systemd-boot you can also use grub with UEFI but systemd boot is the default. If you encrypt the drive with lvm then you need to read this part.
```
boot.initrd.luks.devices = {
  lvmcrypt = {
    device = "/dev/disk/by-uuid/801e3f5c-af8a-4b0e-9594-458638d9b12a";
  };
};
```
lvmcrypt is the name `/dev/mapper/[name]`. Device is the uuid of disk that is encrypted is /dev/sda2 was encrypted then `/dev/disk/by-uuid/{uuid-of-/dev/sda2}` is used.
## DESKTOP

  The default desktop in the configuration is Gnome. If you want to change it then you can :-  
```
services.xserver.desktopManager.gnome3.enable = false;
# For KDE
services.xserver.desktopManager.plasma5.enable = true;
services.xserver.displayManager.sddm.enable = true;
```
You can also use the pantheon desktop but if you want pantheon use stable as it possible pantheon would break in unstable and it won't be fixed until next stable is released.

## Browser
It uses the stable version of chromium with hardware acceleration patches. If you encounter problems in playing videos in Youtube disable
hardware-acceleration in settings. If you want to use the dev branch nix will have to compile it as cachix for this doesn't exist (it takes a long time for browser to compile).

## Virtualization
This configuration provides the KVM and virt-manager configured by default if you are a fan of window-manager you will need to enable dconf.
	programs.dconf.enable = true;
You will still encounter a issue where virt-manager isn't able to connect to qemu so launch with `virt-manager --connect qemu:///system`(Only need to do this once).

## GPU
By default I disable the Nvidia optimus you can add the `prime-offload` to have get the power-saving with the proprietary driver. For the people coming from ubuntu and fedora, Nix doesn't have the swithcheroo package so you will have to use the command line `nvidia-offload glxgears` to use an application with Nvidia.  
To enable it :-
```
# ./configuration.nix
	  imports =
	    [ # Include the results of the hardware scan.
	      ./hardware-configuration.nix ./desktop.nix ./overlays.nix ./nvidia-optimus.nix
	    ];
	hardware.nvidiaOptimus.disable = false;
```
You can also use Wayland with nvidia you will need the `modesetting` parameter to do so.
#### Warning
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
