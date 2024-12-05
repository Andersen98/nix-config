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

    # internet
    firefox

    # media
    vlc

    # xorg
    xclip
  ];
}

