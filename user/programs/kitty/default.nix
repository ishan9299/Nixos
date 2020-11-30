{ config, libs, pkgs, ... }:
{
  xdg.configFile."kitty/themes/modus-operandi.conf".source = ./themes/modus-operandi.conf;
  xdg.configFile."kitty/themes/modus-vivendi.conf".source = ./themes/modus-vivendi.conf;
  programs.kitty = {
    enable = true;
    settings = {
      allow_remote_control = "yes";

      # font setting
      font_family = "Iosevka Term Nerd Font Complete";
      bold_font = "Iosevka Term Bold Nerd Font Complete";
      italic_font = "Iosevka Term Italic Nerd Font Complete";
      bold_italic_font = "Iosevka Term Bold Italic Nerd Font Complete";
      font_size = "15.0";

      # tab bar
      tab_bar_edge = "bottom";
      tab_bar_style = "fade";
      tab_bar_min_tabs = "2";
      tab_switch_stratergy = "previous";
      active_tab_font_style = "bold-italic";
      inactive_tab_font_style = "normal";

      # colorscheme
      include = "themes/modus-vivendi.conf";

      # transperency
      background_opacity = "0.8";
      dynamic_background_opacity = "yes";
    };
  };
}
