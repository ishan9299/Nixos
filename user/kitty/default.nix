{ config, pkgs, ... }: {
  xdg.configFile."kitty/themes/modus-operandi.conf".source =
    ./themes/modus-operandi.conf;
  xdg.configFile."kitty/themes/modus-vivendi.conf".source =
    ./themes/modus-vivendi.conf;
  programs.kitty = {
    enable = true;
    settings = {
      allow_remote_control = "yes";

      # cursor
      cursor_shape = "block";

      # font setting
      font_family = "agave regular Nerd Font Complete Mono";
      bold_font = "agave regular Nerd Font Complete Mono";
      italic_font = "agave regular Nerd Font Complete Mono";
      bold_italic_font = "agave regular Nerd Font Complete Mono";
      font_size = "17.0";

      # tab bar
      tab_bar_edge = "bottom";
      tab_bar_style = "fade";
      tab_bar_min_tabs = "2";
      active_tab_font_style = "bold";
      inactive_tab_font_style = "normal";

      # colorscheme
      include = "themes/modus-vivendi.conf";

      # transperency
      # background_opacity = "0.65";
      # dynamic_background_opacity = "yes";

      # layouts
      enabled_layouts = "tall,splits";

      # padding
      window_padding_width = "25";
      placement_strategy = "center";

      # Decorations
      hide_window_decorations = "yes";
    };
  };
}
