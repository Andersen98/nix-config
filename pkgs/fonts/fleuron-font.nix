{ stdenvNoCC,
  lib,
  fetchzip,
  ...
}:

stdenvNoCC.mkDerivation {
      pname = "fleuron-font";
      version = "1.0.0";
  #src = fetchFromGitHub {owner = "mickaelemile"; repo ="fleuron"; rev = "70c8e6a7e76ab64124ea980acc81328e088cbbff"; hash = "sha256-hWWLjl1fufNwTOP0e/kozrENh4eZnvsjI/Xn71towWk=";};
  src = fetchzip  { stripRoot = false; url = "https://raw.githubusercontent.com/mickaelemile/fleuron/70c8e6a7e76ab64124ea980acc81328e088cbbff/Fleuron.zip"; hash = "sha256-8qcox3aF98Y6wNjxHFg5Bu4LJ9OKWihwnrSLeiuDVx0=";};
      
      
      installPhase =
        let
          dirName = "Fleuron";
        in
        ''
          cd fonts
          runHook preInstall
          dst_opentype=$out/share/fonts/opentype/${dirName}
          dst_truetype=$out/share/fonts/truetype/${dirName}

          find -name \*.otf -exec mkdir -p $dst_opentype \; -exec cp -p {} $dst_opentype \;
          find -name \*.ttf -exec mkdir -p $dst_truetype \; -exec cp -p {} $dst_truetype \;

          runHook postInstall
        '';

      meta = {
        description = ''
      a font
        '';
        homepage = "https://github.com/mickaelemile/fleuron/";
        platforms = lib.platforms.all;
      };
    }

