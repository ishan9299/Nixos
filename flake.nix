{
  description = "NixOS Configuration";

  inputs = {
    stable = { url = "github:nixos/nixpkgs/nixos-21.05"; };
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "master";
    };
    neovim = {
      url = "github:neovim/neovim?dir=contrib";
      inputs.nixpkgs.follows = "unstable";
    };
    emacs = { url="github:nix-community/emacs-overlay/master"; };
    master = { url = "github:NixOS/nixpkgs/master"; };
    unstable = { url = "github:NixOS/nixpkgs/nixos-unstable"; };
    nur = { url = "github:nix-community/NUR"; };
  };

  outputs =
    { self
    , emacs
    , home-manager
    , master
    , neovim
    , nur
    , stable
    , unstable
    , ...
    }@inputs:
    let
      inherit (builtins) attrNames attrValues readDir listToAttrs filter;
      inherit (unstable) lib;
      inherit (lib) removeSuffix hasSuffix;

      packagesOverlay = system: final: prev: {
        nnn = prev.nnn.overrideAttrs (oldAttrs: {
          makeFlags = oldAttrs.makeFlags ++ [ "O_NERD=1" ];
        });
      };

      overlays =
        system: [
          nur.overlay
          inputs.neovim.overlay
          inputs.emacs.overlay
          (packagesOverlay system)
        ];
    in
    {
      homeConfigurations = {
        linuxHomeConfig = inputs.home-manager.lib.homeManagerConfiguration {
          configuration = { pkgs, ... }:
            {
              xdg.configFile."nix/nix.conf".source = ./user/configs/nix/nix.conf;
              nixpkgs.config = import ./user/configs/nix/config.nix;
              nixpkgs.overlays = (overlays "x86_64-linux");
              imports = [
                ./user/awesome
                ./user/bat
                ./user/direnv
                ./user/fish
                ./user/foot
                ./user/fzf
                ./user/git
                ./user/kitty
                ./user/mpv
                ./user/packages.nix
                ./user/qutebrowser
                ./user/sway
                ./user/tmux
              ];
              xdg.configFile."gitui/key_config.ron".source = ./user/configs/gitui/key_config.ron;
              xdg.configFile."alacritty/alacritty.yml".source = ./user/configs/alacritty/alacritty.yml;
              xdg.configFile."musikcube/hotkeys.json".source = ./user/configs/musikcube/hotkeys.json;
              xdg.configFile."neofetch/config.conf".source = ./user/configs/neofetch/config.conf;
              home.stateVersion = "20.09";
            };
          system = "x86_64-linux";
          homeDirectory = "/home/me";
          username = "me";
        };

        nixosHomeConfig = inputs.home-manager.lib.homeManagerConfiguration {
          configuration = { pkgs, ... }:
            {
              xdg.configFile."nix/nix.conf".source = ./user/configs/nix/nix.conf;
              nixpkgs.config = import ./user/configs/nix/config.nix;
              nixpkgs.overlays = (overlays "x86_64-linux");
              imports = [
                ./user/awesome
                ./user/bat
                ./user/direnv
                ./user/fish
                ./user/foot
                ./user/fzf
                ./user/git
                ./user/kitty
                ./user/mpv
                ./user/packages.nix
                ./user/qutebrowser
                ./user/sway
                ./user/tmux
                ./user/xresources
              ];
              xdg.configFile."alacritty/alacritty.yml".source = ./user/configs/alacritty/alacritty.yml;
              xdg.configFile."awesome/rc.lua".source = ./user/configs/awesome/rc.lua;
              xdg.configFile."gitui/key_config.ron".source = ./user/configs/gitui/key_config.ron;
              xdg.configFile."musikcube/hotkeys.json".source = ./user/configs/musikcube/hotkeys.json;
              xdg.configFile."neofetch/config.conf".source = ./user/configs/neofetch/config.conf;
              home.stateVersion = "20.09";
            };
          system = "x86_64-linux";
          homeDirectory = "/home/me";
          username = "me";
        };
      };

      nixosConfigurations = {
        X542URR = stable.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/X542URR/configuration.nix
            {
              nixpkgs.overlays = (overlays "x86_64-linux");
            }
          ];
          specialArgs = { inherit inputs; };
        };
      };

      X542URR = self.nixosConfigurations.X542URR.config.system.build.toplevel;
      linuxHomeConfig = self.homeConfigurations.linuxHomeConfig.activationPackage;
      nixosHomeConfig = self.homeConfigurations.nixosHomeConfig.activationPackage;
    };
}
