let
  lock = builtins.fromJSON (builtins.readFile ../flake.lock);
  inherit (lock.nodes.neovim.locked) owner repo rev narHash;
in final: prev: {
  neovim-nightly = prev.neovim-unwrapped.overrideAttrs (old: {
    pname = "neovim-nightly";
    version = "${rev}";
    src = prev.fetchFromGitHub {
      owner = owner;
      repo = repo;
      rev = rev;
      sha256 = narHash;
    };
    buildInputs = old.buildInputs ++ [ prev.tree-sitter ];
  });
}
