{
  programs.i3status-rust.enable = true;
  programs.i3status-rust.bars.bottom = {
    settings = {
      theme = "slick";
      overrides = {
        idle_bg = "#2e3440";
        idle_fg = "#839496";
        separator = "";

      };
    };
    icons = "awesome";
    blocks = [
      {
        block = "memory";
        display_type = "memory";
        format_mem = "{mem_used_percents}";
        format_swap = "{swap_used_percents}";
      }
      {
        block = "cpu";
        format = "{utilization} {frequency}";
      }
      {
        block = "temperature";
        collapsed = false;
        interval = 1;
        format = "{max}";
        chip = "k10temp-*";
        idle = 70;
        info = 75;
        warning = 80;
      }
      {
        block = "sound";
        on_click = "pavucontrol";
      }
      {
        block = "networkmanager";
        on_click = "alacritty -e nmtui";
        interface_name_exclude = [ "br\\-[0-9a-f]{12}" "lxdbr\\d+" "lxcbr\\d+" ];
      }
      {
        block = "time";
        interval = 60;
        format = "%a %d/%m %R";
      }
    ];
  };
}
