{
  programs.foot = {
    enable = true;
    server.enable = false;
    settings = {
      main = {
        font="VictorMono Nerd Font:size=11";
        font-bold="VictorMono Nerd Font:size=11:weight=bold";
        font-italic="VictorMono Nerd Font:size=11:slant=italic";
        font-bold-italic="VictorMono Nerd Font:size=11:slant=italic:weight=bold";
        pad="0x0 center";
        term="xterm-256color";
        shell="tmux";
      };
      mouse = {
        hide-when-typing = "yes";
      };
      colors = {
        alpha="1.0";
        foreground="ffffff";
        background="000000";
        regular0="000000"; # black
        regular1="ff8059"; # red
        regular2="00fc50"; # green
        regular3="eecc00"; # yellow
        regular4="29aeff"; # blue
        regular5="feacd0"; # magenta
        regular6="00d3d0"; # cyan
        regular7="eeeeee"; # white
        bright0="555555"; # bright black
        bright1="ffa0a0"; # bright red
        bright2="88cf88"; # bright green
        bright3="d2b580"; # bright yellow
        bright4="92baff"; # bright blue
        bright5="e0b2d6"; # bright magenta
        bright6="a0bfdf"; # bright cyan
        bright7="ffffff"; # bright white

        ## modus-operandi
        # alpha="1.0";
        # foreground="000000";
        # background="ffffff";
        # regular0="000000"; # black
        # regular1="a60000"; # red
        # regular2="006800"; # green
        # regular3="813e00"; # yellow
        # regular4="0030a6"; # blue
        # regular5="721045"; # magenta
        # regular6="00538b"; # cyan
        # regular7="eeeeee"; # white
        # bright0="555555"; # bright black
        # bright1="7f1010"; # bright red
        # bright2="104410"; # bright green
        # bright3="5f4400"; # bright yellow
        # bright4="002f88"; # bright blue
        # bright5="752f50"; # bright magenta
        # bright6="12506f"; # bright cyan
        # bright7="ffffff"; # bright white

        ## solarized dark
        # alpha="0.7";
        # background="002b36";
        # foreground="839496";
        # regular0="073642";
        # regular1="dc322f";
        # regular2="859900";
        # regular3="b58900";
        # regular4="268bd2";
        # regular5="d33682";
        # regular6="2aa198";
        # regular7="eee8d5";
        # bright0="002b36";
        # bright1="cb4b16";
        # bright2="586e75";
        # bright3="657b83";
        # bright4="839496";
        # bright5="6c71c4";
        # bright6="93a1a1";
        # bright7="fdf6e3";
      };
    };
  };
}
