function __scheme_reset_to_default
	# Color values from: https://github.com/fish-shell/fish-shell/blob/82052a6cc9fa797070d8945130d45226d5cbc1c5/share/functions/__fish_config_interactive.fish#L51
	# normal
	set -g scheme_color_normal normal
	# commands
	set -g scheme_color_command 005fd7
	# quoted blocks of text
	set -g scheme_color_quote 999900
	# IO redirections
	set -g scheme_color_redirection 00afff
	# process separators like ';' and '&'
	set -g scheme_color_end 009900
	# potential errors
	set -g scheme_color_error ff0000
	# regular command parameters
	set -g scheme_color_param 00afff
	# code comments
	set -g scheme_color_comment 990000
	# parameter expansion operators like '*' and '~'
	set -g scheme_color_operator 00a6b2
	# character escapes like '\n' and '\x70'
	set -g scheme_color_escape 00a6b2
	# current working directory in the prompt
	set -g scheme_color_cwd green
	# current working directory in the prompt when superuser
	set -g scheme_color_cwd_root red
	# autosuggestions
	set -g scheme_color_autosuggestion 555
	# current username in the prompt
	set -g scheme_color_user brgreen
	# current host system in the prompt
	set -g scheme_color_host normal
	# '^C' indicator on a canceled command
	set -g scheme_color_cancel --reverse
	# valid path name
	set -g scheme_color_valid_path --underline
	# matching parenthesis
	set -g scheme_color_match --background=brblue
	# selected text (in vi visual mode)
	set -g scheme_color_selection white --bold --background=brblack
	# history search matches and the selected pager item (must be a background)
	set -g scheme_color_search_match bryellow --background=brblack
	# Additional for completion pager:
	# prefix string, i.e. the string that is to be completed
	set -g scheme_pager_color_prefix white --bold --underline
	# completion itself
	set -g scheme_pager_color_completion normal
	# completion description
	set -g scheme_pager_color_description B3A06D
	# progress bar at the bottom left corner
	set -g scheme_pager_color_progress brwhite --background=cyan
	# background color of the every second completion
	set -g scheme_pager_color_secondary
	# Additional for some commands:
	# current position out of `cdh` / `dirh` command
	set -g scheme_color_history_current --bold
end

function scheme
	switch ($argv)

		case 'modus-operandi'
			set -l background ffffff
			set -l foreground 000000
			set -l black   000000
			set -l red     a60000
			set -l green   006800
			set -l yellow  813e00
			set -l blue    0030a6
			set -l magenta 721045
			set -l cyan    00538b
			set -l white   eeeeee
			set -l comment 505050
			set -l magenta 5317ac
			set -l escape  654d0f
			__scheme_reset_to_default
			set -g scheme_color_command $magenta
			set -g scheme_color_quote $green
			set -g scheme_color_redirection $cyan
			set -g scheme_color_end $foreground
			set -g scheme_color_error $red
			set -g scheme_color_param $foreground
			set -g scheme_color_comment $comment
			set -g scheme_color_operator $foreground
			set -g scheme_color_escape $escape
			set -g scheme_color_cwd $blue
			set -g scheme_color_cwd_root $blue
			set -g scheme_color_autosuggestion $comment
			set -g scheme_color_user $green
			set -g scheme_color_host $foreground

		case 'modus-vivendi'
			set -l background 000000
			set -l foreground ffffff
			set -l black   000000
			set -l red     ff8059
			set -l green   00fc50
			set -l yellow  eecc00
			set -l blue    29aeff
			set -l magenta feacd0
			set -l cyan    00d3d0
			set -l white   eeeeee
			set -l comment 505050
			set -l magenta 5317ac
			set -l escape  654d0f
			__scheme_reset_to_default
			set -g scheme_color_command $magenta
			set -g scheme_color_quote $green
			set -g scheme_color_redirection $cyan
			set -g scheme_color_end $foreground
			set -g scheme_color_error $red
			set -g scheme_color_param $foreground
			set -g scheme_color_comment $comment
			set -g scheme_color_operator $foreground
			set -g scheme_color_escape $escape
			set -g scheme_color_cwd $blue
			set -g scheme_color_cwd_root $blue
			set -g scheme_color_autosuggestion $comment
			set -g scheme_color_user $green
			set -g scheme_color_host $foreground

		case 'solarized-dark'
			set -l background 002b36 # base03
			set -l foreground 839496 # base0
			set -l black   073642 # base02
			set -l red     dc322f # red
			set -l green   859900 # green
			set -l yellow  b58900 # yellow
			set -l blue    268bd2 # blue
			set -l magenta d33682 # magenta
			set -l cyan    2aa198 # cyan
			set -l white   eee8d5 # base2
			set -l comment 586e75 # comment
			__scheme_reset_to_default
			set -g scheme_color_command $yellow
			set -g scheme_color_quote $blue
			set -g scheme_color_redirection $cyan
			set -g scheme_color_end $cyan
			set -g scheme_color_error $red
			set -g scheme_color_param $blue
			set -g scheme_color_comment $comment
			set -g scheme_color_operator $green
			set -g scheme_color_escape $cyan
			set -g scheme_color_cwd $blue
			set -g scheme_color_cwd_root $blue
			set -g scheme_color_autosuggestion $comment
			set -g scheme_color_user $green
			set -g scheme_color_host $foreground

		case 'solarized-light'
			set -l background fdf6e3 # base3
			set -l foreground 657b83 # base00
			set -l black   073642 # base02
			set -l red     dc322f # red
			set -l green   859900 # green
			set -l yellow  b58900 # yellow
			set -l blue    268bd2 # blue
			set -l magenta d33682 # magenta
			set -l cyan    2aa198 # cyan
			set -l white   eee8d5 # base2
			__scheme_reset_to_default
			set -g scheme_color_command $yellow
			set -g scheme_color_quote $blue
			set -g scheme_color_redirection $cyan
			set -g scheme_color_end $cyan
			set -g scheme_color_error $red
			set -g scheme_color_param $blue
			set -g scheme_color_comment $comment
			set -g scheme_color_operator $green
			set -g scheme_color_escape $cyan
			set -g scheme_color_cwd $blue
			set -g scheme_color_cwd_root $blue
			set -g scheme_color_autosuggestion $comment
			set -g scheme_color_user $green
			set -g scheme_color_host $foreground

		end
end
