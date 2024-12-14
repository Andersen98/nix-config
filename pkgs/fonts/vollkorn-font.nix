{ stdenvNoCC,
  lib,
  fetchzip,
  ...
}:

stdenvNoCC.mkDerivation {
      pname = "vollkorn-font";
      version = "4.105";
      src = fetchzip { stripRoot = false; url = "http://vollkorn-typeface.com/download/vollkorn-4-105.zip"; hash = "sha256-oG79GgCwCavbMFAPakza08IPmt13Gwujrkc/NKTai7g="; };

      sourceRoot = ".";

      installPhase =
        let
          dirName = "Vollkorn";
        in
        ''
          runHook preInstall
          dst_opentype=$out/share/fonts/opentype/${dirName}
          dst_truetype=$out/share/fonts/truetype/${dirName}

          find -name \*.otf -exec mkdir -p $dst_opentype \; -exec cp -p {} $dst_opentype \;
          find -name \*.ttf -exec mkdir -p $dst_truetype \; -exec cp -p {} $dst_truetype \;

          runHook postInstall
        '';

      meta = {
        platforms = lib.platforms.all;
      };
    }

