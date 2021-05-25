function fish_mode_prompt
end

function my_fish_mode_prompt
	switch $fish_bind_mode
		case default
			set_color --bold magenta
			echo '#:'
		case insert
			set_color --bold blue
			echo '#:'
		case replace_one
			set_color --bold red
			echo '#:'
		case visual
			set_color --bold cyan
			echo '#:'
		case '*'
			set_color --bold blue
			echo '#:'
	end
end

function fish_prompt
	set -l nix_shell_info (
	if test -n "$IN_NIX_SHELL"
		echo -n (set_color cyan --bold)"❄️ nix-shell"
	end
	)

	set -g __fish_git_prompt_show_informative_status 1
	set -g __fish_git_prompt_hide_untrackedfiles 1

	set -g __fish_git_prompt_color_branch red --bold
	set -g __fish_git_prompt_showupstream "informative"
	set -g __fish_git_prompt_char_upstream_ahead "↑"
	set -g __fish_git_prompt_char_upstream_behind "↓"
	set -g __fish_git_prompt_char_upstream_prefix ""

	set -g __fish_git_prompt_char_stagedstate "+"
	set -g __fish_git_prompt_char_dirtystate "!"
	set -g __fish_git_prompt_char_untrackedfiles "?"
	set -g __fish_git_prompt_char_conflictedstate "="
	set -g __fish_git_prompt_char_cleanstate ""

	set -g __fish_git_prompt_color_dirtystate red
	set -g __fish_git_prompt_color_stagedstate red
	set -g __fish_git_prompt_color_invalidstate red
	set -g __fish_git_prompt_color_untrackedfiles red
	set -g __fish_git_prompt_color_cleanstate green --bold

	set -g fish_prompt_pwd_dir_length 0

	set_color green --bold
	echo \
		 (tput bold)$USER@(hostname) \
		 (set_color normal --bold)'on' \
		 (set_color yellow --bold)\[(date '+%Y-%m-%d %H:%M:%S')\] \
		 (set_color cyan --bold)(prompt_pwd)\
		 (fish_git_prompt) \
		 "$nix_shell_info"
	echo -n (set_color magenta --bold)'#:'(set_color normal)
end
