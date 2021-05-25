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
    loginShellInit = ''
    ${builtins.readFile ./fish_profile.fish}
    '';
    interactiveShellInit = ''
    ${builtins.readFile ./fish_init.fish}
    '';
    # promptInit = ''
    # ${builtins.readFile ./fish_prompt.fish}
    # '';
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
  };
}
