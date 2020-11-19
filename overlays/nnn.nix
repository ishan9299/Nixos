final: prev: {
  nnn = prev.nnn.overrideAttrs (oldAttrs: {
    src = prev.fetchFromGitHub {
      owner = "jarun";
      repo = "nnn";
      rev = "3.5";
      sha256 = "1fa7cmwrzn6kx87kms8i98p9azdlwyh2gnif29l340syl9hkr5qy";
    };
    makeFlags = oldAttrs.makeFlags ++ [ "O_NERD=1" ];
  });
}
