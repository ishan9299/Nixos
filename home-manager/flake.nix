{
  description = "Home-Manager Configuration";

  inputs = {
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "master";
    };
    master = { url = "github:NixOS/nixpkgs/master"; };
    neovim = {
      url = "github:neovim/neovim?dir=contrib";
      inputs.nixpkgs.follows = "master";
    };
  };

  outputs = { self, master, home-manager, neovim }@inputs:
    let
      inherit (builtins) attrNames attrValues readDir listToAttrs filter;
      inherit (master) lib;
      inherit (lib) removeSuffix hasSuffix;

      packagesOverlay = system: final: prev: {
        nnn = prev.nnn.overrideAttrs (oldAttrs: {
          makeFlags = oldAttrs.makeFlags ++ [ "O_NERD=1" ];
        });
      };

      overlays =
        system: [
          inputs.neovim.overlay
          (packagesOverlay system)
        ];
    in
    {
      homeConfigurations = {
        linuxHomeConfig = inputs.home-manager.lib.homeManagerConfiguration {
          configuration = { pkgs, ... }:
            {
              xdg.configFile."nix/nix.conf".source = ./configs/nix/nix.conf;
              nixpkgs.config = import ./configs/nix/config.nix;
              nixpkgs.overlays = (overlays "x86_64-linux");
              imports = [
                # ./modules/awesome
                ./modules/bat
                ./modules/direnv
                ./modules/fish
                ./modules/foot
                ./modules/fzf
                ./modules/git
                ./modules/htop
                ./modules/kitty
                ./modules/mpv
                ./modules/packages.nix
                ./modules/qutebrowser
                ./modules/sway
                ./modules/tmux
                ./modules/xresources
              ];
              xdg.configFile."gitui/key_config.ron".source = ./configs/gitui/key_config.ron;
              xdg.configFile."alacritty/alacritty.yml".source = ./configs/alacritty/alacritty.yml;
              xdg.configFile."musikcube/hotkeys.json".source = ./configs/musikcube/hotkeys.json;
              xdg.configFile."neofetch/config.conf".source = ./configs/neofetch/config.conf;
              programs.home-manager.enable = true;
              programs.man.enable = false;
              home.stateVersion = "20.09";
            };
          system = "x86_64-linux";
          homeDirectory = "/home/me";
          username = "me";
        };

        nixosHomeConfig = inputs.home-manager.lib.homeManagerConfiguration {
          configuration = { pkgs, ... }:
            {
              xdg.configFile."nix/nix.conf".source = ./configs/nix/nix.conf;
              nixpkgs.config = import ./configs/nix/config.nix;
              nixpkgs.overlays = (overlays "x86_64-linux");
              imports = [
                # ./modules/awesome
                ./modules/bat
                ./modules/direnv
                ./modules/fish
                ./modules/foot
                ./modules/fzf
                ./modules/git
                ./modules/htop
                ./modules/kitty
                ./modules/mpv
                ./modules/packages.nix
                ./modules/qutebrowser
                ./modules/sway
                ./modules/tmux
                ./modules/xresources
              ];
              xdg.configFile."alacritty/alacritty.yml".source = ./configs/alacritty/alacritty.yml;
              xdg.configFile."awesome/rc.lua".source = ./configs/awesome/rc.lua;
              xdg.configFile."gitui/key_config.ron".source = ./configs/gitui/key_config.ron;
              xdg.configFile."musikcube/hotkeys.json".source = ./configs/musikcube/hotkeys.json;
              xdg.configFile."neofetch/config.conf".source = ./configs/neofetch/config.conf;
              programs.home-manager.enable = true;
              programs.man.enable = false;
              home.stateVersion = "20.09";
            };
          system = "x86_64-linux";
          homeDirectory = "/home/me";
          username = "me";
        };
      };
      linuxHomeConfig = self.homeConfigurations.linuxHomeConfig.activationPackage;
      nixosHomeConfig = self.homeConfigurations.nixosHomeConfig.activationPackage;
    };
}
