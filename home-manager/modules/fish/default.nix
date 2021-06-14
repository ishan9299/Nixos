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
  };
}
