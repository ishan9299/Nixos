{ lib, pkgs, ... }: {
  users.defaultUserShell = pkgs.fish;

  programs.fish = {
    enable = true;
    promptInit = ''
      ${pkgs.starship}/bin/starship init fish | source
    '';
    interactiveShellInit = ''

      #------------ cd on quit for nnn -------------+

      function n --wraps nnn --description 'support nnn quit and change directory'
          # Block nesting of nnn in subshells
          if test -n "$NNNLVL"
              if [ (expr $NNNLVL + 0) -ge 1 ]
                  echo "nnn is already running"
                  return
              end
          end

          if test -n "$XDG_CONFIG_HOME"
              set -x NNN_TMPFILE "$XDG_CONFIG_HOME/nnn/.lastd"
          else
              set -x NNN_TMPFILE "$HOME/.config/nnn/.lastd"
          end

          nnn $argv

          if test -e $NNN_TMPFILE
              source $NNN_TMPFILE
              rm $NNN_TMPFILE
          end
      end
          '';
  };
}
