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
      font_family = "VictorMono Nerd Font";
      bold_font = "VictorMono Nerd Font";
      italic_font = "VictorMono Nerd Font";
      bold_italic_font = "VictorMono Nerd Font";
      font_size = "19.0";

      # tab bar
      tab_bar_edge = "bottom";
      tab_bar_style = "round";
      tab_bar_min_tabs = "2";
      tab_title_template = "{title[:10]}";
      active_tab_font_style = "bold";
      inactive_tab_font_style = "normal";

      # colorscheme
      include = "themes/modus-vivendi.conf";

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
