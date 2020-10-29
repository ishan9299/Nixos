{
  programs.mpv = {
    enable = true;
    config = {
      hwdec = auto;
      vo = gpu;
      gpu-context = wayland;
    };
  };
}
