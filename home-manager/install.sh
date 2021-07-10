# pass the options nixosHomeConfig or linuxHomeConfig
mkdir -p $HOME/.config
ln -s $(pwd) $HOME/.config
nix-shell -p nixUnstable --command "nix build --experimental-features 'nix-command flakes' '.#$1'"
