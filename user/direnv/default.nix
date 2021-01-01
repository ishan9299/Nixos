{
  programs.direnv = {
    enable = true;
    # programs.direnv.enableFishIntegration = true;
    # enableNixDirenvIntegration = true;
    # stdlib = "
    # use_flake() {
    #   watch_file flake.nix
    #   watch_file flake.lock
    #   eval "$(nix print-dev-env --profile "$(direnv_layout_dir)/flake-profile")"
    # }
    ";
  };
}
