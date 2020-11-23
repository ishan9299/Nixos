{
programs.kitty = {
  enable = true;
  settings = {
    term = "xterm-kitty";
    allow_remote_control = "yes";

    # font setting
    font_family = "Iosevka Term Nerd Font Complete";
    bold_font = "Iosevka Term Bold Nerd Font Complete";
    italic_font = "Iosevka Term Italic Nerd Font Complete";
    bold_italic_font = "Iosevka Term Bold Italic Nerd Font Complete";
    font_size = "15.0";

    # tab bar
    tab_bar_edge = "bottom";
    tab_bar_style = "powerline";
    tab_bar_min_tabs = "2";
    tab_switch_stratergy = "previous";

    # colorscheme (used the dull and bright colors from alacritty.yml)
    foreground = "#000000";
    background = "#ffffff";

    ## cursor
    cursor = "#000000";
    cursor_shape = "underline";

    ## black
    color0 = "#555555";
    color8 = "#222222";

    ## red
    color1 = "#7f1010";
    color9 = "#b60000";

    ## green
    color2 = "#104410";
    color10 = "#006800";

    ## yellow
    color3 = "#5f4400";
    color11 = "#904200";

    ## blue
    color4 = "#002f88";
    color12 = "#1111ee";

    ## magenta
    color5 = "#752f50";
    color13 = "#7000e0";

    ## cyan
    color6 = "#12506f";
    color14 = "#205b93";

    ## white
    color7 = "#ffffff";
    color15 = "#dddddd";
  };
};
}
