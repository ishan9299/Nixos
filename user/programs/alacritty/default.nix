{
  programs.alacritty = {
    enable = true;
    settings = {
      env.TERM = "xterm-256color";
      window.decorations = "full";
      font.size = 13.0;
      cursor.style = "Underline";

      # modus vivendi theme
      colors = {
        # Default colors
        primary = {
          background = "#000000"; # bg
          foreground = "#ffffff"; # fg
        };

        cursor = {
          text = "#000000"; # bg
          cursor = "#ffffff"; # fg
        };

        # Normal colors
        normal = {
          black = "#000000";
          red = "#ff8059";
          green = "#00fc50";
          yellow = "#eecc00";
          blue = "#29aeff";
          magenta = "#feacd0";
          cyan = "#00d3d0";
          white = "#eeeeee";
        };

        # Bright colors [all the faint colors in the modus theme]
        bright = {
          black = "#555555";
          red = "#ffa0a0";
          green = "#88cf88";
          yellow = "#d2b580";
          blue = "#92baff";
          magenta = "#e0b2d6";
          cyan = "#a0bfdf";
          white = "#ffffff";
        };

        # dim [all the intense colors in modus theme]
        dim = {
          black = "#222222";
          red = "#fb6859";
          green = "#00fc50";
          yellow = "#ffdd00";
          blue = "#00a2ff";
          magenta = "#ff8bd4";
          cyan = "#30ffc0";
          white = "#dddddd";
        };

      };
    };
  };
}
