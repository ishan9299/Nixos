{ lib, pkgs, ... }: {
  users.defaultUserShell = pkgs.fish;

  programs.fish = {
    enable = true;
    promptInit = ''
      ${pkgs.starship}/bin/starship init fish | source
    '';
  };
}
