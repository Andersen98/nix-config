{
  stdenv,
  ncurses,
  pkg-config,
hinit,
inih,
ninja,
man-db,
pandoc,
python312,
cmake,
fetchFromGitHub,
lib,
meson,
zlib,
man-pages,
...
}:
stdenv.mkDerivation {
  pname = "qman";
  version = "1.1.0";
  src = fetchFromGitHub { owner = "plp13"; repo = "qman"; rev = "5559a2446f799d82eee74019ed424272df89f4b1"; hash ="sha256-NuyN5qEtH4ZIoTnbKEaam24J91yps2HyFSNKFQq6dUY="; };

  buildInputs = [
    ncurses
    pkg-config
    cmake
    (lib.getDev ncurses)
    (lib.getLib ncurses)
    (lib.getLib hinit)
    (lib.getDev hinit)
    (lib.getLib inih)
    (lib.getDev inih)
    ninja
    man-db
    (python312.withPackages (python-pkgs: with python-pkgs; [
      cogapp
    ]))
    man-pages
    zlib
    meson
    pandoc
  ];

  configurePhase = ''
    meson setup build/ src/
    cd build/
    meson configure -Dprefix="/"
  '';
  buildPhase = ''
    meson compile
  '';
  installPhase = ''
    meson install --destdir $out
  '';

}

