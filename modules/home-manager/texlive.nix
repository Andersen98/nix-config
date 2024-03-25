<<<<<<< HEAD
{ config, pkgs, ... }:
let
  tex = (pkgs.texlive.combine {
    inherit (pkgs.texlive) scheme-tetex
      dvisvgm dvipng # for preview and export as html
      latexmk # for compiling
      wrapfig amsmath ulem hyperref capt-of
      csquotes biblatex babel biber;
      #(setq org-latex-compiler "latexmk")
      #(setq org-preview-latex-default-process 'dvisvgm)
  });
in
{ # home-manager
  home.packages = with pkgs; [
    tex
    zathura
    okular
  ];
}

=======
{pkgs,...}:
{
  home.packages = with pkgs;[
    texlive.combined.scheme-tetex
  ];
}
>>>>>>> 3104fc2ff1323dda6e9686698664fb044d91b3de
