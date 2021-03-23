final: prev: {
  looking-glass-client = prev.looking-glass-client.overrideAttrs (oldAttrs: {
    version = "B3";
    src = fetchFromGitHub {
      owner = "gnif";
      repo = "LookingGlass";
      rev = version;
      sha256 = "0fnzf5xrlrgkficp8867kbw0alb1za86sl470hdyrasz7xvs195i";
      fetchSubmodules = true;
    };
  });
}
