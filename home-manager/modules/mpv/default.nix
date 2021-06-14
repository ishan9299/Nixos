{
  programs.mpv = {
    enable = true;
    config = {
      hwdec = "vaapi-copy";
    };
  };
}
