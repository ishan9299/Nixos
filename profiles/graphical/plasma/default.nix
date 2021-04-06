{ config, pkgs, ... }: {
# Plasma Desktop
	services.xserver = {
		enable = true;
		layout = "us";
		desktopManager = {
			plasma5.enable = true;
		};
		displayManager = {
			sddm.enable = true;
		};
	};
}
