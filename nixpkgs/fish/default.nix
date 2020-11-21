{ lib, pkgs, ... }:
let inherit (builtins) readFile;
in {
  users.defaultUserShell = pkgs.fish;

  programs.fish = {
    enable = true;
    promptInit = ''
      ${pkgs.starship}/bin/starship init fish | source
    '';
    interactiveShellInit = ''

      #------------ cd on quit for nnn -------------+
      ${readFile ./functions/n.fish}
    '';
  };
}
