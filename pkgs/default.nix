# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
pkgs: {
  plymouth-theme-jar-jar = pkgs.callPackage ./plymouth-theme-jar-jar.nix { };
  qman = pkgs.callPackage ./qman.nix { };

  # Fonts
  buildFontPackage = pkgs.callPackage ./fonts/generic { };
  rakkas-font = pkgs.callPackage ./fonts/rakkas-font.nix { };
  vollkorn-font = pkgs.callPackage ./fonts/vollkorn-font.nix { };
  fleuron-font = pkgs.callPackage ./fonts/fleuron-font.nix { };

}
