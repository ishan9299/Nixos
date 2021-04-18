function fish_prompt
	set -l nix_shell_info (
	if test -n "$IN_NIX_SHELL"
		echo -n "❄️ nix-shell"
	end
	)
	set_color green --bold
	echo (tput bold)$USER@(hostname) on \[(date '+%Y-%m-%d %H:%M:%S')\] (prompt_pwd) "$nix_shell_info"
	echo -n '#: '(set_color normal)
end
