function _my_colors
	set -l base03  002b36
	set -l base02  073642
	set -l base01  586e75
	set -l base00  657b83
	set -l base0   839496
	set -l base1   93a1a1
	set -l base2   eee8d5
	set -l base3   fdf6e3
	set -l yellow  b58900
	set -l orange  cb4b16
	set -l red     dc322f
	set -l magenta d33682
	set -l violet  6c71c4
	set -l blue    268bd2
	set -l cyan    2aa198
	set -l green   859900

	set colorfg $base03

	set -x color_initial_segment_exit     $base02 $red --bold
	set -x color_initial_segment_private  $base02 $base2
	set -x color_initial_segment_su       $base02 $green --bold
	set -x color_initial_segment_jobs     $base02 $blue --bold

	set -x color_path                     $base2 $base00
	set -x color_path_basename            $base2 $base01 --bold
	set -x color_path_nowrite             $base2 $orange
	set -x color_path_nowrite_basename    $base2 $orange --bold

	set -x color_repo                     $green $colorfg
	set -x color_repo_work_tree           $base2 $colorfg --bold
	set -x color_repo_dirty               $red $colorfg
	set -x color_repo_staged              $yellow $colorfg

	set -x color_vi_mode_default          $blue $colorfg --bold
	set -x color_vi_mode_insert           $green $colorfg --bold
	set -x color_vi_mode_visual           $yellow $colorfg --bold

	set -x color_vagrant                  $violet $colorfg --bold
	set -x color_k8s                      $green $colorfg --bold
	set -x color_aws_vault                $violet $base3 --bold
	set -x color_aws_vault_expired        $violet $orange --bold
	set -x color_username                 $base2 $blue --bold
	set -x color_hostname                 $base2 $blue
	set -x color_rvm                      $red $colorfg --bold
	set -x color_node                     $green $colorfg --bold
	set -x color_virtualfish              $cyan $colorfg --bold
	set -x color_virtualgo                $cyan $colorfg --bold
	set -x color_desk                     $cyan $colorfg --bold
	set -x color_nix                      $cyan $colorfg --bold
end
