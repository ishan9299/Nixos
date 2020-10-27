let
  lock = builtins.fromJSON (builtins.readFile ../flake.lock);
in
final: prev: {
  neovim-unwrapped = prev.neovim-unwrapped.overrideAttrs(old: {
    pname = "neovim-nightly";
    version = "nightly";
    src = prev.fetchFromGitHub {
      owner = lock.nodes.neovim.locked.owner;
      repo = lock.nodes.neovim.locked.repo;
      rev = lock.nodes.neovim.locked.rev;
      sha256 = lock.nodes.neovim.locked.narHash;
    };
  });
}
