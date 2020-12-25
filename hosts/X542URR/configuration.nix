{ pkgs, inputs, config, lib, ... }:
let hostname = "X542URR";
in {
  imports = [
    ./hardware-configuration.nix
    ../../profiles/core
    ../../profiles/develop
    ../../profiles/graphical
    ../../profiles/laptop
    ../../profiles/network
    ../../profiles/virt
    inputs.home-manager.nixosModules."home-manager"
  ];
  config = {
    home-manager.useGlobalPkgs = true;
    home-manager.useUserPackages = true;
    home-manager.users."me" = {
      # This automatically sources all the files in ../../user
      imports = (map (name: ../../user + "/${name}"))
        (attrNames (readDir ../../user));
    };
  };
}
