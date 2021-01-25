{ lib, stdenv
, fetchFromGitHub
, meson
, ninja
, sassc
, gtk3
, inkscape
, optipng
, gtk-engine-murrine
, gdk-pixbuf
, librsvg
, python3
}:

stdenv.mkDerivation rec {
  pname = "WhiteSur-gtk-theme";
  version = "2021-01-15";

  src = fetchFromGitHub {
    owner = "vinceliuice";
    repo = "WhiteSur-gtk-theme";
    rev = "ccc7fbb467f7bdd9a39c5d1ec7030374b1ec46a8";
    sha256 = "0000000000000000000000000000000000000000000000000000";
  };

  nativeBuildInputs = [
    meson
    ninja
    sassc
    gtk3
    inkscape
    optipng
    python3
  ];

  buildInputs = [
    gdk-pixbuf
    librsvg
  ];

  propagatedUserEnvPkgs = [
    gtk-engine-murrine
  ];

  installPhase = ''
    patchShebangs .
    mkdir -p $out/share/themes
    name= ./install.sh -d $out/share/themes
    rm $out/share/themes/*/{AUTHORS,LICENSE}
  '';

  meta = with lib; {
    description = "Macos Big Sur gtk theme";
    homepage = "https://github.com/vinceliuice/WhiteSur-gtk-theme";
    license = with licenses; [ gpl3 ];
    platforms = platforms.linux;
    maintainers = with maintainers; [ ishan ];
  };
}
