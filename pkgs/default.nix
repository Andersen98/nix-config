# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
pkgs: {
  # example = pkgs.callPackage ./example { };
  plymouth-theme-jar-jar = pkgs.callPackage ./plymouth-theme-jar-jar.nix { };
  rakkas-font = pkgs.callPackage ./rakkas-font.nix { };
  vollkorn-font = pkgs.callPackage ./vollkorn-font.nix { };
  qman = pkgs.callPackage ./qman.nix { };
}
