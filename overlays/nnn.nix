final: prev: {
  nnn = prev.nnn.overrideAttrs (oldAttrs: {
    makeFlags = oldAttrs.makeFlags ++ [ "O_NERD=1" ];
  });
}
