{
  pkgs,
  ...
}:
{
  imports = [
    ./b.nix
    ./kitty.nix
    ./starship.nix
  ];

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [

    #fonts
    #nerdfonts
    nerd-fonts.lilex
    nerd-fonts.noto
    nerd-fonts.hack
    nerd-fonts.mplus
    nerd-fonts.ubuntu
    nerd-fonts.ubuntu-sans
    nerd-fonts.ubuntu-mono
    nerd-fonts._3270
    nerd-fonts.arimo
    nerd-fonts.agave
    nerd-fonts.tinos
    nerd-fonts.liberation
    nerd-fonts.mononoki
    nerd-fonts.symbols-only
    nerd-fonts.terminess-ttf
    nerd-fonts.iosevka-term
    nerd-fonts.departure-mono #Nerd Fonts: A monospaced pixel font with a lo-fi, techy vibe
    nerd-fonts.overpass # Nerd Fonts: An open source font family inspired by Highway Gothic
    nerd-fonts.meslo-lg #Nerd Fonts: Slashed zeros, customized version of Apple's Menlo
    nerd-fonts.caskaydia-mono
    nerd-fonts.recursive-mono
    nerd-fonts.jetbrains-mono
    nerd-fonts.code-new-roman
    nerd-fonts.droid-sans-mono
    nerd-fonts.dejavu-sans-mono
    nerd-fonts.sauce-code-pro
    nerd-fonts.inconsolata-lgc
    nerd-fonts.proggy-clean-tt
    nerd-fonts.daddy-time-mono
    nerd-fonts.shure-tech-mono
    nerd-fonts.caskaydia-cove
    nerd-fonts.iosevka-term-slab
    nerd-fonts.comic-shanns-mono
    nerd-fonts.bigblue-terminal
    nerd-fonts.aurulent-sans-mono
    nerd-fonts.fantasque-sans-mono
    nerd-fonts.bitstream-vera-sans-mono
    # internet
    firefox

    # media
    vlc

    # xorg
    xclip
  ];
}

