{ stdenvNoCC,
  lib,
  fetchFromGitHub,
  ...
}:

stdenvNoCC.mkDerivation {
      pname = "rakkas-font";
      version = "2.0.0";
      src = fetchFromGitHub {owner = "zeynepakay"; repo ="rakkas"; rev = "3bdb0ba164c9e987a5ab4de7f7cc8842a04d267a"; hash = "sha256-qprD7ao7Rtvzj2lqAu71wdNQ5A0qx796GCHkrlBL/B4=";};

      sourceRoot = ".";

      installPhase =
        let
          dirName = "Rakkas";
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
        description = ''
        Rakkas is single-weight display typeface that supports the Arabic and Latin scripts. The Arabic design is inspired by Ruq'ah lettering on Egyptian movie posters from the 50s and 60s, and makes use of contextual alternates to emulate the calligraphic style. It offers several different forms for many letter positions. For example, there are three different initial behs; depending on the proceeding letter, the approporiate allograph is shown. This increases the fidelity to the whimsy and fluidity of traditional Ruq'ah. Rakkas also cascades vertically, giving the user an opportunity to play with wordshaping.

        The Latin design infuses a blackletter design with informality. One of the things the Latin and Arabic have in common is the stroke that shapes each letter. In Arabic calligrapic traditions, the horizontal stroke is typically the thickest. The Latin design was initiated after the Arabic design was established, to be both visually complimentary and contextually relevant. This led to the Latin design's thick horizontal instrokes, seen in the lowercase a, and to the occasional moments where the traditional stroke contrast is reversed, as in the lowercase z. The Arabic dot marks are significantly smaller than what one might expect, as they do not share the thickness of the stroke. This was another quirk adopted from many of the lettering samples that were used as reference material. The Latin follows suit: Not only are the diacritics quite a bit smaller, but also many of the punctuation marks and symbols make use of the thin monolinear stroke. The result is two scripts united under a stylistic umbrella, neither pretending to be the other, and each interesting in its own right.

        The Rakkas project is led by Zeynep Akay, a type designer based in London, UK. To contribute, see github.com/zeynepakay/Rakkas
        '';
        license = "OFL-1.1";
        homepage = "https://github.com/zeynepakay/Rakkas";
        platforms = lib.platforms.all;
      };
    }

