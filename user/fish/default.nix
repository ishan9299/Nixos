{ pkgs, ... }:
{
  programs.fish = {
    enable = true;
    functions = {
      n = {
        wraps = "nnn";
        description = "support nnn quit and change directory";
        body = "${builtins.readFile ./n.fish}";
      };
    };
    interactiveShellInit = ''
      ${builtins.readFile ./fish_init.fish}
    '';
    plugins = [
      {
        name = "tide";
        src = pkgs.fetchFromGitHub {
          owner = "IlanCosman";
          repo = "tide";
          rev = "630ae9f7d93c5f53880e7d59ae4e61f6390b71a1";
          sha256 = "sha256-XTpkjQOdFXBO9NlEwOMX26bbuxojVmdtxDcfLKXFUdE=";
        };
      }
    ];
  };
}
