navigate(){
	currentWorkspace=$(swaymsg -t get_workspaces |jq ".[] | select(.focused).num")
	case $1 in
		"next")
			num=$((currentWorkspace+1))
			[ $num -ge 11 ] && num=1
			swaymsg workspace number $num;;
		"prev")
			num=$((currentWorkspace-1))
			[ $num -le 0 ] && num=10
			swaymsg workspace number $num;;
	esac
}

move(){
	currentWorkspace=$(swaymsg -t get_workspaces |jq ".[] | select(.focused).num")
	case $1 in
		"next")
			num=$((currentWorkspace+1))
			[ $num -ge 11 ] && num=1
			swaymsg move container to workspace number $num && navigate $1;;
		"prev")
			num=$((currentWorkspace-1))
			[ $num -le 0 ] && num=10
			swaymsg move container to workspace number $num && navigate $1;;
	esac
}

case $1 in
	"navigate")
		case $2 in
			"next")
				navigate next;;
			"prev")
				navigate prev;;
		esac;;
	"move")
		case $2 in
			"next")
				move next;;
			"prev")
				move prev;;
		esac;;
esac
